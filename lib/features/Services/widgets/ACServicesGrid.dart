import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zencare/features/Services/widgets/ServiceCard.dart';

Widget ACServiceGrid({required Function(String) onServiceTap}) {
  final List<Map<String, String>> services = [
    {'title': 'Foam-jet service (2 ACs)', 'image': 'assets/AC_Service/ACService1.png'},
    {'title': 'Gas Refill', 'image': 'assets/AC_Service/ACService2.png'},
    {'title': 'AC Installation', 'image': 'assets/AC_Service/ACService3.png'},
    {'title': 'AC Uninstallation', 'image': 'assets/AC_Service/ACService4.png'},
  ];

  return LayoutBuilder(
    builder: (context, constraints) {
      final screenWidth = MediaQuery.of(context).size.width;
      final isAndroid = defaultTargetPlatform == TargetPlatform.android;
      final isMobile = isAndroid || screenWidth < 768;
      final isTablet = !isAndroid && screenWidth >= 768 && screenWidth < 1024;

      // Determine cross axis count based on screen size and available width
      int crossAxisCount;
      double childAspectRatio;
      double horizontalPadding;
      double verticalPadding;

      if (isMobile) {
        crossAxisCount = 2;
        childAspectRatio = 0.85;
        horizontalPadding = 16.0;
        verticalPadding = 20.0;
      } else if (isTablet) {
        crossAxisCount = 2;
        // Optimized aspect ratio for tablet to show titles properly
        childAspectRatio = 0.95;
        horizontalPadding = 20.0;
        verticalPadding = 25.0;
      } else {
        // Desktop
        crossAxisCount = 2;
        childAspectRatio = 0.9;
        horizontalPadding = 30.0;
        verticalPadding = 30.0;
      }

      return Container(
        width: double.infinity,
        child: Card(
          surfaceTintColor: Colors.white,
          color: Colors.white,
          elevation: 1,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: isMobile ? 12 : 15,
                mainAxisSpacing: isMobile ? 16 : 20,
                childAspectRatio: childAspectRatio,
              ),
              itemCount: services.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    print('Tapped on: ${services[index]['title']}'); // Debug print
                    onServiceTap(services[index]['title']!);
                  },
                  behavior: HitTestBehavior.opaque, // This makes the entire area clickable
                  child: Container(
                    padding: EdgeInsets.all(isMobile ? 4 : 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade100),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade100,
                    ),
                    child: IgnorePointer(
                      // This prevents ServiceCard from consuming tap events
                      child: ServiceCard(
                        title: services[index]['title']!,
                        imageUrl: services[index]['image']!,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
    },
  );
}