import 'package:flutter/material.dart';
import '../widgets/device_tile.dart';

class DeviceScannerPage extends StatefulWidget {
  const DeviceScannerPage({super.key});

  @override
  State<DeviceScannerPage> createState() => _DeviceScannerPageState();
}

class _DeviceScannerPageState extends State<DeviceScannerPage> {
  bool scanning = false;
  bool bluetoothOn = true; // mock toggle
  bool permissionGranted = true; // mock toggle
  String query = '';

  // Mock data
  List<MockDevice> saved = <MockDevice>[
    const MockDevice(
      name: 'CAM-Home',
      id: 'E2:91:AA:10:7C',
      rssi: -48,
      connected: false,
    ),
  ];
  List<MockDevice> nearby = <MockDevice>[
    const MockDevice(
      name: 'CAM-Field',
      id: 'D3:5F:7B:99:12',
      rssi: -62,
      connected: false,
    ),
    const MockDevice(
      name: 'Unknown',
      id: 'A0:0B:12:34:56',
      rssi: -81,
      connected: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    final filteredSaved = saved.where((d) => _matches(d, query)).toList();
    final filteredNearby = nearby.where((d) => _matches(d, query)).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bluetooth devices'),
        actions: [
          IconButton(
            tooltip: scanning ? 'Stop scan' : 'Start scan',
            onPressed: (bluetoothOn && permissionGranted)
                ? () => setState(() => scanning = !scanning)
                : null,
            icon: scanning
                ? const Icon(Icons.stop_circle_outlined)
                : const Icon(Icons.search),
          ),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Status chips (mock toggles for now)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              FilterChip(
                label: Text(bluetoothOn ? 'Bluetooth: On' : 'Bluetooth: Off'),
                selected: !bluetoothOn,
                onSelected: (_) => setState(() => bluetoothOn = !bluetoothOn),
                avatar: Icon(
                  bluetoothOn ? Icons.bluetooth : Icons.bluetooth_disabled,
                ),
              ),
              FilterChip(
                label: Text(
                  permissionGranted
                      ? 'Permission: Granted'
                      : 'Permission: Needed',
                ),
                selected: !permissionGranted,
                onSelected: (_) =>
                    setState(() => permissionGranted = !permissionGranted),
                avatar: Icon(
                  permissionGranted ? Icons.verified_user : Icons.lock,
                ),
              ),
              FilterChip(
                label: Text(scanning ? 'Scanning…' : 'Idle'),
                selected: scanning,
                onSelected: (_) {
                  if (bluetoothOn && permissionGranted) {
                    setState(() => scanning = !scanning);
                  }
                },
                avatar: const Icon(Icons.refresh),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Search
          TextField(
            onChanged: (v) => setState(() => query = v),
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search devices',
            ),
          ),

          const SizedBox(height: 16),

          // Saved devices
          if (filteredSaved.isNotEmpty) ...[
            Text('Saved devices', style: text.titleMedium),
            const SizedBox(height: 8),
            for (final d in filteredSaved)
              DeviceTile(
                device: d,
                onConnectToggle: () => _toggleConnection(d, inSaved: true),
                onMore: () => _showDeviceMenu(d, inSaved: true),
              ),
            const SizedBox(height: 16),
          ],

          // Nearby devices
          Text('Nearby', style: text.titleMedium),
          const SizedBox(height: 8),

          if (!bluetoothOn)
            _InlineBanner(
              icon: Icons.bluetooth_disabled,
              text: 'Bluetooth is off. Turn it on to scan for devices.',
              color: scheme.error,
            )
          else if (!permissionGranted)
            _InlineBanner(
              icon: Icons.lock,
              text: 'Permission is required to discover nearby devices.',
              color: scheme.tertiary,
            )
          else if (filteredNearby.isEmpty)
            _EmptyState(
              title: scanning ? 'Scanning…' : 'No devices found',
              tips: const [
                'Move closer to the device',
                'Make sure the device is powered on',
                'Check that the device is in pairing mode',
              ],
            )
          else
            for (final d in filteredNearby)
              DeviceTile(
                device: d,
                onConnectToggle: () => _toggleConnection(d),
                onMore: () => _showDeviceMenu(d),
              ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  bool _matches(MockDevice d, String q) {
    if (q.isEmpty) return true;
    final s = q.toLowerCase();
    return d.name.toLowerCase().contains(s) || d.id.toLowerCase().contains(s);
  }

  void _toggleConnection(MockDevice d, {bool inSaved = false}) {
    setState(() {
      final list = inSaved ? saved : nearby;
      final idx = list.indexWhere((x) => x.id == d.id);
      if (idx >= 0)
        list[idx] = list[idx].copyWith(connected: !list[idx].connected);
    });
  }

  void _showDeviceMenu(MockDevice d, {bool inSaved = false}) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (_) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            if (!inSaved)
              ListTile(
                leading: const Icon(Icons.push_pin_outlined),
                title: const Text('Remember device'),
                subtitle: const Text('Keep in Saved devices'),
                onTap: () {
                  setState(() {
                    // move from nearby → saved
                    nearby.removeWhere((x) => x.id == d.id);
                    saved.add(d);
                  });
                  Navigator.pop(context);
                },
              ),
            if (inSaved)
              ListTile(
                leading: const Icon(Icons.delete_outline),
                title: const Text('Forget device'),
                onTap: () {
                  setState(() => saved.removeWhere((x) => x.id == d.id));
                  Navigator.pop(context);
                },
              ),
          ],
        ),
      ),
    );
  }
}

// Simple UI model for mock data
class MockDevice {
  const MockDevice({
    required this.name,
    required this.id,
    required this.rssi,
    required this.connected,
  });

  final String name;
  final String id;
  final int rssi; // e.g., -40 (strong) to -90 (weak)
  final bool connected;

  MockDevice copyWith({String? name, String? id, int? rssi, bool? connected}) {
    return MockDevice(
      name: name ?? this.name,
      id: id ?? this.id,
      rssi: rssi ?? this.rssi,
      connected: connected ?? this.connected,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MockDevice && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class _InlineBanner extends StatelessWidget {
  const _InlineBanner({
    required this.icon,
    required this.text,
    required this.color,
  });
  final IconData icon;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 12),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.title, required this.tips});
  final String title;
  final List<String> tips;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: text.titleMedium),
          const SizedBox(height: 8),
          for (final t in tips)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 6),
                  child: Icon(Icons.circle, size: 6),
                ),
                const SizedBox(width: 8),
                Expanded(child: Text(t, style: text.bodyMedium)),
              ],
            ),
        ],
      ),
    );
  }
}
