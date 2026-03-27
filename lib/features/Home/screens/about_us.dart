import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zencare/common/footer.dart';
import 'package:zencare/common/zen_care_scaffold.dart';

class AboutUs extends StatefulWidget {
  AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    final isAndroid = defaultTargetPlatform == TargetPlatform.android;
    return ZenCareScaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SafeArea(child: header(context)),
            SafeArea(child: ResponsiveAboutSection()),
            SafeArea(child: ResponsiveHowItWorks()),
            SafeArea(child: whyChooseUs(context)),
            SafeArea(child: testimonialSection(context)),
            if (!isAndroid) SafeArea(child: provideSection(context)),
            Footer()
          ],
        ),
      ),
    );
  }
}

Widget _buildAboutText(BuildContext context) {
  final textStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Colors.grey[600],
        height: 1.6,
        fontSize: 16,
      );

  return Column(
    children: [
      Text(
        'Welcome to Zen Care, your platform for salon and beauty bookings and other home lifestyle services! We are dedicated to making your life easier with professional, reliable providers. Whether it\'s keeping your home cool with AC servicing, ensuring your appliances run smoothly with refrigerator repair, or giving your space a fresh look with home cleaning—we\'ve got you covered!',
        textAlign: TextAlign.justify,
        style: textStyle,
      ),
      SizedBox(height: 16),
      Text(
        'Looking for beauty and grooming? Our expert salon partners bring hair, makeup, and styling services to your doorstep. Worried about pests? Our pest control solutions help keep your home comfortable. Need a carpenter for home improvements? We connect you with skilled professionals for fixes and renovations.',
        textAlign: TextAlign.justify,
        style: textStyle,
      ),
      SizedBox(height: 16),
      Text(
        'At Zen Care, we believe in quality, convenience, and customer satisfaction. Our skilled professionals ensure top-notch service while maintaining affordability and efficiency. Your comfort is our priority!',
        textAlign: TextAlign.justify,
        style: textStyle,
      ),
    ],
  );
}

Widget _buildFeatureList(BuildContext context, {bool isMobile = false}) {
  final features = [
    'We prioritize quality and reliability',
    'We save your time and effort',
    'Clear, detailed service listings & reviews',
    'Smooth and satisfactory experience',
  ];

  return LayoutBuilder(
    builder: (context, constraints) {
      if (isMobile || constraints.maxWidth < 400) {
        return Column(
          children: features
              .map((feature) => _buildFeatureItem(feature, context))
              .toList(),
        );
      } else {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFeatureItem(features[0], context),
                  _buildFeatureItem(features[1], context),
                ],
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFeatureItem(features[2], context),
                  _buildFeatureItem(features[3], context),
                ],
              ),
            ),
          ],
        );
      }
    },
  );
}

Widget _buildFeatureItem(String text, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 4),
          child: Icon(
            Icons.check_circle_outline,
            color: Colors.green.shade600,
            size: 20,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 15,
                  height: 1.4,
                ),
          ),
        ),
      ],
    ),
  );
}

