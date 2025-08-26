import 'package:flutter/material.dart';
import '../pages/device_scanner.dart' show MockDevice;

class DeviceTile extends StatelessWidget {
  const DeviceTile({
    super.key,
    required this.device,
    required this.onConnectToggle,
    required this.onMore,
  });

  final MockDevice device;
  final VoidCallback onConnectToggle;
  final VoidCallback onMore;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: _Avatar(rssi: device.rssi),
        title: Text(device.name),
        subtitle: Text('${device.id}  •  ${_signalLabel(device.rssi)}'),
        trailing: Wrap(
          spacing: 4,
          children: [
            FilledButton.tonal(
              onPressed: onConnectToggle,
              child: Text(device.connected ? 'Disconnect' : 'Connect'),
            ),
            IconButton(
              onPressed: onMore,
              icon: const Icon(Icons.more_vert),
              tooltip: 'More',
            ),
          ],
        ),
      ),
    );
  }

  String _signalLabel(int rssi) {
    if (rssi >= -55) return 'Signal: Excellent';
    if (rssi >= -65) return 'Signal: Good';
    if (rssi >= -75) return 'Signal: Fair';
    return 'Signal: Weak';
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.rssi});
  final int rssi;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final base = scheme.primary;
    final shade = base.withValues(alpha: 0.12);
    return CircleAvatar(
      backgroundColor: shade,
      foregroundColor: base,
      child: Icon(_iconForRssi(rssi)),
    );
  }

  IconData _iconForRssi(int rssi) {
    if (rssi >= -55) return Icons.network_wifi_3_bar; // strongest
    if (rssi >= -65) return Icons.network_wifi_2_bar;
    if (rssi >= -75) return Icons.network_wifi_1_bar;
    return Icons.network_wifi_1_bar_sharp; // weakest-ish
  }
}
