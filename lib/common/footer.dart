import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:provider/provider.dart';
import '../features/controller.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Android apps don't use web-style footers; omit footer on Android
    if (defaultTargetPlatform == TargetPlatform.android) {
      return const SizedBox.shrink();
    }

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Responsive breakpoints — on Android always use mobile layout
    bool isMobile = screenWidth < 600;
    bool isTablet = screenWidth >= 600 && screenWidth < 1024;
    bool isDesktop = screenWidth >= 1024;

    return Container(
      color: Colors.grey[100],
      child: Column(
        children: [
          if (isMobile) _buildMobileFooter(context),
          if (isTablet) _buildTabletFooter(context),
          if (isDesktop) _buildDesktopFooter(context),
          _buildFooterBottom(context),
        ],
      ),
    );
  }

  Widget _buildMobileFooter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Links in accordion/expandable format
          ExpansionTile(
            title: Text('Quick Links',
                style: Theme.of(context).textTheme.titleMedium),
            children:
                _buildLinkList(['About Us', 'Services', 'Contact Us'], context),
          ),

          ExpansionTile(
            title: Text('Services',
                style: Theme.of(context).textTheme.titleMedium),
            children: [
              ..._buildLinkList([
                'AC Service',
                'Refrigerator Repair',
                'Home Cleaning',
                'Salon'
              ], context),
              ..._buildLinkList([
                'Pest control',
                'Washing machine repair',
                'Water purifier services'
              ], context),
            ],
          ),

          ExpansionTile(
            title:
                Text('Support', style: Theme.of(context).textTheme.titleMedium),
            children: _buildLinkList(
                ['Terms and Conditions', 'Refund Policy', 'Privacy Policy'],
                context),
          ),

          const SizedBox(height: 24),

          // Cart and Hotline
          _buildCartSection(context, isMobile: true),
          const SizedBox(height: 16),
          _buildHotlineSection(context, isMobile: true),
          const SizedBox(height: 16),

          // Social icons and app download
          _buildSocialSection(context, isMobile: true),
          const SizedBox(height: 16),
          _buildAppDownloadSection(context, isMobile: true),
        ],
      ),
    );
  }

  Widget _buildTabletFooter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          // Main content in 2x2 grid
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    _buildQuickLinks(context),
                    const SizedBox(height: 32),
                    _buildSupport(context),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  children: [
                    _buildServices(context, isTablet: true),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Bottom section
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    _buildCartSection(context, isTablet: true),
                    const SizedBox(height: 16),
                    _buildHotlineSection(context, isTablet: true),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  children: [
                    _buildSocialSection(context, isTablet: true),
                    const SizedBox(height: 16),
                    _buildAppDownloadSection(context, isTablet: true),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopFooter(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05, vertical: screenHeight * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 1, child: _buildQuickLinks(context)),
              Expanded(flex: 1, child: _buildMyAccount(context)),
              Expanded(flex: 1, child: _buildServices(context)),
              Expanded(flex: 1, child: _buildSupport(context)),
              Expanded(flex: 1, child: _buildAppDownloadSection(context)),
            ],
          ),
        ),
        _buildCartSection(context),
        _buildHotlineSection(context),
        _buildSocialSection(context),
      ],
    );
  }

  Widget _buildQuickLinks(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Links',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        ..._buildLinkList(['About Us', 'Services', 'Contact Us'], context),
      ],
    );
  }

  Widget _buildMyAccount(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Services',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        ..._buildLinkList(
            ['AC Service', 'Refrigerator Repair', 'Home Cleaning', 'Salon'],
            context),
      ],
    );
  }

  Widget _buildServices(BuildContext context, {bool isTablet = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isTablet) ...[
          Text(
            'Services',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          ..._buildLinkList([
            'Pest control',
            'Washing machine repair',
            'Water purifier services'
          ], context),
        ] else ...[
          Text(
            'All Services',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          ..._buildLinkList([
            'AC Service',
            'Carpenter Service',
            'Refrigerator Repair',
            'Home Cleaning',
            'Salon',
            'Pest control',
            'Washing machine repair',
            'Water purifier services'
          ], context),
        ],
      ],
    );
  }

  Widget _buildSupport(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Support',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        ..._buildLinkList(
            ['Terms and Conditions', 'Refund Policy', 'Privacy Policy'],
            context),
      ],
    );
  }

  Widget _buildCartSection(BuildContext context,
      {bool isMobile = false, bool isTablet = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 0 : (isTablet ? 0 : 100),
        vertical: isMobile ? 8 : 0,
      ),
      child: Row(
        mainAxisAlignment:
            isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          if (!isMobile) const SizedBox(width: 4),
          Text(
            'Go to Cart',
            style: isMobile
                ? Theme.of(context).textTheme.titleMedium
                : Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(width: 10),
          Consumer<CartData>(
            builder: (context, cartData, child) {
              return IconButton(
                icon: Badge(
                  label: Text(cartData.cartCount.toString()),
                  child: const Icon(Icons.shopping_cart),
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/shopping-cart');
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHotlineSection(BuildContext context,
      {bool isMobile = false, bool isTablet = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 0 : (isTablet ? 0 : 100),
        vertical: isMobile ? 8 : 20,
      ),
      child: Row(
        mainAxisAlignment:
            isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          Icon(
            Icons.phone_in_talk_outlined,
            color: Colors.grey,
            size: isMobile ? 20 : 25,
          ),
          const SizedBox(width: 4),
          Text(
            'HotLine Order',
            style: isMobile
                ? Theme.of(context).textTheme.titleMedium
                : Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () => null,
            child: Text(
              '8179550262',
              style: TextStyle(
                fontFamily: 'Nunito',
                color: Colors.black,
                fontSize: isMobile ? 14 : 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialSection(BuildContext context,
      {bool isMobile = false, bool isTablet = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 0 : (isTablet ? 0 : 100),
        vertical: isMobile ? 8 : 20,
      ),
      child: _buildSocialIconsWidget(isMobile: isMobile),
    );
  }

  Widget _buildAppDownloadSection(BuildContext context,
      {bool isMobile = false, bool isTablet = false}) {
    if (isMobile || isTablet) {
      return Column(
        children: [
          Text(
            'Download Our App',
            style: isMobile
                ? Theme.of(context).textTheme.titleMedium
                : Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: SvgPicture.asset(
                    'assets/img/icons/app-store.svg',
                    height: isMobile ? 35 : 40,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  flex: 1,
                  child: SvgPicture.asset(
                    'assets/img/icons/google-play.svg',
                    height: isMobile ? 35 : 40,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildSubscriptionWidget(BuildContext context,
      {bool isMobile = false, bool isTablet = false}) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Card(
            elevation: 1,
            surfaceTintColor: Colors.white54,
            child: Padding(
              padding: EdgeInsets.all(isMobile ? 12.0 : 16.0),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // children: [
                //   Text(
                //     'SignUp For Subscription',
                //     style: isMobile
                //         ? Theme.of(context).textTheme.titleMedium
                //         : Theme.of(context).textTheme.titleLarge,
                //   ),
                //   SizedBox(height: isMobile ? 12 : 16),
                //   TextField(
                //     decoration: InputDecoration(
                //       hintText: 'Enter Email Address',
                //       hintStyle:
                //           Theme.of(context).textTheme.displayMedium!.copyWith(
                //                 color: Colors.grey,
                //                 fontSize: isMobile ? 12 : null,
                //               ),
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(8.0),
                //         borderSide: const BorderSide(color: Colors.grey),
                //       ),
                //       filled: true,
                //       fillColor: Colors.white,
                //       contentPadding: EdgeInsets.all(isMobile ? 8 : 12),
                //     ),
                //   ),
                //   SizedBox(height: isMobile ? 12 : 16),
                //   ElevatedButton(
                //     onPressed: () {
                //       // Handle subscribe action here
                //     },
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: Colors.blue.shade800,
                //       minimumSize: Size(double.infinity, isMobile ? 40 : 50),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(5),
                //       ),
                //     ),
                //     child: Text(
                //       'Subscribe',
                //       style:
                //           Theme.of(context).textTheme.displayMedium!.copyWith(
                //                 color: Colors.white,
                //                 fontSize: isMobile ? 12 : null,
                //               ),
                //     ),
                //   ),
                // ],
              ),
            ),
          ),
        ),
        if (!isMobile && !isTablet) ...[
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Download Our App',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Flexible(
                    child: SvgPicture.asset(
                      'assets/img/icons/app-store.svg',
                      width: 125,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: SvgPicture.asset(
                      'assets/img/icons/google-play.svg',
                      width: 125,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ],
    );
  }

  List<Widget> _buildLinkList(List<String> links, BuildContext context) {
    return links.map((text) => _link(text, context)).toList();
  }

  Widget _link(String text, BuildContext context) {
    return InkWell(
      onTap: () {
        switch (text) {
          case 'Home':
            Navigator.pushReplacementNamed(context, '/home');
            break;
          case 'About Us':
            Navigator.pushReplacementNamed(context, '/about-us');
            break;
          case 'AC Service':
            Navigator.pushReplacementNamed(context, '/ac-services');
            break;
          case 'Carpenter Service':
            Navigator.pushReplacementNamed(context, '/carpenter-service');
            break;
          case 'Refrigerator Repair':
            Navigator.pushReplacementNamed(context, '/refrigerator-services');
            break;
          case 'Home Cleaning':
            Navigator.pushReplacementNamed(context, '/cleaning');
            break;
          case 'Salon':
            Navigator.pushReplacementNamed(context, '/salon');
            break;
          case 'Pest control':
            Navigator.pushReplacementNamed(context, '/pest-control');
            break;
          case 'Washing machine repair':
            Navigator.pushReplacementNamed(context, '/washing-machine');
            break;
          case 'Water purifier services':
            Navigator.pushReplacementNamed(context, '/water-purifier');
            break;
          case 'Services':
            Navigator.pushReplacementNamed(context, '/ac-services');
            break;
          case 'Contact Us':
            Navigator.pushReplacementNamed(context, '/contact-us');
            break;
          case 'Terms and Conditions':
            Navigator.pushReplacementNamed(context, '/terms-and-conditions');
            break;
          case 'Privacy Policy':
            Navigator.pushReplacementNamed(context, '/privacy-policy');
            break;
          case 'Refund Policy':
            Navigator.pushReplacementNamed(context, '/refund-policy');
            break;
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }

  Widget _buildSocialIconsWidget({bool isMobile = false}) {
    return Row(
      mainAxisAlignment:
          isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        _buildSocialIconButton('assets/img/icons/fb.svg', isMobile: isMobile),
        _buildSocialIconButton('assets/img/icons/instagram.svg',
            isMobile: isMobile),
        _buildSocialIconButton('assets/img/icons/twitter.svg',
            isMobile: isMobile),
        _buildSocialIconButton('assets/img/icons/whatsapp.svg',
            isMobile: isMobile),
        _buildSocialIconButton('assets/img/icons/youtube.svg',
            isMobile: isMobile),
        _buildSocialIconButton('assets/img/icons/linkedin.svg',
            isMobile: isMobile),
      ],
    );
  }

  Widget _buildSocialIconButton(String assetPath, {bool isMobile = false}) {
    return Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: IconButton(
        icon: SvgPicture.asset(
          assetPath,
          width: isMobile ? 20 : 25,
          height: isMobile ? 20 : 25,
        ),
        onPressed: () {
          // Handle social media icon press action
        },
      ),
    );
  }

  Widget _buildFooterBottom(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isAndroid = defaultTargetPlatform == TargetPlatform.android;
    bool isMobile = isAndroid || screenWidth < 600;
    bool isTablet = !isAndroid && screenWidth >= 600 && screenWidth < 1024;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : (isTablet ? 50 : 100),
        vertical: isMobile ? 16 : 30,
      ),
      decoration: BoxDecoration(
        color: Colors.white54,
        border: Border.symmetric(
          horizontal: BorderSide(color: Colors.grey),
        ),
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Copyright © 2025 - All Rights Reserved ZEN CARE',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'Developed By Virtuous Global Solutions',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'Terms and Conditions | Privacy Policy',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.grey.shade600,
                        decoration: TextDecoration.underline,
                      ),
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Copyright © 2025 - All Rights Reserved ZEN CARE Developed By Virtuous Global Solutions',
                    style: isTablet
                        ? Theme.of(context).textTheme.bodyMedium
                        : Theme.of(context).textTheme.displayMedium,
                  ),
                ),
                Text(
                  'Terms and Conditions | Privacy Policy',
                  style: (isTablet
                          ? Theme.of(context).textTheme.bodyMedium
                          : Theme.of(context).textTheme.displayMedium)!
                      .copyWith(
                    color: Colors.grey.shade600,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
    );
  }
}

class ResponsiveFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 600;

    return Container(
      width: screenWidth,
      height: isMobile ? 80 : 50,
      color: Colors.blue.shade200,
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '© 2024 Gokkiddee. All rights reserved.',
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: isMobile ? 10 : 14,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Designed by Gokkiddee Team',
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: isMobile ? 8 : 12,
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }
}