class ResponsiveHowItWorks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        bool isAndroid = defaultTargetPlatform == TargetPlatform.android;
        bool isMobile = isAndroid || screenWidth < 600;
        bool isTablet = !isAndroid && screenWidth >= 600 && screenWidth < 1024;

        return Container(
          margin: EdgeInsets.symmetric(
            vertical: 40,
            horizontal: isMobile ? 16 : (isTablet ? 20 : 0),
          ),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isTablet ? screenWidth * 0.06 : screenWidth * 0.05,
              vertical: isMobile ? 40 : (isTablet ? 50 : 60),
            ),
            child: Column(
              children: [
                Text(
                  "How It Works",
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: isMobile ? 28 : (isTablet ? 32 : 36),
                      ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 16 : (isTablet ? 60 : 80),
                  ),
                  child: Text(
                    "Straightforward process designed to make your experience seamless and hassle-free.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey[700],
                          fontSize: isMobile ? 16 : 18,
                          height: 1.5,
                        ),
                  ),
                ),
                SizedBox(height: isMobile ? 40 : (isTablet ? 50 : 60)),
                if (isMobile)
                  Column(
                    children: [
                      ResponsiveServiceStep(
                        imagePath: 'assets/img/icons/about-hands.svg',
                        title: '1. Search and Browse',
                        description:
                            'Customers can browse or search for specific products or services using categories, filters, or search bars.',
                        isMobile: true,
                      ),
                      SizedBox(height: 24),
                      ResponsiveServiceStep(
                        imagePath: 'assets/img/icons/about-documents.svg',
                        title: '2. Add to Cart or Book Now',
                        description:
                            'Customers can add items to their shopping cart. For services, they may select a service and proceed to book.',
                        isMobile: true,
                      ),
                      SizedBox(height: 24),
                      ResponsiveServiceStep(
                        imagePath: 'assets/img/icons/about-book.svg',
                        title: '3. Get Amazing Service',
                        description:
                            'The service provider fulfills the order by providing the professional service to the customer.',
                        isMobile: true,
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: ResponsiveServiceStep(
                          imagePath: 'assets/img/icons/about-hands.svg',
                          title: '1. Search and Browse',
                          description:
                              'Customers can browse or search for specific products or services using categories, filters, or search bars.',
                          isTablet: isTablet,
                        ),
                      ),
                      SizedBox(width: isTablet ? 16 : 20),
                      Expanded(
                        child: ResponsiveServiceStep(
                          imagePath: 'assets/img/icons/about-documents.svg',
                          title: '2. Add to Cart or Book Now',
                          description:
                              'Customers can add items to their shopping cart. For services, they may select a service and proceed to book.',
                          isTablet: isTablet,
                        ),
                      ),
                      SizedBox(width: isTablet ? 16 : 20),
                      Expanded(
                        child: ResponsiveServiceStep(
                          imagePath: 'assets/img/icons/about-book.svg',
                          title: '3. Get Amazing Service',
                          description:
                              'The service provider fulfills the order by providing the professional service to the customer.',
                          isTablet: isTablet,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ResponsiveServiceStep extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final bool isMobile;
  final bool isTablet;

  const ResponsiveServiceStep({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    this.isMobile = false,
    this.isTablet = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.white,
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 24 : (isTablet ? 24 : 32)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(isMobile ? 16 : (isTablet ? 14 : 16)),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: SvgPicture.asset(
                imagePath,
                height: isMobile ? 48 : (isTablet ? 50 : 60),
                color: Colors.green.shade400,
              ),
            ),
            SizedBox(height: isMobile ? 20 : (isTablet ? 20 : 24)),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontSize: isMobile ? 18 : (isTablet ? 18 : 20),
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: isMobile ? 12 : (isTablet ? 12 : 16)),
            Text(
              description,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                    fontSize: isMobile ? 14 : (isTablet ? 14 : 15),
                    height: 1.5,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget header(BuildContext context) {
  return LayoutBuilder(
    builder: (context, constraints) {
      double screenWidth = constraints.maxWidth;
      double screenHeight = MediaQuery.of(context).size.height;

      return Container(
        width: screenWidth,
        color: Colors.grey[200],
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'About Us',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Home > About Us',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget whyChooseUs(BuildContext context) {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isAndroid = defaultTargetPlatform == TargetPlatform.android;
      bool isMobile = isAndroid || constraints.maxWidth < 600;
      bool isTablet = !isAndroid &&
          constraints.maxWidth >= 600 &&
          constraints.maxWidth < 1024;

      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile
              ? 16
              : (isTablet
                  ? constraints.maxWidth * 0.06
                  : constraints.maxWidth * 0.05),
          vertical: 40,
        ),
        child: Column(
          children: [
            if (isMobile)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Why Choose Us',
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(
                                fontSize: 28,
                              ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'We are committed to providing top-quality home and lifestyle services with professionalism, reliability, and customer satisfaction.',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                        ),
                        SizedBox(height: 24),
                        _buildExpansionTiles(context, isMobile),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/img/services/service-75.jpg',
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              )
            else
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(right: isTablet ? 24.0 : 40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Why Choose Us',
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(
                                  fontSize: isTablet ? 32 : null,
                                ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'We are committed to providing top-quality home and lifestyle services with professionalism, reliability, and customer satisfaction.',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: isTablet ? 16 : null,
                                ),
                          ),
                          SizedBox(height: 24),
                          _buildExpansionTiles(context, false,
                              isTablet: isTablet),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/img/services/service-75.jpg',
                        height: isTablet ? 450 : null,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            SizedBox(height: 40),
            LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount;
                double childAspectRatio;
                double spacing = isTablet ? 20 : 16;

                if (constraints.maxWidth < 600) {
                  crossAxisCount = 2;
                  childAspectRatio = 1.2;
                } else if (constraints.maxWidth < 1024) {
                  crossAxisCount = 2;
                  childAspectRatio = 2.0;
                  spacing = 24;
                } else {
                  crossAxisCount = 4;
                  childAspectRatio = 1.1;
                }

                return GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: crossAxisCount,
                  mainAxisSpacing: spacing,
                  crossAxisSpacing: spacing,
                  childAspectRatio: childAspectRatio,
                  children: [
                    _buildStatCard('2,583+', 'Happy Clients',
                        'assets/img/icons/group-stars.svg', context, isTablet),
                    _buildStatCard('150+', 'Skilled Professionals',
                        'assets/img/icons/expert-team.svg', context, isTablet),
                    _buildStatCard(
                        '5,000+',
                        'Services Completed',
                        'assets/img/icons/about-documents.svg',
                        context,
                        isTablet),
                    _buildStatCard('10+', 'Years of Excellence',
                        'assets/img/icons/expereience.svg', context, isTablet),
                  ],
                );
              },
            ),
          ],
        ),
      );
    },
  );
}

