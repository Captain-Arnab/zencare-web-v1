import 'package:flutter/material.dart';
import 'package:zencare/features/Services/widgets/ServiceCard.dart';

Widget ChimneyRepairServicesGrid({required Function(String) onServiceTap}) {
  final List<Map<String, String>> services = [
    {'title': 'Chimney Cleaning Service', 'image': 'assets/Chimneyservice/1.png'},
    {'title': 'Chimney Check-up', 'image': 'assets/Chimneyservice/2.png'},
    {'title': 'Chimney Motor Repair', 'image': 'assets/Chimneyservice/3.png'},
    {'title': 'Chimney Suction Power Issues', 'image': 'assets/Chimneyservice/4.png'},
    {'title': 'Chimney Fan/Blower Repair', 'image': 'assets/Chimneyservice/5.png'},
    {'title': 'Chimney Button/Control Panel Repair', 'image': 'assets/Chimneyservice/6.png'},
    {'title': 'Installation & Removal', 'image': 'assets/Chimneyservice/7.png'},
    {'title': 'Chimney Uninstallation Service', 'image': 'assets/Chimneyservice/8.png'},
  ];

  return LayoutBuilder(
    builder: (context, constraints) {
      final screenWidth = MediaQuery.of(context).size.width;
      final isMobile = screenWidth < 768;
      final isTablet = screenWidth >= 768 && screenWidth < 1024;

      int crossAxisCount;
      double childAspectRatio;
      double horizontalPadding;
      double verticalPadding;
      double crossAxisSpacing;
      double mainAxisSpacing;

      if (isMobile) {
        crossAxisCount = 2;
        childAspectRatio = 0.95;
        horizontalPadding = 16.0;
        verticalPadding = 20.0;
        crossAxisSpacing = 12.0;
        mainAxisSpacing = 16.0;
      } else if (isTablet) {
        crossAxisCount = 2;
        childAspectRatio = 0.5;
        horizontalPadding = 20.0;
        verticalPadding = 25.0;
        crossAxisSpacing = 12.0;
        mainAxisSpacing = 18.0;
      } else {
        crossAxisCount = 2;
        childAspectRatio = 0.7;
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
                    // print('Tapped on: ${services[index]['title']}');
                    onServiceTap(services[index]['title']!);
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: EdgeInsets.all(isMobile ? 4 : 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade100),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade100,
                    ),
                    child: IgnorePointer(
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