import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zencare/common/footer.dart';
import 'package:zencare/common/zen_care_scaffold.dart';
import 'package:zencare/features/Services/widgets/CleaningServicesGrid.dart';
import 'package:zencare/features/Services/widgets/Packages.dart';
import 'package:zencare/features/controller.dart';

class CleaningServices extends StatefulWidget {
  const CleaningServices({super.key});

  @override
  State<CleaningServices> createState() => _CleaningServicesState();
}

class _CleaningServicesState extends State<CleaningServices> {
  // Global keys for scrolling to sections
  final GlobalKey basicFullHomeKey = GlobalKey();
  final GlobalKey deepFullHomeKey = GlobalKey();
  final GlobalKey unfurnishedApartmentKey = GlobalKey();
  final GlobalKey furnishedIndependentKey = GlobalKey();
  final GlobalKey bathroomCleaningKey = GlobalKey();

  // Method to scroll to a specific section
  void scrollToSection(GlobalKey key) {
    // print('Attempting to scroll to section'); // Debug print
    final context = key.currentContext;
    if (context != null) {
      // print('Context found, scrolling...'); // Debug print
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
        alignment: 0.1, // Position at 10% from top of viewport
      );
    } else {
      // print('Context is null!'); // Debug print
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isAndroid = defaultTargetPlatform == TargetPlatform.android;
    final isMobile = isAndroid || screenWidth < 768;
    final isTablet = !isAndroid && screenWidth >= 768 && screenWidth < 1024;
    final isDesktop = !isAndroid && screenWidth >= 1024;

    List<ExpansionTileData> basicFullHomeCleaningData = [
      ExpansionTileData(
          title: 'Ideal For',
          content: 'Regular upkeep, light dusting, and general cleaning.'),
      ExpansionTileData(
          title: 'Includes',
          content:
          '1. Living Room & Common Areas: Dusting furniture, TV units, and surfaces; vacuuming and mopping floors; cleaning mirrors and glass; cobweb removal.\n'
              '2. Bedrooms: Dusting furniture (beds, side tables, wardrobes); vacuuming and mopping floors; cleaning mirrors and glass\n'
              '3. Kitchen: Wiping countertops, cabinets, and appliance exteriors; cleaning sinks and faucets; sweeping and mopping floors\n'
              '4. Bathrooms: Cleaning sinks, mirrors, and countertops; scrubbing and disinfecting toilets, showers, and bathtubs; floor cleaning and mopping\n'),
      ExpansionTileData(
        title: 'Excluded',
        content:
        '1. Intensive scrubbing and deep cleaning; cleaning appliance interiors, cabinet interiors, and light fixtures; restoration, repairs, or painting.\n',
      ),
    ];

    List<ExpansionTileData> deepFullHomeCleaningData = [
      ExpansionTileData(
          title: 'Ideal For',
          content: 'Includes Everything in the Basic Cleaning Service Plus \n\n'
              '1. Living Room & Common Areas: Detailed cleaning of all furniture, including upholstery; cleaning light fixtures, fans, and switches; deep vacuuming of carpets and rugs.\n'
              '2. Bedrooms: Intensive cleaning of wardrobes and under/behind furniture.\n'
              '3.	Kitchen: Deep cleaning of all appliances (exterior), shelves, and drawers (interior and exterior); scrubbing tiles and grout.\n'
              '4. Bathrooms: Descaling faucets, showerheads, and fixtures; deep cleaning of tiles, grout, and hard-to-reach areas; intensive scrubbing and disinfection.\n'
              '5. Excluded: Cleaning chandeliers, ceiling fixtures, and non-tiled walls; restoration, repairs, or painting.\n'
              '6. Duration: 5-7 hours (depending on apartment size)'),
    ];

    List<ExpansionTileData> unFurnishedApartmentCleaningData = [
      ExpansionTileData(
          title: 'Ideal For',
          content: 'Regular upkeep and general cleaning of unfurnished spaces.\n\n'
              '1. Living Room & Common Areas: Sweeping and mopping floors; dusting walls, baseboards, and windowsills; cobweb removal; cleaning light switches and door handles.\n'
              '2. Bedrooms: Sweeping and mopping floors; dusting walls, baseboards, and windowsills; cleaning light switches and door handles.\n'
              '3. Kitchen: Wiping countertops and cabinet exteriors; cleaning sinks and faucets; sweeping and mopping floors.\n'
              '4. Bathrooms: Cleaning sinks, mirrors, and countertops; scrubbing and disinfecting toilets, showers, and bathtubs; floor cleaning and mopping; replenishing toiletries (if provided).\n'
              '5. Excluded:	Scrubbing non-tiled walls/ceilings; polishing or shining floors; restoration, leakage fixes, painting, touch-ups; cleaning inaccessible areas.\n'
              '6. Duration: 3-5 hours (depending on apartment size).\n'),
    ];

    List<ExpansionTileData> furnishedApartmentCleaningData = [
      ExpansionTileData(
          title: 'Ideal For',
          content: 'Regular upkeep, light dusting, and general cleaning \n\n'
              '1. Living Room & Common Areas: Dusting of furniture, TV units, and surfaces; vacuuming and mopping floors; cleaning of mirrors and glass surfaces; cobweb removal.\n'
              '2. Bedrooms: Dusting of furniture (beds, side tables, wardrobes); vacuuming and mopping floors; cleaning of mirrors and glass surfaces.\n'
              '3.	Kitchen: Wiping down countertops, cabinets, and appliances (exterior only); cleaning sinks and faucets; sweeping and mopping floors.\n'
              '4. Bathrooms: Cleaning sinks, mirrors, and countertops; scrubbing and disinfecting toilets, showers, and bathtubs; floor cleaning; replenishing toiletries (if provided).\n'
              '5. Excluded: Use of scrubbing machine, cleaning of cabinet interiors, wet wiping of non-tiled walls/ceiling, restoration, leakage fixes, or painting.\n'
              '6. Duration: 4-6 hours (depending on house size).\n'),
    ];

    List<ExpansionTileData> bathroomCleaningData = [
      ExpansionTileData(
          title: 'Ideal For',
          content: 'What\'s Included?\n\n'
              '1. Wet Cleaning: '
              'Geyser, exhaust fan, and switchboards'
              'Doors, windows, glass partitions, and mirrors \n'
              '2. Stain Removal: Shower, taps, toilet, and tiles: '
              ' Basin, door, water closet, and drain trap\n'
              '3. Floor Cleaning: •	Deep cleaning of tiles, grouts (tile gaps), and corners.\n'
              '4. Surface Cleaning: •	Thorough cleaning of all surfaces, objects, and toiletries.\n'
              '5. What\'s Not Included?\n'
              '•	Removing paint stains\n'
              '•	Cleaning walls or ceilings\n'
              '•	Repairing leaks, painting, or any restoration work\n'
              '•	Scrubbing with machines\n'
              '•	Emptying or cleaning inside cabinets\n\n'
              'Time Required: '
              '60 - 90 minutes (may vary based on bathroom size)'),
    ];

    return ZenCareScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16.0 : isTablet ? 32.0 : 100.0,
                vertical: 16.0,
              ),
              child: isMobile
                  ? _buildMobileLayout(
                context,
                basicFullHomeCleaningData,
                deepFullHomeCleaningData,
                unFurnishedApartmentCleaningData,
                furnishedApartmentCleaningData,
                bathroomCleaningData,
              )
                  : _buildDesktopTabletLayout(
                context,
                basicFullHomeCleaningData,
                deepFullHomeCleaningData,
                unFurnishedApartmentCleaningData,
                furnishedApartmentCleaningData,
                bathroomCleaningData,
                isTablet,
              ),
            ),
            Footer()
          ],
        ),
      ),
    );
  }

  Widget _buildMobileLayout(
      BuildContext context,
      List<ExpansionTileData> basicFullHomeCleaningData,
      List<ExpansionTileData> deepFullHomeCleaningData,
      List<ExpansionTileData> unFurnishedApartmentCleaningData,
      List<ExpansionTileData> furnishedApartmentCleaningData,
      List<ExpansionTileData> bathroomCleaningData,
      ) {
    return Column(
      children: [
        // Services Grid on top for mobile
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: CleaningServicesGrid(
            onServiceTap: (String serviceName) {
              _handleServiceTap(serviceName);
            },
          ),
        ),
        // Package cards below
        Column(
          children: [
            PackageCard(
              key: basicFullHomeKey,
              expansionData: basicFullHomeCleaningData,
              packageTitle: 'Basic Full Home Cleaning',
              packageHighlight: '',
              packageDescription:
              'Regular upkeep and general cleaning, including dusting, vacuuming, mopping, and surface cleaning in all rooms.',
              packagePrice: '₹2799/-',
              onAdd: () {
                final cartData = Provider.of<CartData>(context, listen: false);
                cartData.addPackage(context, 'Basic Full Home Cleaning', '2799');
              },
            ),
            SizedBox(height: 16),
            PackageCard(
              key: deepFullHomeKey,
              packageTitle: 'Deep Full Home Cleaning',
              packageHighlight: '',
              packageDescription:
              'Thorough cleaning with deep vacuuming, upholstery care, machine scrubbing, and appliance interiors.',
              packagePrice: '₹3499',
              expansionData: deepFullHomeCleaningData,
              onAdd: () {
                final cartData = Provider.of<CartData>(context, listen: false);
                cartData.addPackage(context, 'Deep Full Home Cleaning', '3499');
              },
            ),
            SizedBox(height: 16),
            PackageCard(
              key: unfurnishedApartmentKey,
              expansionData: unFurnishedApartmentCleaningData,
              packageTitle: 'Unfurnished Apartment Basic Full Home Cleaning',
              packageHighlight: '',
              packageDescription:
              'Regular upkeep of unfurnished spaces; includes sweeping, mopping, dusting, and surface cleaning.',
              packagePrice: '₹1999/-',
              onAdd: () {
                final cartData = Provider.of<CartData>(context, listen: false);
                cartData.addPackage(context, 'Unfurnished Apartment Basic Full Home Cleaning', '1999');
              },
            ),
            SizedBox(height: 16),
            PackageCard(
              key: furnishedIndependentKey,
              expansionData: furnishedApartmentCleaningData,
              packageTitle: 'Furnished Independent Basic Full Home Cleaning',
              packageHighlight: '',
              packageDescription:
              'Routine upkeep with light dusting, vacuuming, mopping, surface cleaning, and light manual scrubbing.',
              packagePrice: '₹2499/-',
              onAdd: () {
                final cartData = Provider.of<CartData>(context, listen: false);
                cartData.addPackage(context, 'Furnished Independent Basic Full Home Cleaning', '2499');
              },
            ),
            SizedBox(height: 16),
            PackageCard(
              key: bathroomCleaningKey,
              expansionData: bathroomCleaningData,
              packageTitle: 'Bathroom Cleaning',
              packageHighlight: '',
              packageDescription:
              'Wet cleaning fixtures, stain removal on fittings, deep tile cleaning, and surface sanitization.',
              packagePrice: '₹899/-',
              onAdd: () {
                final cartData = Provider.of<CartData>(context, listen: false);
                cartData.addPackage(context, 'Bathroom Cleaning', '899');
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopTabletLayout(
      BuildContext context,
      List<ExpansionTileData> basicFullHomeCleaningData,
      List<ExpansionTileData> deepFullHomeCleaningData,
      List<ExpansionTileData> unFurnishedApartmentCleaningData,
      List<ExpansionTileData> furnishedApartmentCleaningData,
      List<ExpansionTileData> bathroomCleaningData,
      bool isTablet,
      ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Services Grid - flexible sizing based on screen
        Expanded(
          flex: isTablet ? 2 : 1,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: isTablet ? 400 : 350,
            ),
            child: CleaningServicesGrid(
              onServiceTap: (String serviceName) {
                _handleServiceTap(serviceName);
              },
            ),
          ),
        ),
        SizedBox(width: isTablet ? 16 : 24),
        // Package cards - takes more space
        Expanded(
          flex: isTablet ? 3 : 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              children: [
                PackageCard(
                  key: basicFullHomeKey,
                  expansionData: basicFullHomeCleaningData,
                  packageTitle: 'Basic Full Home Cleaning',
                  packageHighlight: '',
                  packageDescription:
                  'Regular upkeep and general cleaning, including dusting, vacuuming, mopping, and surface cleaning in all rooms.',
                  packagePrice: '₹2799/-',
                  onAdd: () {
                    final cartData = Provider.of<CartData>(context, listen: false);
                    cartData.addPackage(context, 'Basic Full Home Cleaning', '2799');
                  },
                ),
                SizedBox(height: 16),
                PackageCard(
                  key: deepFullHomeKey,
                  packageTitle: 'Deep Full Home Cleaning',
                  packageHighlight: '',
                  packageDescription:
                  'Thorough cleaning with deep vacuuming, upholstery care, machine scrubbing, and appliance interiors.',
                  packagePrice: '₹3499',
                  expansionData: deepFullHomeCleaningData,
                  onAdd: () {
                    final cartData = Provider.of<CartData>(context, listen: false);
                    cartData.addPackage(context, 'Deep Full Home Cleaning', '3499');
                  },
                ),
                SizedBox(height: 16),
                PackageCard(
                  key: unfurnishedApartmentKey,
                  expansionData: unFurnishedApartmentCleaningData,
                  packageTitle: 'Unfurnished Apartment Basic Full Home Cleaning',
                  packageHighlight: '',
                  packageDescription:
                  'Regular upkeep of unfurnished spaces; includes sweeping, mopping, dusting, and surface cleaning.',
                  packagePrice: '₹1999/-',
                  onAdd: () {
                    final cartData = Provider.of<CartData>(context, listen: false);
                    cartData.addPackage(context, 'Unfurnished Apartment Basic Full Home Cleaning', '1999');
                  },
                ),
                SizedBox(height: 16),
                PackageCard(
                  key: furnishedIndependentKey,
                  expansionData: furnishedApartmentCleaningData,
                  packageTitle: 'Furnished Independent Basic Full Home Cleaning',
                  packageHighlight: '',
                  packageDescription:
                  'Routine upkeep with light dusting, vacuuming, mopping, surface cleaning, and light manual scrubbing.',
                  packagePrice: '₹2499/-',
                  onAdd: () {
                    final cartData = Provider.of<CartData>(context, listen: false);
                    cartData.addPackage(context, 'Furnished Independent Basic Full Home Cleaning', '2499');
                  },
                ),
                SizedBox(height: 16),
                PackageCard(
                  key: bathroomCleaningKey,
                  expansionData: bathroomCleaningData,
                  packageTitle: 'Bathroom Cleaning',
                  packageHighlight: '',
                  packageDescription:
                  'Wet cleaning fixtures, stain removal on fittings, deep tile cleaning, and surface sanitization.',
                  packagePrice: '₹899/-',
                  onAdd: () {
                    final cartData = Provider.of<CartData>(context, listen: false);
                    cartData.addPackage(context, 'Bathroom Cleaning', '899');
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  // Handle service card tap and scroll to corresponding section
  void _handleServiceTap(String serviceName) {
    if (serviceName.contains('Full House Cleaning')) {
      scrollToSection(basicFullHomeKey);
    } else if (serviceName.contains('Deep Full Home Cleaning')) {
      scrollToSection(deepFullHomeKey);
    } else if (serviceName.contains('Unfurnished Apartment')) {
      scrollToSection(unfurnishedApartmentKey);
    } else if (serviceName.contains('Furnished Independent')) {
      scrollToSection(furnishedIndependentKey);
    } else if (serviceName.contains('Bathroom & Kitchen Cleaning')) {
      scrollToSection(bathroomCleaningKey);
    }
  }
}