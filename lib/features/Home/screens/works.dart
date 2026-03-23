import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ZenCareWorks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Determine if it's mobile, tablet, or desktop — on Android always use mobile layout
    bool isAndroid = defaultTargetPlatform == TargetPlatform.android;
    bool isMobile = isAndroid || screenWidth < 600;
    bool isTablet = !isAndroid && screenWidth >= 600 && screenWidth < 1024;
    bool isDesktop = !isAndroid && screenWidth >= 1024;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: _getHorizontalPadding(screenWidth),
            vertical: screenHeight * 0.02,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                // Header Section
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: _getHeaderHorizontalPadding(screenWidth),
                    vertical: _getHeaderVerticalPadding(screenHeight),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "How Zen Care Works",
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Colors.white,
                          fontSize: _getHeaderFontSize(screenWidth),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isDesktop ? screenWidth * 0.1 : 0,
                        ),
                        child: Text(
                          "We make it easy to find trusted service providers for all your home and lifestyle needs.",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.white,
                            fontSize: _getSubtitleFontSize(screenWidth),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),

                // Service Steps
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: _getContentHorizontalPadding(screenWidth),
                    vertical: screenHeight * 0.01,
                  ),
                  child: isMobile
                      ? Column(
                    children: [
                      ServiceStep(
                        imagePath: 'assets/icons/work-01.svg',
                        title: '1. Choose Your Service',
                        description:
                        'Browse through our wide range of services, from AC repair to home cleaning, and select the one you need.',
                        isMobile: true,
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      ServiceStep(
                        imagePath: 'assets/icons/work-icon-01.svg',
                        title: '2. Book & Get It Done',
                        description:
                        'Schedule your service at your convenience, and our verified professionals will get the job done efficiently.',
                        isMobile: true,
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      ServiceStep(
                        imagePath: 'assets/icons/work-03.svg',
                        title: '3. Rate & Review',
                        description:
                        'After the service is completed, share your experience to help others and improve service quality.',
                        isMobile: true,
                      ),
                    ],
                  )
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ServiceStep(
                          imagePath: 'assets/icons/work-01.svg',
                          title: '1. Choose Your Service',
                          description:
                          'Browse through our wide range of services, from AC repair to home cleaning, and select the one you need.',
                          isMobile: false,
                        ),
                      ),
                      if (isDesktop) SizedBox(width: screenWidth * 0.02),
                      Expanded(
                        child: ServiceStep(
                          imagePath: 'assets/icons/work-icon-01.svg',
                          title: '2. Book & Get It Done',
                          description:
                          'Schedule your service at your convenience, and our verified professionals will get the job done efficiently.',
                          isMobile: false,
                        ),
                      ),
                      if (isDesktop) SizedBox(width: screenWidth * 0.02),
                      Expanded(
                        child: ServiceStep(
                          imagePath: 'assets/icons/work-03.svg',
                          title: '3. Rate & Review',
                          description:
                          'After the service is completed, share your experience to help others and improve service quality.',
                          isMobile: false,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Responsive helper methods
  double _getHorizontalPadding(double screenWidth) {
    if (screenWidth < 600) return screenWidth * 0.05; // Mobile
    if (screenWidth < 1024) return screenWidth * 0.06; // Tablet
    return screenWidth * 0.08; // Desktop
  }

  double _getHeaderHorizontalPadding(double screenWidth) {
    if (screenWidth < 600) return screenWidth * 0.05; // Mobile
    if (screenWidth < 1024) return screenWidth * 0.08; // Tablet
    return screenWidth * 0.1; // Desktop
  }

  double _getHeaderVerticalPadding(double screenHeight) {
    if (screenHeight < 700) return screenHeight * 0.04; // Small screens
    if (screenHeight < 900) return screenHeight * 0.05; // Medium screens
    return screenHeight * 0.06; // Large screens
  }

  double _getContentHorizontalPadding(double screenWidth) {
    if (screenWidth < 600) return screenWidth * 0.04; // Mobile
    if (screenWidth < 1024) return screenWidth * 0.06; // Tablet
    return screenWidth * 0.08; // Desktop
  }

  double _getHeaderFontSize(double screenWidth) {
    if (screenWidth < 600) return 24.0; // Mobile
    if (screenWidth < 1024) return 28.0; // Tablet
    return 32.0; // Desktop
  }

  double _getSubtitleFontSize(double screenWidth) {
    if (screenWidth < 600) return 14.0; // Mobile
    if (screenWidth < 1024) return 16.0; // Tablet
    return 18.0; // Desktop
  }
}

class ServiceStep extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final bool isMobile;

  ServiceStep({
    required this.imagePath,
    required this.title,
    required this.description,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Responsive values
    double iconSize = _getIconSize(screenWidth);
    double titleFontSize = _getTitleFontSize(screenWidth);
    double descriptionFontSize = _getDescriptionFontSize(screenWidth);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: _getStepHorizontalPadding(screenWidth),
        vertical: _getStepVerticalPadding(screenHeight),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            imagePath,
            height: iconSize,
            width: iconSize,
          ),
          SizedBox(height: screenHeight * 0.02),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: titleFontSize,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 0 : screenWidth * 0.01,
            ),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: descriptionFontSize,
                color: Colors.grey[400],
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Responsive helper methods for ServiceStep
  double _getIconSize(double screenWidth) {
    if (screenWidth < 600) return 50.0; // Mobile
    if (screenWidth < 1024) return 60.0; // Tablet
    return 70.0; // Desktop
  }

  double _getTitleFontSize(double screenWidth) {
    if (screenWidth < 600) return 16.0; // Mobile
    if (screenWidth < 1024) return 18.0; // Tablet
    return 20.0; // Desktop
  }

  double _getDescriptionFontSize(double screenWidth) {
    if (screenWidth < 600) return 12.0; // Mobile
    if (screenWidth < 1024) return 14.0; // Tablet
    return 15.0; // Desktop
  }

  double _getStepHorizontalPadding(double screenWidth) {
    if (screenWidth < 600) return screenWidth * 0.02; // Mobile
    if (screenWidth < 1024) return screenWidth * 0.015; // Tablet
    return screenWidth * 0.02; // Desktop
  }

  double _getStepVerticalPadding(double screenHeight) {
    if (screenHeight < 700) return screenHeight * 0.015; // Small screens
    if (screenHeight < 900) return screenHeight * 0.02; // Medium screens
    return screenHeight * 0.025; // Large screens
  }
}