Widget _buildExpansionTiles(BuildContext context, bool isMobile,
    {bool isTablet = false}) {
  final tiles = [
    {
      'title': 'Reliable & Round-the-Clock Support',
      'content':
          'Our 24/7 customer support ensures that help is always available when you need it.',
      'expanded': true,
    },
    {
      'title': 'Trusted by Thousands of Happy Clients',
      'content':
          'We take pride in our excellent client reviews and testimonials.',
      'expanded': false,
    },
    {
      'title': 'Experienced & Certified Professionals',
      'content': 'Our expert team consists of highly skilled professionals.',
      'expanded': false,
    },
    {
      'title': 'Comprehensive Range of Quality Services',
      'content':
          'From home cleaning to appliance repairs, we offer diverse services.',
      'expanded': false,
    },
  ];

  return Column(
    children: tiles.asMap().entries.map((entry) {
      final tile = entry.value;
      return Container(
        margin: EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[50],
        ),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            initiallyExpanded: tile['expanded'] as bool,
            backgroundColor: Colors.transparent,
            collapsedBackgroundColor: Colors.transparent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            collapsedShape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text(
              tile['title'] as String,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: isMobile ? 16 : (isTablet ? 17 : 18),
                    fontWeight: FontWeight.w600,
                  ),
            ),
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    tile['content'] as String,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: isMobile ? 14 : (isTablet ? 15 : 16),
                          color: Colors.grey[600],
                        ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }).toList(),
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

  return LayoutBuilder(
    builder: (context, constraints) {
      bool isAndroid = defaultTargetPlatform == TargetPlatform.android;
      bool isMobile = isAndroid || constraints.maxWidth < 600;
      bool isTablet = !isAndroid &&
          constraints.maxWidth >= 600 &&
          constraints.maxWidth < 1024;

      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile
              ? 16
              : (isTablet
                  ? constraints.maxWidth * 0.06
                  : constraints.maxWidth * 0.05),
          vertical: 40,
        ),
        child: Column(
          children: [
            Text(
              'What our client says',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontSize: isMobile ? 28 : (isTablet ? 32 : 36),
                  ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : (isTablet ? 60 : 40)),
              child: Text(
                'Description highlights the value of client feedback, showcases real testimonials, and encourages potential clients to engage with your company.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: isMobile ? 16 : 18,
                      color: Colors.grey[600],
                    ),
              ),
            ),
            SizedBox(height: 40),
            if (isMobile)
              Column(
                children: testimonials
                    .map((testimonial) => Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: _buildTestimonialCard(testimonial, context,
                              isMobile: true),
                        ))
                    .toList(),
              )
            else
              Stack(
                alignment: Alignment.center,
                children: [
                  CarouselSlider(
                    carouselController: _controller,
                    options: CarouselOptions(
                      height: isTablet ? 420 : 400,
                      enableInfiniteScroll: true,
                      enlargeCenterPage: false,
                      viewportFraction: isTablet ? 0.5 : 0.4,
                      padEnds: true,
                    ),
                    items: testimonials.map((testimonial) {
                      return Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: isTablet ? 12 : 8),
                        child: _buildTestimonialCard(testimonial, context,
                            isTablet: isTablet),
                      );
                    }).toList(),
                  ),
                  Positioned(
                    left: 0,
                    child: IconButton(
                      icon: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade300, blurRadius: 4)
                          ],
                        ),
                        child: Icon(Icons.arrow_back_ios,
                            size: 16, color: Colors.black87),
                      ),
                      onPressed: () => _controller.previousPage(),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: IconButton(
                      icon: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade300, blurRadius: 4)
                          ],
                        ),
                        child: Icon(Icons.arrow_forward_ios,
                            size: 16, color: Colors.black87),
                      ),
                      onPressed: () => _controller.nextPage(),
                    ),
                  ),
                ],
              ),
          ],
        ),
      );
    },
  );
}

