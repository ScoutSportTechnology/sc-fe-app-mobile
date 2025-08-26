import 'package:flutter/material.dart';
import 'device_scanner_page.dart';

enum SettingsItem {
  bluetoothDevices,
  videoAudio,
  overlay,
  streaming,
  storage,
  preferences,
  about,
}

const List<SettingsItem> _order = <SettingsItem>[
  SettingsItem.bluetoothDevices,
  SettingsItem.videoAudio,
  SettingsItem.overlay,
  SettingsItem.streaming,
  SettingsItem.storage,
  SettingsItem.preferences,
  SettingsItem.about,
];

typedef SettingRowItem = ({IconData icon, String label, Widget page});

final Map<SettingsItem, SettingRowItem> _settingsItems = {
  SettingsItem.bluetoothDevices: (
    icon: Icons.bluetooth,
    label: 'Bluetooth Devices',
    page: const DeviceScannerPage(),
  ),
  SettingsItem.videoAudio: (
    icon: Icons.videocam,
    label: 'Video & Audio',
    page: const Center(child: Text('Video & Audio')),
  ),
  SettingsItem.overlay: (
    icon: Icons.layers,
    label: 'Overlay',
    page: const Center(child: Text('Overlay')),
  ),
  SettingsItem.streaming: (
    icon: Icons.live_tv,
    label: 'Streaming',
    page: const Center(child: Text('Streaming')),
  ),
  SettingsItem.storage: (
    icon: Icons.storage,
    label: 'Storage',
    page: const Center(child: Text('Storage')),
  ),
  SettingsItem.preferences: (
    icon: Icons.settings_suggest_outlined,
    label: 'Preferences',
    page: const Center(child: Text('Preferences')),
  ),
  SettingsItem.about: (
    icon: Icons.info_outline,
    label: 'About',
    page: const Center(child: Text('About')),
  ),
};

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _order.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final item = _order[index];
          final settingsItem = _settingsItems[item];
          return ListTile(
            leading: Icon(settingsItem!.icon),
            title: Text(settingsItem.label),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => settingsItem.page),
              );
            },
          );
        },
      ),
    );
  }
}
