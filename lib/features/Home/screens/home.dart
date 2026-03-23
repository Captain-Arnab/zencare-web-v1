import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zencare/common/footer.dart';
import 'package:zencare/common/zen_care_scaffold.dart';
import 'package:zencare/features/Home/screens/hero_section.dart';
import 'package:zencare/features/Home/screens/works.dart';
import 'package:zencare/features/Partner/partner_registration_dialog.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double screenWidth;
  late double screenHeight;

  // Helper method to determine device type — on Android always use mobile layout
  bool get _isAndroid => defaultTargetPlatform == TargetPlatform.android;
  bool get isMobile => _isAndroid || screenWidth < 768;
  bool get isTablet => !_isAndroid && screenWidth >= 768 && screenWidth < 1024;
  bool get isDesktop => !_isAndroid && screenWidth >= 1024;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return ZenCareScaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SafeArea(child: HeroSection()),
            SafeArea(child: ZenCareWorks()),
            SafeArea(child: partnersection(context)),
            if (!_isAndroid) ...[
              SafeArea(child: whyChooseUs(context)),
              SafeArea(child: testimonialSection(context)),
            ],
            if (!_isAndroid) SafeArea(child: provideSection(context)),
            Footer()
          ],
        ),
      ),
    );
  }

  Widget clients() {
    final List<Map<String, String>> items = [
      {"image": "assets/img/partner/partner-01.svg"},
      {"image": "assets/img/partner/partner-02.svg"},
      {"image": "assets/img/partner/partner-03.svg"},
      {"image": "assets/img/partner/partner-04.svg"},
      {"image": "assets/img/partner/partner-05.svg"}
    ];

    double viewportFraction;
    double itemPadding;

    if (isMobile) {
      viewportFraction = 0.8;
      itemPadding = 10.0;
    } else if (isTablet) {
      viewportFraction = 0.4;
      itemPadding = 20.0;
    } else {
      viewportFraction = 0.21;
      itemPadding = 40.0;
    }

    return Container(
      color: Colors.grey.shade200,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * (isMobile ? 0.02 : 0.05),
            vertical: screenHeight * 0.05),
        child: CarouselSlider(
          options: CarouselOptions(
            height: isMobile ? 60 : 80,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 2),
            enlargeCenterPage: false,
            viewportFraction: viewportFraction,
            onPageChanged: (index, reason) {},
          ),
          items: items.map((item) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: itemPadding),
              child: Card(
                surfaceTintColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 10.0 : 25.0),
                      child: SvgPicture.asset(
                        item["image"]!,
                        height: isMobile ? 40 : 70,
                        width: isMobile ? 100 : 200,
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.center,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget testimonialSection(BuildContext context) {
    final List<Map<String, String>> testimonials = [
      {
        'image': 'assets/img/profiles/avatar-01.jpg',
        'name': 'Arjun',
        'role': 'AC & Fridge Repair',
        'review':
            'My AC and fridge stopped working on the same day. Zen Care fixed both quickly and neatly. Great service and polite staff.'
      },
      {
        'image': 'assets/img/profiles/avatar-02.jpg',
        'name': 'Rina Sharma',
        'role': 'Home Cleaning & Pest Control',
        'review':
            'The team cleaned every corner of the house and also did pest control. The results were amazing. Everything looked fresh and tidy.'
      },
      {
        'image': 'assets/img/profiles/avatar-03.jpg',
        'name': 'Sameer K.',
        'role': 'Chimney Service',
        'review':
            'Our kitchen chimney was not working properly. Zen Care cleaned and repaired it perfectly. Very happy with their work.'
      },
      {
        'image': 'assets/img/profiles/avatar-03.jpg',
        'name': 'Priya Mehta',
        'role': 'Laptop Repair',
        'review':
            'My laptop was very slow. The technician repaired it and now it works smoothly. Fast and reliable service.'
      },
      {
        'image': 'assets/img/profiles/avatar-03.jpg',
        'name': 'Tanvi',
        'role': 'Home Salon',
        'review':
            'I booked a home salon service from Zen Care. The beautician was professional and friendly. It was a great experience.'
      },
      {
        'image': 'assets/img/profiles/avatar-03.jpg',
        'name': 'Rohit Varma',
        'role': 'Annual Maintenance',
        'review':
            'We took Zen Care’s annual package for regular cleaning and appliance checks. They remind us on time and do everything well.'
      },
      {
        'image': 'assets/img/profiles/avatar-03.jpg',
        'name': 'Deepika',
        'role': 'Washing Machine Repair',
        'review':
            'My washing machine was leaking. Zen Care fixed it the same day. Honest and quick service.'
      },
      {
        'image': 'assets/img/profiles/avatar-03.jpg',
        'name': 'Naveen Rao',
        'role': 'Deep Cleaning',
        'review':
            'The cleaning team was on time and did a great job. Our home looked new after they finished.'
      },
      {
        'image': 'assets/img/profiles/avatar-03.jpg',
        'name': 'Kavya',
        'role': 'Pest Control',
        'review':
            'We had a cockroach problem. Zen Care’s pest control worked really well. No sign of pests after that.'
      },
      {
        'image': 'assets/img/profiles/avatar-03.jpg',
        'name': 'Kiran Desai',
        'role': 'Multiple Services',
        'review':
            'Zen Care is my go-to for all home needs. Whether it’s repair, cleaning, or salon — they always do a good job.'
      },
    ];

    CarouselSliderController _controller = CarouselSliderController();

    double viewportFraction;
    double cardHeight;

    if (isMobile) {
      viewportFraction = 0.85;
      cardHeight = 220;
    } else if (isTablet) {
      viewportFraction = 0.6;
      cardHeight = 270;
    } else {
      viewportFraction = 0.34;
      cardHeight = 320;
    }

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * (isMobile ? 0.02 : 0.05),
          vertical: screenHeight * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Section Heading
          Column(
            children: [
              Text(
                'What our client says',
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 0),
                child: Text(
                  'Description highlights the value of client feedback, showcases real testimonials, and encourages potential clients to engage with your company.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
          // Carousel with Navigation Arrows and Auto-play
          Stack(
            alignment: Alignment.center,
            children: [
              CarouselSlider(
                carouselController: _controller,
                options: CarouselOptions(
                  height: cardHeight,
                  enableInfiniteScroll: true,
                  enlargeCenterPage: false,
                  viewportFraction: viewportFraction,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 4),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                ),
                items: testimonials.map((testimonial) {
                  return Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: isMobile ? 5.0 : 10.0),
                    child: Card(
                      surfaceTintColor: Colors.white,
                      color: Colors.white,
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(isMobile ? 12.0 : 16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Image on top
                            ClipRRect(
                              borderRadius: BorderRadius.circular(200),
                              child: Image.asset(
                                testimonial['image']!,
                                height: isMobile ? 70 : 90,
                                width: isMobile ? 70 : 90,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: isMobile ? 8 : 12),
                            // Rating Stars
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                5,
                                (index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: isMobile ? 18 : 22,
                                ),
                              ),
                            ),
                            SizedBox(height: isMobile ? 8 : 12),
                            // Client Review
                            Expanded(
                              child: SingleChildScrollView(
                                child: Text(
                                  testimonial['review']!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: isMobile ? 12 : 14,
                                    color: Colors.grey[700],
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: isMobile ? 8 : 12),
                            // Client Name and Role
                            Text(
                              testimonial['name']!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: isMobile ? 14 : 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 4),
                            Text(
                              testimonial['role']!,
                              style: TextStyle(
                                fontSize: isMobile ? 12 : 14,
                                color: Colors.grey[500],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              // Navigation arrows for all devices (including mobile)
              Positioned(
                left: 5,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: isMobile ? 16 : 20,
                      color: Colors.black87,
                    ),
                    onPressed: () => _controller.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 5,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: isMobile ? 16 : 20,
                      color: Colors.black87,
                    ),
                    onPressed: () => _controller.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Dots indicator for mobile and tablet
          if (isMobile || isTablet) ...[
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                testimonials.length,
                (index) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[400],
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget appDownloadSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(isMobile ? 8.0 : 16.0),
      child: Column(
        children: [
          Stack(
            children: [
              // Background images for large screens only
              if (isDesktop) ...[
                Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    'assets/img/bg/ellipse-01.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    'assets/img/bg/ellipse-02.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
              if (isTablet || isDesktop)
                Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    'assets/img/bg/dot-white.png',
                    fit: BoxFit.cover,
                  ),
                ),
              // App Section Content
              Column(
                children: [
                  isMobile
                      ? Column(
                          children: [
                            // Content for mobile
                            _buildAppDownloadContent(context),
                            SizedBox(height: 20),
                            // Phone image for mobile
                            Image.asset(
                              'assets/img/bg/phone.png',
                              fit: BoxFit.contain,
                              height: 200,
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            // Left Column
                            Expanded(
                              child: _buildAppDownloadContent(context),
                            ),
                            // Right Column - Phone image
                            if (isTablet || isDesktop)
                              Expanded(
                                child: Image.asset(
                                  'assets/img/bg/phone.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                          ],
                        ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAppDownloadContent(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          'Download Our App',
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
        ),
        const SizedBox(height: 10),
        Text(
          'Whether you\'re looking to our app brings everything you need right to your fingertips. Enjoy a smooth and intuitive experience designed with you in mind.',
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
        ),
        const SizedBox(height: 10),
        Text(
          'Scan the QR code to get the app now',
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
        ),
        const SizedBox(height: 10),
        // Scan Image
        Image.asset(
          'assets/img/scan-img.png',
          fit: BoxFit.contain,
          height: isMobile ? 100 : null,
        ),
        const SizedBox(height: 20),
        // Download Buttons
        Wrap(
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          spacing: 10,
          runSpacing: 10,
          children: [
            GestureDetector(
              onTap: () {
                // Add your Google Play URL here
              },
              child: SvgPicture.asset(
                'assets/img/icons/goolge-play.svg',
                height: isMobile ? 35 : 40,
                width: isMobile ? 100 : 120,
              ),
            ),
            GestureDetector(
              onTap: () {
                // Add your App Store URL here
              },
              child: SvgPicture.asset(
                'assets/img/icons/app-store.svg',
                height: isMobile ? 35 : 40,
                width: isMobile ? 100 : 120,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget whyChooseUs(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * (isMobile ? 0.02 : 0.05),
          vertical: screenHeight * 0.05),
      child: Column(
        children: [
          isMobile
              ? Column(
                  children: [
                    // Image first on mobile
                    Image.asset(
                      'assets/about/whychooseus.jpg',
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                    SizedBox(height: 20),
                    // Content
                    _buildWhyChooseUsContent(context),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: _buildWhyChooseUsContent(context),
                    ),
                    Expanded(
                        flex: 2,
                        child: Image.asset('assets/about/whychooseus.jpg')),
                  ],
                ),
          SizedBox(height: 20),
          // Stats Grid - FIXED SECTION
          Padding(
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
            child: isMobile
                ? Column(
                    children: [
                      _buildStatCard('2,583+', 'Happy Clients',
                          'assets/img/icons/group-stars.svg', context),
                      SizedBox(height: 10),
                      _buildStatCard('150+', 'Skilled Professionals',
                          'assets/img/icons/expert-team.svg', context),
                      SizedBox(height: 10),
                      _buildStatCard('5,000+', 'Services Completed',
                          'assets/img/icons/about-documents.svg', context),
                      SizedBox(height: 10),
                      _buildStatCard('10+', 'Years of Excellence',
                          'assets/img/icons/expereience.svg', context),
                    ],
                  )
                : LayoutBuilder(
                    builder: (context, constraints) {
                      return Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          SizedBox(
                            width: isTablet
                                ? (constraints.maxWidth - 10) / 2
                                : (constraints.maxWidth - 30) / 4,
                            child: _buildStatCard('2,583+', 'Happy Clients',
                                'assets/img/icons/group-stars.svg', context),
                          ),
                          SizedBox(
                            width: isTablet
                                ? (constraints.maxWidth - 10) / 2
                                : (constraints.maxWidth - 30) / 4,
                            child: _buildStatCard(
                                '150+',
                                'Skilled Professionals',
                                'assets/img/icons/expert-team.svg',
                                context),
                          ),
                          SizedBox(
                            width: isTablet
                                ? (constraints.maxWidth - 10) / 2
                                : (constraints.maxWidth - 30) / 4,
                            child: _buildStatCard(
                                '5,000+',
                                'Services Completed',
                                'assets/img/icons/about-documents.svg',
                                context),
                          ),
                          SizedBox(
                            width: isTablet
                                ? (constraints.maxWidth - 10) / 2
                                : (constraints.maxWidth - 30) / 4,
                            child: _buildStatCard('10+', 'Years of Excellence',
                                'assets/img/icons/expereience.svg', context),
                          ),
                        ],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhyChooseUsContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 10.0 : 20.0),
      child: Column(
        crossAxisAlignment:
            isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Text(
            'Why Choose Us',
            style: Theme.of(context).textTheme.displayLarge,
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
          ),
          SizedBox(height: 10),
          Text(
            'We are committed to providing top-quality home and lifestyle services with professionalism, reliability, and customer satisfaction.',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.w400),
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
          ),
          SizedBox(height: 20),
          ExpansionTile(
            initiallyExpanded: true,
            backgroundColor: Colors.grey[100],
            title: Text(
              'Reliable & Round-the-Clock Support',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(fontSize: isMobile ? 16 : null),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Text(
                  'Our 24/7 customer support ensures that help is always available when you need it.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          ExpansionTile(
            backgroundColor: Colors.grey[100],
            title: Text(
              'Trusted by Thousands of Happy Clients',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(fontSize: isMobile ? 16 : null),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Text(
                  'We take pride in our excellent client reviews and testimonials.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          ExpansionTile(
            backgroundColor: Colors.grey[100],
            title: Text(
              'Experienced & Certified Professionals',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(fontSize: isMobile ? 16 : null),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Text(
                  'Our expert team consists of highly skilled professionals.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          ExpansionTile(
            backgroundColor: Colors.grey[100],
            title: Text(
              'Comprehensive Range of Quality Services',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(fontSize: isMobile ? 16 : null),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Text(
                  'From home cleaning to appliance repairs, we offer diverse services.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              )
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildStatCard(
      String value, String label, String imgPath, BuildContext context) {
    return Card(
      surfaceTintColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        constraints: BoxConstraints(
          minHeight: isMobile ? 80 : 100,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 16.0 : 12.0,
          vertical: isMobile ? 12.0 : 16.0,
        ),
        child: Row(
          mainAxisAlignment:
              isMobile ? MainAxisAlignment.start : MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: isMobile ? 32 : (isTablet ? 36 : 44),
              height: isMobile ? 32 : (isTablet ? 36 : 44),
              child: SvgPicture.asset(
                imgPath,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(width: isMobile ? 16 : (isTablet ? 12 : 16)),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: isMobile
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      value,
                      style: TextStyle(
                        fontSize: isMobile ? 20 : (isTablet ? 18 : 22),
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 2),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: isMobile ? 13 : (isTablet ? 12 : 14),
                        color: Colors.grey[600],
                      ),
                      maxLines: isMobile ? 1 : 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget provideSection(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1a1a2e),
            Color(0xFF16213e),
            Color(0xFF0f3460),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Decorative circles
          if (isDesktop) ...[
            Positioned(
              top: -50,
              right: -50,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue.shade800.withOpacity(0.1),
                ),
              ),
            ),
            Positioned(
              bottom: -100,
              left: -80,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue.shade700.withOpacity(0.08),
                ),
              ),
            ),
          ],
          // Main content
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth *
                  (isMobile
                      ? 0.05
                      : isTablet
                          ? 0.08
                          : 0.12),
              vertical: screenHeight * (isMobile ? 0.08 : 0.1),
            ),
            child: isMobile || isTablet
                ? Column(
                    children: [
                      _buildProviderTextContent(context),
                      SizedBox(height: 30),
                      _buildProviderButton(context),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 3,
                        child: _buildProviderTextContent(context),
                      ),
                      SizedBox(width: 40),
                      _buildProviderButton(context),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildProviderTextContent(BuildContext context) {
    return Column(
      crossAxisAlignment: isMobile || isTablet
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 20,
            vertical: isMobile ? 6 : 8,
          ),
          decoration: BoxDecoration(
            color: Colors.blue.shade800.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.blue.shade800.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Text(
            'Become a Provider',
            style: TextStyle(
              color: Colors.blue.shade300,
              fontSize: isMobile ? 12 : 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
        SizedBox(height: isMobile ? 16 : 20),
        RichText(
          textAlign: isMobile || isTablet ? TextAlign.center : TextAlign.start,
          text: TextSpan(
            style: TextStyle(
              fontSize: isMobile
                  ? 28
                  : isTablet
                      ? 36
                      : 48,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
            children: [
              TextSpan(
                text: 'Post your service\n',
                style: TextStyle(color: Colors.white),
              ),
              TextSpan(
                text: 'in a minute',
                style: TextStyle(
                  color: Colors.blue.shade400,
                  shadows: [
                    Shadow(
                      color: Colors.blue.shade800.withOpacity(0.5),
                      blurRadius: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: isMobile ? 12 : 16),
        Text(
          'Join thousands of service providers and grow your business with ZenCare',
          style: TextStyle(
            color: Colors.grey.shade400,
            fontSize: isMobile
                ? 14
                : isTablet
                    ? 16
                    : 18,
            height: 1.5,
          ),
          textAlign: isMobile || isTablet ? TextAlign.center : TextAlign.start,
        ),
      ],
    );
  }

  Widget _buildProviderButton(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        child: ElevatedButton(
          onPressed: () {
            // Add navigation logic
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade700,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(
              horizontal: isMobile
                  ? 32
                  : isTablet
                      ? 40
                      : 48,
              vertical: isMobile
                  ? 16
                  : isTablet
                      ? 18
                      : 20,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 8,
            shadowColor: Colors.blue.shade800.withOpacity(0.5),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person_add,
                  color: Colors.white,
                  size: isMobile ? 20 : 24,
                ),
              ),
              SizedBox(width: 12),
              Text(
                'Sign Up Now',
                style: TextStyle(
                  fontSize: isMobile
                      ? 16
                      : isTablet
                          ? 18
                          : 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(width: 8),
              Icon(
                Icons.arrow_forward,
                size: isMobile ? 18 : 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget partnersection(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xFF0f3460),
            Color(0xFF16213e),
            Color(0xFF1a1a2e),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Animated background pattern
          if (isDesktop) ...[
            Positioned(
              top: 50,
              left: 100,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.blue.shade800.withOpacity(0.2),
                    width: 2,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 80,
              right: 120,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue.shade900.withOpacity(0.1),
                ),
              ),
            ),
          ],
          // Main content
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth *
                  (isMobile
                      ? 0.05
                      : isTablet
                          ? 0.08
                          : 0.12),
              vertical: screenHeight * (isMobile ? 0.08 : 0.1),
            ),
            child: isMobile || isTablet
                ? Column(
                    children: [
                      _buildPartnerTextContent(context),
                      SizedBox(height: 30),
                      _buildPartnerButton(context),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 3,
                        child: _buildPartnerTextContent(context),
                      ),
                      SizedBox(width: 40),
                      _buildPartnerButton(context),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildPartnerTextContent(BuildContext context) {
    return Column(
      crossAxisAlignment: isMobile || isTablet
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize:
              isMobile || isTablet ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: isMobile || isTablet
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(isMobile ? 8 : 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.shade700,
                    Colors.blue.shade900,
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.shade800.withOpacity(0.3),
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                Icons.handshake,
                color: Colors.white,
                size: isMobile ? 24 : 28,
              ),
            ),
            SizedBox(width: 12),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 20,
                vertical: isMobile ? 6 : 8,
              ),
              decoration: BoxDecoration(
                color: Colors.blue.shade800.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.blue.shade800.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Text(
                'Partnership Opportunity',
                style: TextStyle(
                  color: Colors.blue.shade300,
                  fontSize: isMobile ? 12 : 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: isMobile ? 20 : 24),
        RichText(
          textAlign: isMobile || isTablet ? TextAlign.center : TextAlign.start,
          text: TextSpan(
            style: TextStyle(
              fontSize: isMobile
                  ? 28
                  : isTablet
                      ? 36
                      : 48,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
            children: [
              TextSpan(
                text: 'Expand Your Reach\n',
                style: TextStyle(color: Colors.white),
              ),
              TextSpan(
                text: 'Grow Together',
                style: TextStyle(
                  foreground: Paint()
                    ..shader = LinearGradient(
                      colors: [
                        Colors.blue.shade300,
                        Colors.blue.shade600,
                      ],
                    ).createShader(Rect.fromLTWH(0, 0, 400, 70)),
                  shadows: [
                    Shadow(
                      color: Colors.blue.shade800.withOpacity(0.5),
                      blurRadius: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: isMobile ? 12 : 16),
        Text(
          'Partner with ZenCare and unlock new opportunities for your business',
          style: TextStyle(
            color: Colors.grey.shade400,
            fontSize: isMobile
                ? 14
                : isTablet
                    ? 16
                    : 18,
            height: 1.5,
          ),
          textAlign: isMobile || isTablet ? TextAlign.center : TextAlign.start,
        ),
        if (isDesktop) ...[
          SizedBox(height: 24),
          Wrap(
            spacing: 16,
            runSpacing: 12,
            children: [
              _buildFeatureChip(Icons.trending_up, 'Increase Revenue'),
              _buildFeatureChip(Icons.people, 'Wide Customer Base'),
              _buildFeatureChip(Icons.support_agent, '24/7 Support'),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildFeatureChip(IconData icon, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.blue.shade300, size: 18),
          SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPartnerButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: [
            Colors.blue.shade600,
            Colors.blue.shade800,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade800.withOpacity(0.4),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          showPartnerRegistrationDialog(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile
                ? 32
                : isTablet
                    ? 40
                    : 48,
            vertical: isMobile
                ? 16
                : isTablet
                    ? 18
                    : 20,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.business_center,
                color: Colors.white,
                size: isMobile ? 20 : 24,
              ),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Become a Partner',
                  style: TextStyle(
                    fontSize: isMobile
                        ? 16
                        : isTablet
                            ? 18
                            : 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Start today',
                  style: TextStyle(
                    fontSize: isMobile ? 11 : 12,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
            SizedBox(width: 8),
            Icon(
              Icons.arrow_forward,
              size: isMobile ? 18 : 20,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
