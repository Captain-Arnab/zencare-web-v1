import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isMobile = screenWidth < 768;
    bool isTablet = screenWidth >= 768 && screenWidth < 1024;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFE3F2FD),
            Colors.white,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : (isTablet ? screenWidth * 0.04 : screenWidth * 0.05),
        vertical: isMobile ? 20 : (isTablet ? 32 : 40),
      ),
      child: isMobile ? _buildMobileLayout(context) : _buildDesktopLayout(context),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    bool isLargeScreen = screenWidth > 1400;
    bool isMediumScreen = screenWidth > 1024;
    bool isTablet = screenWidth >= 768 && screenWidth < 1024;

    int leftFlex = isTablet ? 11 : 5;
    int rightFlex = isTablet ? 13 : 7;

    return Container(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // LEFT - Service Card
          Expanded(
            flex: leftFlex,
            child: Container(
              margin: EdgeInsets.only(
                left: isTablet ? screenWidth * 0.01 : screenWidth * 0.08,
                right: isTablet ? 16 : 0,
              ),
              constraints: BoxConstraints(
                maxWidth: isLargeScreen ? 600 : (isMediumScreen ? 500 : (isTablet ? 380 : 420)),
              ),
              padding: EdgeInsets.all(isTablet ? 24 : (isMediumScreen ? 32 : 28)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 20,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Welcome To ZEN CARE",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E3440),
                      fontSize: isLargeScreen ? 36 : (isMediumScreen ? 28 : (isTablet ? 26 : 24)),
                    ),
                  ),
                  SizedBox(height: isTablet ? 12 : (isMediumScreen ? 16 : 12)),
                  Text(
                    "What are you looking for?",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF64748B),
                      fontSize: isLargeScreen ? 22 : (isMediumScreen ? 18 : (isTablet ? 17 : 16)),
                    ),
                  ),
                  SizedBox(height: isTablet ? 24 : (isMediumScreen ? 32 : 24)),

                  // Service Grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: isTablet ? 10 : (isMediumScreen ? 16 : 14),
                      mainAxisSpacing: isTablet ? 14 : (isMediumScreen ? 20 : 18),
                      childAspectRatio: isTablet ? 1.05 : 1.0,
                    ),
                    itemCount: services.length > 9 ? 9 : services.length,
                    itemBuilder: (context, index) {
                      return _buildServiceCard(context, index, isMediumScreen, isTablet, isLargeScreen);
                    },
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.3, end: 0),
          ),

          // RIGHT - Hero Image with Stats
          Expanded(
            flex: rightFlex,
            child: Container(
              height: isTablet ? screenHeight * 0.65 : screenHeight * 0.75,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Main hero image
                  Positioned(
                    right: isTablet ? -30 : -50,
                    top: screenHeight * 0.02,
                    bottom: screenHeight * 0.02,
                    left: isTablet ? 10 : 0,
                    child: Image.asset(
                      'assets/img/banner.png',
                      fit: BoxFit.contain,
                    ).animate()
                        .fadeIn(duration: 1000.ms)
                        .scale(begin: Offset(0.9, 0.9), end: Offset(1.0, 1.0))
                        .then(delay: 1500.ms)
                        .moveY(begin: 0, end: -8, duration: 2500.ms, curve: Curves.easeInOut)
                        .then()
                        .moveY(begin: -8, end: 8, duration: 5000.ms, curve: Curves.easeInOut)
                        .then()
                        .moveY(begin: 8, end: -8, duration: 5000.ms, curve: Curves.easeInOut),
                  ),

                  // Floating Stats Card
                  Positioned(
                    top: screenHeight * (isTablet ? 0.10 : 0.08),
                    right: isTablet ? 10 : screenWidth * 0.02,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isTablet ? 14 : (isMediumScreen ? 16 : 14),
                        vertical: isTablet ? 10 : (isMediumScreen ? 10 : 8),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 12,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            isTablet ? "300 Completed" : "300 Booking Completed",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF64748B),
                              fontSize: isTablet ? 12 : (isMediumScreen ? 13 : 11),
                            ),
                          ),
                        ],
                      ),
                    ).animate(delay: 1000.ms)
                        .fadeIn(duration: 800.ms)
                        .slideX(begin: 0.3, end: 0)
                        .then(delay: 2000.ms)
                        .moveX(begin: 0, end: -8, duration: 3000.ms, curve: Curves.easeInOut)
                        .then()
                        .moveX(begin: -8, end: 8, duration: 6000.ms, curve: Curves.easeInOut)
                        .then()
                        .moveX(begin: 8, end: -8, duration: 6000.ms, curve: Curves.easeInOut),
                  ),

                  // Rating Card
                  Positioned(
                    bottom: screenHeight * (isTablet ? 0.58 : 0.60),
                    right: isTablet ? screenWidth * 0.25 : screenWidth * 0.20,
                    child: Container(
                      padding: EdgeInsets.all(isTablet ? 12 : (isMediumScreen ? 14 : 12)),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 12,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.amber.withOpacity(0.15),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: isTablet ? 16 : (isMediumScreen ? 18 : 16),
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                "4.9 / 5",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: isTablet ? 14 : (isMediumScreen ? 16 : 14),
                                  color: Color(0xFF2E3440),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Padding(
                            padding: EdgeInsets.only(left: 30),
                            child: Text(
                              "(255 reviews)",
                              style: TextStyle(
                                color: Color(0xFF64748B),
                                fontSize: isTablet ? 10 : (isMediumScreen ? 12 : 10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ).animate(delay: 1400.ms)
                        .fadeIn(duration: 800.ms)
                        .slideX(begin: -0.4, end: 0)
                        .then(delay: 3000.ms)
                        .moveX(begin: 0, end: 6, duration: 4000.ms, curve: Curves.easeInOut)
                        .then()
                        .moveX(begin: 6, end: -6, duration: 8000.ms, curve: Curves.easeInOut)
                        .then()
                        .moveX(begin: -6, end: 6, duration: 8000.ms, curve: Curves.easeInOut),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isSmallMobile = screenWidth < 400;

    return Column(
      children: [
        // Service Card for Mobile
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(isSmallMobile ? 20 : 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 15,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome To ZEN CARE",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E3440),
                  fontSize: isSmallMobile ? 20 : 24,
                ),
              ),
              SizedBox(height: 12),
              Text(
                "What are you looking for?",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF64748B),
                  fontSize: isSmallMobile ? 14 : 16,
                ),
              ),
              SizedBox(height: 24),

              // Mobile Service Grid
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.0,
                ),
                itemCount: services.length,
                itemBuilder: (context, index) {
                  return _buildServiceCard(context, index, false, false, false, isMobile: true);
                },
              ),
            ],
          ),
        ),

        SizedBox(height: 30),

        // Hero Image for Mobile
        Container(
          height: 300,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/img/banner.png',
                  fit: BoxFit.contain,
                ).animate().fadeIn(duration: 800.ms),
              ),

              Positioned(
                top: 20,
                right: 20,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        "300+ Completed",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF64748B),
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ).animate(delay: 500.ms).fadeIn().slideY(begin: -0.3),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildServiceCard(BuildContext context, int index, bool isMediumScreen, bool isTablet, bool isLargeScreen, {bool isMobile = false}) {
    // Calculate icon size based on screen size
    double iconSize;
    double fontSize;

    if (isMobile) {
      iconSize = 160;
      fontSize = 12;
    } else if (isTablet) {
      iconSize = 70;
      fontSize = 11.5;
    } else if (isLargeScreen) {
      iconSize = 100;
      fontSize = 13;
    } else if (isMediumScreen) {
      iconSize = 90;
      fontSize = 13;
    } else {
      iconSize = 85;
      fontSize = 12;
    }

    return GestureDetector(
      onTap: () => handleServiceTap(services[index]["title"]!, context),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.grey.withOpacity(0.08),
            width: 1,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(isMobile ? 8 : (isTablet ? 8 : 8)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Service image with proper sizing
              Expanded(
                flex: 3,
                child: Center(
                  child: Image.asset(
                    services[index]["icon"]!,
                    height: iconSize,
                    width: iconSize,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: isMobile ? 6 : (isTablet ? 5 : 6)),
              // Service title
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2),
                child: Text(
                  services[index]["title"]!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: fontSize,
                    color: Color(0xFF2E3440),
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ).animate(delay: (index * 150).ms).fadeIn(duration: 500.ms).scale(begin: Offset(0.8, 0.8)),
    );
  }

  void handleServiceTap(String title, BuildContext context) {
    switch (title) {
      case "AC Service":
        Navigator.pushReplacementNamed(context, '/ac-services');
        break;
      case "Carpenter Service":
        Navigator.pushReplacementNamed(context, '/carpenter-service');
        break;
      case "Refrigerator Repair":
        Navigator.pushReplacementNamed(context, '/refrigerator-services');
        break;
      case "Home Cleaning":
        Navigator.pushReplacementNamed(context, '/cleaning');
        break;
      case "Salon":
        Navigator.pushReplacementNamed(context, '/salon');
        break;
      case "Pest Control":
        Navigator.pushReplacementNamed(context, '/pest-control');
        break;
      case "Washing Machine Repair":
        Navigator.pushReplacementNamed(context, '/washing-machine');
        break;
      case "Chimney Repair":
        Navigator.pushReplacementNamed(context, '/chimney-repair');
        break;
      case "Water Purifier":
        Navigator.pushReplacementNamed(context, '/water-purifier');
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Service not available")),
        );
    }
  }

  // UPDATED: Services list now matches the routes in CustomAppBar
  List<Map<String, String>> services = [
    {"icon": "assets/icons/home/1.png", "title": "AC Service"},
    {"icon": "assets/icons/home/2.png", "title": "Refrigerator Repair"},
    {"icon": "assets/icons/home/3.png", "title": "Home Cleaning"},
    {"icon": "assets/icons/home/4.png", "title": "Salon"},
    {"icon": "assets/icons/home/5.png", "title": "Pest Control"},
    {"icon": "assets/icons/home/6.png", "title": "Washing Machine Repair"},
    {"icon": "assets/icons/home/7.png", "title": "Chimney Repair"},
    {"icon": "assets/icons/home/8.png", "title": "Water Purifier"},
    {"icon": "assets/icons/home/9.png", "title": "Carpenter Service"},
  ];
}