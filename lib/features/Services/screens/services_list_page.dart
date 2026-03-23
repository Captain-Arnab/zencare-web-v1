import 'package:flutter/material.dart';
import 'package:zencare/common/zen_care_scaffold.dart';

/// Android: List of all services for the Services bottom-nav tab.
class ServicesListPage extends StatelessWidget {
  const ServicesListPage({super.key});

  static const List<Map<String, String>> _services = [
    {'title': 'AC Service', 'route': '/ac-services', 'icon': 'assets/icons/home/1.png'},
    {'title': 'Refrigerator Repair', 'route': '/refrigerator-services', 'icon': 'assets/icons/home/2.png'},
    {'title': 'Home Cleaning', 'route': '/cleaning', 'icon': 'assets/icons/home/3.png'},
    {'title': 'Salon', 'route': '/salon', 'icon': 'assets/icons/home/4.png'},
    {'title': 'Pest Control', 'route': '/pest-control', 'icon': 'assets/icons/home/5.png'},
    {'title': 'Washing Machine Repair', 'route': '/washing-machine', 'icon': 'assets/icons/home/6.png'},
    {'title': 'Chimney Repair', 'route': '/chimney-repair', 'icon': 'assets/icons/home/7.png'},
    {'title': 'Water Purifier', 'route': '/water-purifier', 'icon': 'assets/icons/home/8.png'},
    {'title': 'Carpenter Service', 'route': '/carpenter-service', 'icon': 'assets/icons/home/9.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return ZenCareScaffold(
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: _services.length,
        itemBuilder: (context, index) {
          final s = _services[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: Image.asset(
                s['icon']!,
                width: 48,
                height: 48,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const Icon(Icons.build, size: 48),
              ),
              title: Text(
                s['title']!,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => Navigator.pushReplacementNamed(context, s['route']!),
            ),
          );
        },
      ),
    );
  }
}
