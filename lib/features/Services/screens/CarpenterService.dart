import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zencare/common/appbar.dart';
import 'package:zencare/common/footer.dart';
import 'package:zencare/features/Services/widgets/CarpenterServicesGrid.dart';
import 'package:zencare/features/Services/widgets/Packages.dart';
import 'package:zencare/features/controller.dart';

class CarpenterService extends StatefulWidget {
  const CarpenterService({super.key});

  @override
  State<CarpenterService> createState() => _CarpenterServiceState();
}

class _CarpenterServiceState extends State<CarpenterService> {
  // Global keys for scrolling to sections
  final GlobalKey doorAccessoryKey = GlobalKey();
  final GlobalKey doorLockKey = GlobalKey();
  final GlobalKey doorInstallationKey = GlobalKey();
  final GlobalKey meshGrillKey = GlobalKey();
  final GlobalKey curtainRodKey = GlobalKey();
  final GlobalKey bedSupportKey = GlobalKey();
  final GlobalKey cupboardHingeKey = GlobalKey();

  // Method to scroll to a specific section
  void scrollToSection(GlobalKey key) {
    print('Attempting to scroll to section'); // Debug print
    final context = key.currentContext;
    if (context != null) {
      print('Context found, scrolling...'); // Debug print
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
        alignment: 0.1, // Position at 10% from top of viewport
      );
    } else {
      print('Context is null!'); // Debug print
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final isDesktop = screenWidth >= 1024;
    final isMobile = screenWidth < 768;

    List<ExpansionTileData> doorAccessoryData = [
      ExpansionTileData(
          title: 'Service Includes',
          content:
          '1. Installation of door chains, hinges, latches, and closers\n'
              '2. Alignment and adjustment for smooth operation\n'
              '3. Quick testing for functionality\n'),
      ExpansionTileData(
          title: 'Not Included',
          content:
          '1. Cost of accessories (to be provided by the customer or arranged separately)\n'
              '2. Major modifications to the door structure\n'),
      ExpansionTileData(
          title: 'Duration',
          content: 'Approximately 30 mins per door\n'),
    ];

    List<ExpansionTileData> doorLockData = [
      ExpansionTileData(
          title: 'Service Includes',
          content:
          '1. Removal of old lock\n'
              '2. Installation of new lock (supplied by customer or arranged separately)\n'
              '3. Alignment check and operational testing of the new lock\n'),
      ExpansionTileData(
          title: 'Not Included',
          content:
          '1. Cost of new lock\n'
              '2. Additional door frame modifications\n'),
      ExpansionTileData(
          title: 'Duration',
          content: 'Approximately 30-45 minutes per lock\n'),
    ];

    List<ExpansionTileData> doorInstallationData = [
      ExpansionTileData(
          title: 'Service Includes',
          content:
          '1. Placement and alignment of the door\n'
              '2. Installation of hinges and primary lock (if applicable)\n'
              '3. Adjustment to ensure smooth operation\n'),
      ExpansionTileData(
          title: 'Not Included',
          content:
          '1. Cost of door and frame (arranged separately or by the customer)\n'
              '2. Finishing or painting services\n'),
      ExpansionTileData(
          title: 'Duration',
          content: 'Approximately 2-3 hours per door\n'),
    ];

    List<ExpansionTileData> meshGrillData = [
      ExpansionTileData(
          title: 'Service Includes',
          content:
          '1. Removal of old mesh grill door (if applicable)\n'
              '2. Installation of new mesh grill door with alignment check\n'
              '3. Minor adjustments for proper fitting\n'),
      ExpansionTileData(
          title: 'Not Included',
          content:
          '1. Cost of new mesh grill door\n'
              '2. Painting or finishing services\n'),
      ExpansionTileData(
          title: 'Duration',
          content: 'Approximately 1-2 hours\n'),
    ];

    List<ExpansionTileData> curtainRodData = [
      ExpansionTileData(
          title: 'Service Includes',
          content:
          '1. Measurement and alignment for curtain rod placement\n'
              '2. Installation of curtain rod brackets and rod\n'
              '3. Basic adjustments for proper support and alignment\n'),
      ExpansionTileData(
          title: 'Not Included',
          content:
          '1. Cost of curtain rod and mounting hardware\n'
              '2. Wall repairs or reinforcements for non-standard installations\n'),
      ExpansionTileData(
          title: 'Duration',
          content: 'Approximately 1 hour per window\n'),
    ];

    List<ExpansionTileData> bedSupportData = [
      ExpansionTileData(
          title: 'Service Includes',
          content:
          '1. Inspection of bed support structure\n'
              '2. Reinforcement or repair of broken or weak support slats\n'
              '3. Replacement of damaged support beams (if provided by the customer)\n'),
      ExpansionTileData(
          title: 'Not Included',
          content:
          '1. Cost of replacement parts (additional charges may apply or parts provided by the customer)\n'
              '2. Repairs to non-structural components (e.g., headboard, side rails)\n'),
      ExpansionTileData(
          title: 'Duration',
          content: 'Approximately 1-2 hours per bed\n'),
    ];

    List<ExpansionTileData> cupboardHingeData = [
      ExpansionTileData(
          title: 'Service Includes',
          content:
          '1. Installation of new hinges (customer-provided or arranged separately)\n'
              '2. Alignment and adjustment for proper door movement\n'
              '3. Tightening and securing of hinge screws\n'),
      ExpansionTileData(
          title: 'Not Included',
          content:
          '1. Cost of new hinges\n'
              '2. Structural modifications to the cupboard door or frame\n'),
      ExpansionTileData(
          title: 'Duration',
          content: 'Approximately 30 minutes per hinge\n'),
    ];

    return Scaffold(
      appBar: CustomAppBar(),
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
                doorAccessoryData,
                doorLockData,
                doorInstallationData,
                meshGrillData,
                curtainRodData,
                bedSupportData,
                cupboardHingeData,
              )
                  : _buildDesktopTabletLayout(
                doorAccessoryData,
                doorLockData,
                doorInstallationData,
                meshGrillData,
                curtainRodData,
                bedSupportData,
                cupboardHingeData,
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
      List<ExpansionTileData> doorAccessoryData,
      List<ExpansionTileData> doorLockData,
      List<ExpansionTileData> doorInstallationData,
      List<ExpansionTileData> meshGrillData,
      List<ExpansionTileData> curtainRodData,
      List<ExpansionTileData> bedSupportData,
      List<ExpansionTileData> cupboardHingeData,
      ) {
    return Column(
      children: [
        // Services Grid on top for mobile
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: CarpenterServiceGrid(
            onServiceTap: (String serviceName) {
              _handleServiceTap(serviceName);
            },
          ),
        ),
        // Package cards below
        Column(
          children: [
            PackageCard(
              key: doorAccessoryKey,
              expansionData: doorAccessoryData,
              packageTitle: 'Door Accessory Installation',
              packageDescription:
              'Install door chains, hinges, latches, closers; alignment, adjustment, and quick functionality testing.',
              packageHighlight:
              'The Door Accessory Installation Service includes the setup and installation of essential door accessories like chains, hinges, latches, and door closers, ensuring optimal security and ease of use.',
              packagePrice: '₹399',
              onAdd: () {
                // Fixed: Use Provider instead of creating new instance
                Provider.of<CartData>(context, listen: false)
                    .addPackage(context, 'Door Accessory Installation', '399');
              },
            ),
            SizedBox(height: 16),
            PackageCard(
              key: doorLockKey,
              expansionData: doorLockData,
              packageTitle: 'Door Lock Replacement',
              packageDescription:
              'Remove old lock, install new lock, alignment check, and operational testing.',
              packageHighlight:
              'Our Door Lock Replacement Service ensures that worn-out or outdated locks are replaced securely, enhancing both safety and functionality.',
              packagePrice: '₹499',
              onAdd: () {
                // Fixed: Use Provider instead of creating new instance
                Provider.of<CartData>(context, listen: false)
                    .addPackage(context, 'Door Lock Replacement', '499');
              },
            ),
            SizedBox(height: 16),
            PackageCard(
              key: doorInstallationKey,
              packageTitle: 'Door Installation',
              packageDescription:
              'Place and align door, install hinges and primary lock, adjust for smooth operation.',
              packageHighlight:
              'The Door Installation Service is designed to professionally install new doors, ensuring secure fitting and alignment.',
              packagePrice: '₹1999',
              expansionData: doorInstallationData,
              onAdd: () {
                // Fixed: Use Provider instead of creating new instance
                Provider.of<CartData>(context, listen: false)
                    .addPackage(context, 'Door Installation', '1999');
              },
            ),
            SizedBox(height: 16),
            PackageCard(
              key: meshGrillKey,
              packageTitle: 'Mesh Grill Door Replacement',
              packageDescription:
              'Remove old mesh grill door, install new door with alignment check, make minor adjustments for fitting.',
              packageHighlight:
              'The Mesh Grill Door Replacement Service installs or replaces mesh grill doors to improve ventilation and security for your property.',
              packagePrice: '₹1499',
              expansionData: meshGrillData,
              onAdd: () {
                // Fixed: Use Provider instead of creating new instance
                Provider.of<CartData>(context, listen: false)
                    .addPackage(context, 'Mesh Grill Door Replacement', '1499');
              },
            ),
            SizedBox(height: 16),
            PackageCard(
              key: curtainRodKey,
              packageTitle: 'Curtain Rod Installation',
              packageDescription:
              'Measure and align curtain rod, install brackets and rod, adjust for proper support and alignment.',
              packageHighlight:
              'Our Curtain Rod Installation Service provides professional installation of curtain rods, ensuring they are securely fitted to support various curtain styles and sizes, enhancing both functionality and decor.',
              packagePrice: '₹299',
              expansionData: curtainRodData,
              onAdd: () {
                // Fixed: Use Provider instead of creating new instance
                Provider.of<CartData>(context, listen: false)
                    .addPackage(context, 'Curtain Rod Installation', '299');
              },
            ),
            SizedBox(height: 16),
            PackageCard(
              key: bedSupportKey,
              packageTitle: 'Bed Support Repair',
              packageDescription:
              'Inspection of bed support structure, reinforcement or repair of broken or weak support slats, and replacement of damaged support beams.',
              packageHighlight:
              'Our Bed Support Repair Service addresses issues with bed support structures, ensuring a sturdy and balanced foundation for improved comfort and longevity. This service is ideal for beds that have sagging, weakened, or damaged supports.',
              packagePrice: '₹799',
              expansionData: bedSupportData,
              onAdd: () {
                // Fixed: Use Provider instead of creating new instance
                Provider.of<CartData>(context, listen: false)
                    .addPackage(context, 'Bed Support Repair', '799');
              },
            ),
            SizedBox(height: 16),
            PackageCard(
              key: cupboardHingeKey,
              packageTitle: 'Cupboard Hinge Installation',
              packageDescription:
              'Installation of new hinges, alignment and adjustment for proper door movement, tightening and securing of hinge screws.',
              packageHighlight:
              'Our Cupboard Hinge Installation Service ensures that cupboard doors are securely attached and aligned, providing smooth opening and closing.',
              packagePrice: '₹199',
              expansionData: cupboardHingeData,
              onAdd: () {
                // Fixed: Use Provider instead of creating new instance
                Provider.of<CartData>(context, listen: false)
                    .addPackage(context, 'Cupboard Hinge Installation', '199');
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopTabletLayout(
      List<ExpansionTileData> doorAccessoryData,
      List<ExpansionTileData> doorLockData,
      List<ExpansionTileData> doorInstallationData,
      List<ExpansionTileData> meshGrillData,
      List<ExpansionTileData> curtainRodData,
      List<ExpansionTileData> bedSupportData,
      List<ExpansionTileData> cupboardHingeData,
      bool isTablet,
      ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Services Grid - adjusted sizing for tablet
        Expanded(
          flex: isTablet ? 5 : 4, // Increased flex for tablet
          child: Container(
            constraints: BoxConstraints(
              maxWidth: isTablet ? 500 : 380, // Increased maxWidth for tablet
              minWidth: isTablet ? 380 : 320, // Added minWidth
            ),
            child: CarpenterServiceGrid(
              onServiceTap: (String serviceName) {
                _handleServiceTap(serviceName);
              },
            ),
          ),
        ),
        SizedBox(width: isTablet ? 20 : 24),
        // Package cards - adjusted flex
        Expanded(
          flex: isTablet ? 7 : 6, // Adjusted flex ratio
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              children: [
                PackageCard(
                  key: doorAccessoryKey,
                  expansionData: doorAccessoryData,
                  packageTitle: 'Door Accessory Installation',
                  packageDescription:
                  'Install door chains, hinges, latches, closers; alignment, adjustment, and quick functionality testing.',
                  packageHighlight:
                  'The Door Accessory Installation Service includes the setup and installation of essential door accessories like chains, hinges, latches, and door closers, ensuring optimal security and ease of use.',
                  packagePrice: '₹399',
                  onAdd: () {
                    // Fixed: Use Provider instead of creating new instance
                    Provider.of<CartData>(context, listen: false)
                        .addPackage(context, 'Door Accessory Installation', '399');
                  },
                ),
                SizedBox(height: 16),
                PackageCard(
                  key: doorLockKey,
                  expansionData: doorLockData,
                  packageTitle: 'Door Lock Replacement',
                  packageDescription:
                  'Remove old lock, install new lock, alignment check, and operational testing.',
                  packageHighlight:
                  'Our Door Lock Replacement Service ensures that worn-out or outdated locks are replaced securely, enhancing both safety and functionality.',
                  packagePrice: '₹499',
                  onAdd: () {
                    // Fixed: Use Provider instead of creating new instance
                    Provider.of<CartData>(context, listen: false)
                        .addPackage(context, 'Door Lock Replacement', '499');
                  },
                ),
                SizedBox(height: 16),
                PackageCard(
                  key: doorInstallationKey,
                  packageTitle: 'Door Installation',
                  packageDescription:
                  'Place and align door, install hinges and primary lock, adjust for smooth operation.',
                  packageHighlight:
                  'The Door Installation Service is designed to professionally install new doors, ensuring secure fitting and alignment.',
                  packagePrice: '₹1999',
                  expansionData: doorInstallationData,
                  onAdd: () {
                    // Fixed: Use Provider instead of creating new instance
                    Provider.of<CartData>(context, listen: false)
                        .addPackage(context, 'Door Installation', '1999');
                  },
                ),
                SizedBox(height: 16),
                PackageCard(
                  key: meshGrillKey,
                  packageTitle: 'Mesh Grill Door Replacement',
                  packageDescription:
                  'Remove old mesh grill door, install new door with alignment check, make minor adjustments for fitting.',
                  packageHighlight:
                  'The Mesh Grill Door Replacement Service installs or replaces mesh grill doors to improve ventilation and security for your property.',
                  packagePrice: '₹1499',
                  expansionData: meshGrillData,
                  onAdd: () {
                    // Fixed: Use Provider instead of creating new instance
                    Provider.of<CartData>(context, listen: false)
                        .addPackage(context, 'Mesh Grill Door Replacement', '1499');
                  },
                ),
                SizedBox(height: 16),
                PackageCard(
                  key: curtainRodKey,
                  packageTitle: 'Curtain Rod Installation',
                  packageDescription:
                  'Measure and align curtain rod, install brackets and rod, adjust for proper support and alignment.',
                  packageHighlight:
                  'Our Curtain Rod Installation Service provides professional installation of curtain rods, ensuring they are securely fitted to support various curtain styles and sizes, enhancing both functionality and decor.',
                  packagePrice: '₹299',
                  expansionData: curtainRodData,
                  onAdd: () {
                    // Fixed: Use Provider instead of creating new instance
                    Provider.of<CartData>(context, listen: false)
                        .addPackage(context, 'Curtain Rod Installation', '299');
                  },
                ),
                SizedBox(height: 16),
                PackageCard(
                  key: bedSupportKey,
                  packageTitle: 'Bed Support Repair',
                  packageDescription:
                  'Inspection of bed support structure, reinforcement or repair of broken or weak support slats, and replacement of damaged support beams.',
                  packageHighlight:
                  'Our Bed Support Repair Service addresses issues with bed support structures, ensuring a sturdy and balanced foundation for improved comfort and longevity. This service is ideal for beds that have sagging, weakened, or damaged supports.',
                  packagePrice: '₹799',
                  expansionData: bedSupportData,
                  onAdd: () {
                    // Fixed: Use Provider instead of creating new instance
                    Provider.of<CartData>(context, listen: false)
                        .addPackage(context, 'Bed Support Repair', '799');
                  },
                ),
                SizedBox(height: 16),
                PackageCard(
                  key: cupboardHingeKey,
                  packageTitle: 'Cupboard Hinge Installation',
                  packageDescription:
                  'Installation of new hinges, alignment and adjustment for proper door movement, tightening and securing of hinge screws.',
                  packageHighlight:
                  'Our Cupboard Hinge Installation Service ensures that cupboard doors are securely attached and aligned, providing smooth opening and closing.',
                  packagePrice: '₹199',
                  expansionData: cupboardHingeData,
                  onAdd: () {
                    // Fixed: Use Provider instead of creating new instance
                    Provider.of<CartData>(context, listen: false)
                        .addPackage(context, 'Cupboard Hinge Installation', '199');
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
    if (serviceName.contains('Door Accessory')) {
      scrollToSection(doorAccessoryKey);
    } else if (serviceName.contains('Door Lock')) {
      scrollToSection(doorLockKey);
    } else if (serviceName.contains('Door Installation')) {
      scrollToSection(doorInstallationKey);
    } else if (serviceName.contains('Mesh Grill')) {
      scrollToSection(meshGrillKey);
    } else if (serviceName.contains('Curtain Rod')) {
      scrollToSection(curtainRodKey);
    } else if (serviceName.contains('Bed Support')) {
      scrollToSection(bedSupportKey);
    } else if (serviceName.contains('Cupboard Hinge')) {
      scrollToSection(cupboardHingeKey);
    }
  }
}