Widget _buildTestimonialCard(
    Map<String, String> testimonial, BuildContext context,
    {bool isMobile = false, bool isTablet = false}) {
  return Container(
    constraints: BoxConstraints(
      maxWidth: isMobile ? double.infinity : (isTablet ? 380 : 350),
    ),
    child: Card(
      surfaceTintColor: Colors.white,
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 20 : (isTablet ? 28 : 24)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                testimonial['image']!,
                height: isMobile ? 80 : (isTablet ? 90 : 100),
                width: isMobile ? 80 : (isTablet ? 90 : 100),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5,
                  (index) => Icon(Icons.star, color: Colors.amber, size: 20)),
            ),
            SizedBox(height: 16),
            Text(
              testimonial['review']!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isMobile ? 14 : (isTablet ? 15 : 16),
                color: Colors.grey[700],
                height: 1.4,
              ),
              maxLines: isMobile ? 5 : (isTablet ? 5 : 4),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 20),
            Text(
              testimonial['name']!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: isMobile ? 16 : (isTablet ? 17 : 18),
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 4),
            Text(
              testimonial['role']!,
              style: TextStyle(
                fontSize: isMobile ? 13 : 14,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget provideSection(BuildContext context) {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isAndroid = defaultTargetPlatform == TargetPlatform.android;
      bool isMobile = isAndroid || constraints.maxWidth < 600;
      bool isTablet = !isAndroid &&
          constraints.maxWidth >= 600 &&
          constraints.maxWidth < 1024;

      return Container(
        color: Colors.black,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: isMobile ? 40 : (isTablet ? 50 : 60),
            horizontal:
                isMobile ? 24 : (isTablet ? constraints.maxWidth * 0.08 : 80),
          ),
          child: isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Become a Provider',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                    ),
                    SizedBox(height: 12),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Post your service ',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          TextSpan(
                            text: 'in a minute',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  color: Colors.blue.shade400,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade600,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.person_add,
                                color: Colors.white, size: 18),
                            SizedBox(width: 8),
                            Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Become a Provider',
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Colors.white70,
                                      fontSize: isTablet ? 16 : 18,
                                    ),
                          ),
                          SizedBox(height: 12),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Post your service ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(
                                        color: Colors.white,
                                        fontSize: isTablet ? 30 : 36,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                TextSpan(
                                  text: 'in a minute',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(
                                        color: Colors.blue.shade400,
                                        fontSize: isTablet ? 30 : 36,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: isTablet ? 24 : 40),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade600,
                        padding: EdgeInsets.symmetric(
                          horizontal: isTablet ? 28 : 32,
                          vertical: isTablet ? 14 : 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.person_add, color: Colors.white, size: 18),
                          SizedBox(width: 8),
                          Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isTablet ? 15 : 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      );
    },
  );
}

Widget _buildStatCard(String value, String label, String imgPath,
    BuildContext context, bool isTablet) {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isSmall = constraints.maxWidth < 150;

      return Card(
        surfaceTintColor: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.all(isSmall ? 12.0 : (isTablet ? 20.0 : 16.0)),
          child: isSmall
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      imgPath,
                      height: 24,
                      width: 24,
                    ),
                    SizedBox(height: 8),
                    Text(
                      value,
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 4),
                    Text(
                      label,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 11,
                            color: Colors.grey[600],
                          ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                )
              : Row(
                  children: [
                    SvgPicture.asset(
                      imgPath,
                      height: isTablet ? 36 : 32,
                      width: isTablet ? 36 : 32,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            value,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: isTablet ? 22 : null,
                                ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            label,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.grey[600],
                                      fontSize: isTablet ? 14 : null,
                                    ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      );
    },
  );
}

class ResponsiveAboutSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        bool isAndroid = defaultTargetPlatform == TargetPlatform.android;
        bool isMobile = isAndroid || screenWidth < 600;
        bool isTablet = !isAndroid && screenWidth >= 600 && screenWidth < 1024;

        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile
                ? 16
                : (isTablet ? screenWidth * 0.06 : screenWidth * 0.05),
            vertical: 40,
          ),
          child: isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/img/providers/provider-23.jpg',
                            height: 250,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 16,
                          left: 16,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              '12+ years of experiences',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    Text(
                      'ABOUT ZEN CARE',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.blue.shade600,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                          ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'We connect you to the right service',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    SizedBox(height: 16),
                    _buildAboutText(context),
                    SizedBox(height: 24),
                    _buildFeatureList(context, isMobile: true),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              'assets/img/providers/provider-23.jpg',
                              height: isTablet ? 380 : 400,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 20,
                            left: 20,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '12+ years of experiences',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: isTablet ? 32 : 40),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ABOUT ZEN CARE',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Colors.blue.shade600,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1.2,
                                    ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            'We connect you to the right service',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  fontSize: isTablet ? 28 : 32,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          SizedBox(height: 20),
                          _buildAboutText(context),
                          SizedBox(height: 24),
                          _buildFeatureList(context),
                        ],
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
