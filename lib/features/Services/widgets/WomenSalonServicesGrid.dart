import 'package:flutter/material.dart';
import 'package:zencare/features/Services/widgets/ServiceCard.dart';

Widget WomenSalonServiceGrid({required Function(String) onServiceTap}) {
  final List<Map<String, String>> services = [
    {'title': 'Gold Facial', 'image': 'assets/WomenSalon/1.png'},
    {'title': 'Instant Glow Facial', 'image': 'assets/WomenSalon/2.png'},
    {'title': 'Threading', 'image': 'assets/WomenSalon/3.png'},
    {'title': 'Brightening Facial', 'image': 'assets/WomenSalon/4.png'},
    {'title': 'Anti-Tanning Facial', 'image': 'assets/WomenSalon/5.png'},
    {'title': 'O2 Stay Youthful', 'image': 'assets/WomenSalon/6.png'},
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
        childAspectRatio = 0.75;
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
                return InkWell(
                  onTap: () => onServiceTap(services[index]['title']!),
                  borderRadius: BorderRadius.circular(10),
                  child: Ink(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade100),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade100,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(isMobile ? 4 : 5),
                      child: IgnorePointer(
                        child: ServiceCard(
                          title: services[index]['title']!,
                          imageUrl: services[index]['image']!,
                        ),
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