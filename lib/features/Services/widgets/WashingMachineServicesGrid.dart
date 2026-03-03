import 'package:flutter/material.dart';
import 'package:zencare/features/Services/widgets/ServiceCard.dart';

Widget WashingMachineServicesGrid({required Function(String) onServiceTap}) {
  final List<Map<String, String>> services = [
    {'title': 'Top Load Fully Automatic - Inspection', 'image': 'assets/WashingMachine/3.png'},
    {'title': 'Front Load Fully Automatic - Inspection', 'image': 'assets/WashingMachine/1.png'},
    {'title': 'Semi-Automatic - Inspection', 'image': 'assets/WashingMachine/2.png'},
    {'title': 'Washing Machine Installation', 'image': 'assets/WashingMachine/4.png'},
    {'title': 'Washing Machine Uninstallation', 'image': 'assets/WashingMachine/5.png'},
  ];

  return LayoutBuilder(
    builder: (context, constraints) {
      final screenWidth = MediaQuery.of(context).size.width;
      final isMobile = screenWidth < 768;
      final isTablet = screenWidth >= 768 && screenWidth < 1024;

      // Determine cross axis count and layout parameters based on screen size
      int crossAxisCount;
      double childAspectRatio;
      double horizontalPadding;
      double verticalPadding;
      double crossAxisSpacing;
      double mainAxisSpacing;

      if (isMobile) {
        // Mobile: 2 columns to accommodate 8 items better
        crossAxisCount = 2;
        childAspectRatio = 0.95;
        horizontalPadding = 16.0;
        verticalPadding = 20.0;
        crossAxisSpacing = 12.0;
        mainAxisSpacing = 16.0;
      } else if (isTablet) {
        // Tablet: 2 columns with much higher aspect ratio for full title visibility
        crossAxisCount = 2;
        childAspectRatio = 0.5; // Further increased to ensure full titles show
        horizontalPadding = 20.0;
        verticalPadding = 25.0;
        crossAxisSpacing = 12.0;
        mainAxisSpacing = 18.0;
      } else {
        // Desktop: 2 columns with higher aspect ratio for titles
        crossAxisCount = 2;
        childAspectRatio = 0.5; // Further increased for better title visibility
        horizontalPadding = 15.0;
        verticalPadding = 15.0;
        crossAxisSpacing = 15.0;
        mainAxisSpacing = 20.0;
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
                crossAxisSpacing: crossAxisSpacing,
                mainAxisSpacing: mainAxisSpacing,
                childAspectRatio: childAspectRatio,
              ),
              itemCount: services.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // print('Tapped on: ${services[index]['title']}'); // Debug print
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