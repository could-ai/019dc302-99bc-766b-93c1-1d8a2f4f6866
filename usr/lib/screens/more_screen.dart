import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildProfileHeader(context),
          const SizedBox(height: 24),
          _buildMenuSection(
            title: 'Study Tools',
            items: [
              _MenuItem(
                icon: Icons.note_alt_outlined,
                title: 'Quick Notes',
                subtitle: 'Save important points and formulas',
                color: Colors.amber,
              ),
              _MenuItem(
                icon: Icons.repeat,
                title: 'Revision Planner',
                subtitle: 'Automated spacing for better memory',
                color: Colors.blue,
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildMenuSection(
            title: 'Family',
            items: [
              _MenuItem(
                icon: Icons.family_restroom,
                title: 'Parent View',
                subtitle: 'Share progress with your parents',
                color: Colors.purple,
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildMenuSection(
            title: 'Settings',
            items: [
              _MenuItem(
                icon: Icons.settings_outlined,
                title: 'App Settings',
                color: Colors.grey,
              ),
              _MenuItem(
                icon: Icons.help_outline,
                title: 'Help & Support',
                color: Colors.grey,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 32,
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: const Text(
            'S',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Student Profile',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              'Class 10th - Science Track',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMenuSection({required String title, required List<_MenuItem> items}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        Card(
          margin: EdgeInsets.zero,
          child: Column(
            children: items.map((item) {
              return ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: item.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(item.icon, color: item.color),
                ),
                title: Text(item.title),
                subtitle: item.subtitle != null ? Text(item.subtitle!) : null,
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // Navigate to respective screens
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String title;
  final String? subtitle;
  final MaterialColor color;

  _MenuItem({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.color,
  });
}
