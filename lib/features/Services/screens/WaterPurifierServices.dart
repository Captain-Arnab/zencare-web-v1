import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zencare/common/footer.dart';
import 'package:zencare/common/zen_care_scaffold.dart';
import 'package:zencare/features/Services/widgets/Packages.dart';
import 'package:zencare/features/Services/widgets/WaterPurifierServicesGrid.dart';
import 'package:zencare/features/controller.dart';

class WaterPurifierService extends StatefulWidget {
  const WaterPurifierService({super.key});

  @override
  State<WaterPurifierService> createState() => _WaterPurifierServiceState();
}

class _WaterPurifierServiceState extends State<WaterPurifierService> {
  // Global keys for scrolling to sections
  final GlobalKey waterPurifierServiceKey = GlobalKey();
  final GlobalKey notDispensingWaterKey = GlobalKey();
  final GlobalKey lowWaterPressureKey = GlobalKey();
  final GlobalKey pumpRepairKey = GlobalKey();
  final GlobalKey uvLampReplacementKey = GlobalKey();
  final GlobalKey filterReplacementKey = GlobalKey();
  final GlobalKey installationKey = GlobalKey();
  final GlobalKey uninstallationKey = GlobalKey();

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
    final isAndroid = defaultTargetPlatform == TargetPlatform.android;
    final isMobile = isAndroid || screenWidth < 768;
    final isTablet = !isAndroid && screenWidth >= 768 && screenWidth < 1024;
    final isDesktop = !isAndroid && screenWidth >= 1024;

    List<ExpansionTileData> waterPurifierService = [
      ExpansionTileData(
          title: 'Service Includes',
          content:
          '1. Thorough inspection of the entire water purifier system.\n'
              '2. Cleaning of the pre-filter, RO membrane, and other internal components.\n'
              '3. Replacement of worn-out or clogged filters (as needed).\n'
              '4. Checking of TDS levels and adjustment if required.\n'
              '5. Testing and calibration of all essential functions.\n'
              '6. Inspection of water inlet/outlet connections for leaks.\n'
              '7. UV lamp and pump functionality check (if applicable).'),
      ExpansionTileData(
          title: 'Excluded',
          content: '1. Replacement of RO membrane (unless specified).\n'
              '2. Major component replacements outside regular filter changes.\n'
              '3. Repairs to components unrelated to the service process (available separately).'),
      ExpansionTileData(
        title: 'Recommended Frequency',
        content:
        'It is recommended to service your water purifier every 6 to 12 months for optimal performance and consistent water quality\n',
      ),
    ];

    List<ExpansionTileData> waterPurifiernotDispensingWater = [
      ExpansionTileData(
          title: 'Common Problems',
          content:
          '1. Blocked water filters or inlet.\n'
              '2. Malfunctioning pump or water pressure issues.\n'
              '3. Faulty valves preventing water flow\n'),
      ExpansionTileData(
          title: 'Service Inclusions',
          content: '1. Diagnosis of water flow issues.\n'
              '2. Cleaning or replacement of blocked filters.\n'
              '3. Repair or replacement of faulty components affecting water flow'),
      ExpansionTileData(
        title: 'Exclusions',
        content:
        '1.Replacement of major components (e.g., pump)\n'
            '2. Full cleaning of the water purifier\n',
      ),
    ];

    List<ExpansionTileData> lowWaterPressure = [
      ExpansionTileData(
          title: 'Common Problems',
          content:
          '1. Blocked filters reducing water flow.\n'
              '2. Malfunctioning pump affecting water pressure.\n'
              '3. Low inlet water pressure from the main supply\n'),
      ExpansionTileData(
          title: 'Service Inclusions',
          content: '1. Diagnosis of water flow issues.\n'
              '2. Cleaning or replacement of filters affecting pressure.\n'
              '3. Testing to ensure proper water pressure and flow'),
      ExpansionTileData(
        title: 'Exclusions',
        content:
        '1.Replacement of major components (e.g., pump)\n'
            '2. Full cleaning of the water purifier\n',
      ),
    ];

    List<ExpansionTileData> pumpRepairReplacement = [
      ExpansionTileData(
          title: 'Common Problems',
          content:
          '1. Pump not working or making unusual noises.\n'
              '2. Inconsistent water pressure due to pump issues.\n'
              '3. Reduced water flow because of pump malfunction\n'),
      ExpansionTileData(
          title: 'Service Inclusions',
          content: '1. Diagnosis of pump issues.\n'
              '2. Repair or replacement of malfunctioning pump.\n'
              '3. Testing to ensure effective water pressure and flow'),
      ExpansionTileData(
        title: 'Exclusions',
        content:
        '1. Replacement of unrelated components\n'
            '2. Full system cleaning\n',
      ),
    ];

    List<ExpansionTileData> uvLampReplacement = [
      ExpansionTileData(
          title: 'Common Problems',
          content:
          '1. Worn-out filters impacting water taste.\n'
              '2. Accumulated residue or bacteria causing odors.\n'
              '3. Faulty carbon filter or RO membrane\n'),
      ExpansionTileData(
          title: 'Service Inclusions',
          content: '1. Diagnosis of taste and odor issues.\n'
              '2. Cleaning or replacement of affected filters.\n'
              '3. Testing to ensure water quality improvement'),
      ExpansionTileData(
        title: 'Exclusions',
        content:
        '1. Replacement of additional components not causing odor or taste issues\n'
            '2. Full internal cleaning of the unit\n',
      ),
    ];

    List<ExpansionTileData> filterReplacement = [
      ExpansionTileData(
          title: 'Common Problems',
          content:
          '1. Reduced water flow due to clogged filters.\n'
              '2. Poor water taste caused by expired filters.\n'
              '3. Lower purification effectiveness\n'),
      ExpansionTileData(
          title: 'Service Inclusions',
          content: '1. Removal of old filters.\n'
              '2. Installation of new, compatible filters.\n'
              '3. Testing to ensure optimal purification'),
      ExpansionTileData(
        title: 'Exclusions',
        content:
        '1. Replacement of filters outside the main purifier\n'
            '2. Repairs unrelated to filter performance\n',
      ),
    ];

    List<ExpansionTileData> installation = [
      ExpansionTileData(
          title: 'Common Problems',
          content:
          '1. Incorrect installation leading to water leaks or low purification efficiency..\n'
              '2. Improper alignment or placement affecting usability.\n'
              '3. Unsafe connections that compromise water quality\n'),
      ExpansionTileData(
          title: 'Service Inclusions',
          content: '1. Secure mounting and installation of the water purifier unit..\n'
              '2. Connection to water supply lines and verification of water flow.\n'
              '3. Testing of water purifier operation to confirm proper functionality.'
              '4. Checking for leaks and ensuring safe, sealed connections'),
      ExpansionTileData(
        title: 'Exclusions',
        content:
        '1. Installation of new water pipelines or fittings\n'
            '2. Electrical outlet installation for purifiers requiring power\n'
            '3. Additional purification filters or accessories not included in the main unit',
      ),
    ];

    List<ExpansionTileData> uninstallation = [
      ExpansionTileData(
          title: 'Service Inclusions',
          content:
          '1. Safely disconnect water purifier from water supply lines.\n'
              '2. Careful unmounting of the unit without damage.\n'
              '3. Sealing of water connections to prevent leaks.\n'
              '4. Cleaning up the work area after removal.\n'
              '5. Post-uninstallation inspection to ensure no damage or leaks.'),
      ExpansionTileData(
          title: 'Exclusions',
          content:
          '1. Reinstallation at a new location (available as separate service).\n'
              '2. Disposal of the old water purifier unit.\n'
              '3. Repair of wall damage from previous installation.'),
    ];

    return ZenCareScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16.0 : isTablet ? 32.0 : 100.0,
                vertical: isMobile ? 16.0 : 20.0,
              ),
              child: isMobile
                  ? _buildMobileLayout(
                context,
                waterPurifierService,
                waterPurifiernotDispensingWater,
                lowWaterPressure,
                pumpRepairReplacement,
                uvLampReplacement,
                filterReplacement,
                installation,
                uninstallation,
              )
                  : _buildDesktopTabletLayout(
                context,
                waterPurifierService,
                waterPurifiernotDispensingWater,
                lowWaterPressure,
                pumpRepairReplacement,
                uvLampReplacement,
                filterReplacement,
                installation,
                uninstallation,
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
      List<ExpansionTileData> waterPurifierService,
      List<ExpansionTileData> waterPurifiernotDispensingWater,
      List<ExpansionTileData> lowWaterPressure,
      List<ExpansionTileData> pumpRepairReplacement,
      List<ExpansionTileData> uvLampReplacement,
      List<ExpansionTileData> filterReplacement,
      List<ExpansionTileData> installation,
      List<ExpansionTileData> uninstallation,
      ) {
    return Column(
      children: [
        // Services Grid on top for mobile
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: WaterPurifierServicesGrid(
            onServiceTap: (String serviceName) {
              _handleServiceTap(serviceName);
            },
          ),
        ),
        // Package cards below
        Column(
          children: [
            PackageCard(
              key: waterPurifierServiceKey,
              onAdd: () {
                final cartData = Provider.of<CartData>(context, listen: false);
                cartData.addPackage(context, 'Water Purifier Service', '399');
              },
              expansionData: waterPurifierService,
              packageTitle: 'Water Purifier Service',
              packageDescription:
              'Inspect purifier, clean filters and RO membrane, replace if needed, check TDS, test functions, inspect for leaks, and verify UV/pump.',
              packageHighlight:
              'The Water Purifier Service package provides a comprehensive maintenance check for your water purifier, ensuring it operates at peak efficiency. Regular servicing helps improve water quality, maintain optimal filtration, and prolong the lifespan of the purifier by preventing potential issues related to filters, membranes, and other internal components.',
              packagePrice: '₹399/-',
            ),
            SizedBox(height: 16),
            PackageCard(
              key: notDispensingWaterKey,
              onAdd: () {
                final cartData = Provider.of<CartData>(context, listen: false);
                cartData.addPackage(context, 'Water Purifier Not Dispensing Water', '399');
              },
              expansionData: waterPurifiernotDispensingWater,
              packageTitle: 'Water Purifier Not Dispensing Water',
              packageDescription:
              'Diagnose flow issues, clean/replace filters, and repair/replace faulty components affecting water flow\n',
              packageHighlight:
              'The Water Purifier Not Dispensing Water service addresses issues that prevent water from flowing from your purifier. This service ensures quick diagnosis and repair to restore water flow for clean and consistent water dispensing\n',
              packagePrice: '₹399/-',
            ),
            SizedBox(height: 16),
            PackageCard(
              key: lowWaterPressureKey,
              onAdd: () {
                final cartData = Provider.of<CartData>(context, listen: false);
                cartData.addPackage(context, 'Water Purifier Low Water Pressure', '399');
              },
              expansionData: lowWaterPressure,
              packageTitle: 'Water Purifier Low Water Pressure',
              packageDescription:
              'Diagnose pressure issues, clean/replace filters, and test for proper water pressure and flow\n',
              packageHighlight:
              'The Water Purifier Low Water Pressure service addresses issues with inadequate water pressure, essential for optimal purification performance\n',
              packagePrice: '₹399/-',
            ),
            SizedBox(height: 16),
            PackageCard(
              key: pumpRepairKey,
              onAdd: () {
                final cartData = Provider.of<CartData>(context, listen: false);
                cartData.addPackage(context, 'Water Purifier Pump Repair/Replacement', '399');
              },
              expansionData: pumpRepairReplacement,
              packageTitle: 'Water Purifier Pump Repair/Replacement',
              packageDescription:
              'Diagnose pump issues, repair/replace malfunctioning pump, and test for proper pressure and flow\n',
              packageHighlight:
              'The Water Purifier Pump Repair/Replacement service ensures that the pump, critical for water flow and pressure, operates efficiently to maintain purification levels\n',
              packagePrice: '₹399/-',
            ),
            SizedBox(height: 16),
            PackageCard(
              key: uvLampReplacementKey,
              onAdd: () {
                final cartData = Provider.of<CartData>(context, listen: false);
                cartData.addPackage(context, 'Water Purifier UV Lamp Replacement', '399');
              },
              expansionData: uvLampReplacement,
              packageTitle: 'Water Purifier UV Lamp Replacement',
              packageDescription:
              'Diagnose taste/odor issues, clean/replace filters, and test for improved water quality\n',
              packageHighlight:
              'The Water Purifier Taste and Odor Issues service addresses problems with unpleasant tastes or odors in purified water, restoring freshness and quality\n',
              packagePrice: '₹399/-',
            ),
            SizedBox(height: 16),
            PackageCard(
              key: filterReplacementKey,
              onAdd: () {
                final cartData = Provider.of<CartData>(context, listen: false);
                cartData.addPackage(context, 'Water Purifier Filter Replacement', '599');
              },
              expansionData: filterReplacement,
              packageTitle: 'Water Purifier Filter Replacement',
              packageDescription:
              'Remove old filters, install new ones, and test for optimal purification\n',
              packageHighlight:
              'The Water Purifier Filter Replacement service replaces worn-out filters, ensuring the purifier functions efficiently for clean, high-quality water\n',
              packagePrice: '₹599/-',
            ),
            SizedBox(height: 16),
            PackageCard(
              key: installationKey,
              onAdd: () {
                final cartData = Provider.of<CartData>(context, listen: false);
                cartData.addPackage(context, 'Water Purifier Installation', '349');
              },
              expansionData: installation,
              packageTitle: 'Water Purifier Installation',
              packageDescription:
              'Mount and install water purifier, connect to supply lines, test operation, and check for leaks and secure connections\n',
              packageHighlight:
              'The Water Purifier Installation service ensures that your water purifier is installed professionally and safely for optimal performance and convenience. Our trained technicians handle the installation process, connecting the purifier to the water supply and ensuring that it operates efficiently for clean, purified water\n',
              packagePrice: '₹349/-',
            ),
            SizedBox(height: 16),
            PackageCard(
              key: uninstallationKey,
              onAdd: () {
                final cartData = Provider.of<CartData>(context, listen: false);
                cartData.addPackage(context, 'Water Purifier Uninstallation', '349');
              },
              expansionData: uninstallation,
              packageTitle: 'Water Purifier Uninstallation',
              packageDescription:
              'Safely disconnect water purifier, unmount unit, seal connections to prevent leaks, and clean up the work area.\n',
              packageHighlight:
              'The Water Purifier Uninstallation service ensures safe and efficient removal of your water purifier unit for relocation, replacement, or disposal.',
              packagePrice: '₹349/-',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopTabletLayout(
      BuildContext context,
      List<ExpansionTileData> waterPurifierService,
      List<ExpansionTileData> waterPurifiernotDispensingWater,
      List<ExpansionTileData> lowWaterPressure,
      List<ExpansionTileData> pumpRepairReplacement,
      List<ExpansionTileData> uvLampReplacement,
      List<ExpansionTileData> filterReplacement,
      List<ExpansionTileData> installation,
      List<ExpansionTileData> uninstallation,
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
            child: WaterPurifierServicesGrid(
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
          child: Column(
            children: [
              PackageCard(
                key: waterPurifierServiceKey,
                onAdd: () {
                  final cartData = Provider.of<CartData>(context, listen: false);
                  cartData.addPackage(context, 'Water Purifier Service', '399');
                },
                expansionData: waterPurifierService,
                packageTitle: 'Water Purifier Service',
                packageDescription:
                'Inspect purifier, clean filters and RO membrane, replace if needed, check TDS, test functions, inspect for leaks, and verify UV/pump.',
                packageHighlight:
                'The Water Purifier Service package provides a comprehensive maintenance check for your water purifier, ensuring it operates at peak efficiency. Regular servicing helps improve water quality, maintain optimal filtration, and prolong the lifespan of the purifier by preventing potential issues related to filters, membranes, and other internal components.',
                packagePrice: '₹399/-',
              ),
              SizedBox(height: 16),
              PackageCard(
                key: notDispensingWaterKey,
                onAdd: () {
                  final cartData = Provider.of<CartData>(context, listen: false);
                  cartData.addPackage(context, 'Water Purifier Not Dispensing Water', '399');
                },
                expansionData: waterPurifiernotDispensingWater,
                packageTitle: 'Water Purifier Not Dispensing Water',
                packageDescription:
                'Diagnose flow issues, clean/replace filters, and repair/replace faulty components affecting water flow\n',
                packageHighlight:
                'The Water Purifier Not Dispensing Water service addresses issues that prevent water from flowing from your purifier. This service ensures quick diagnosis and repair to restore water flow for clean and consistent water dispensing\n',
                packagePrice: '₹399/-',
              ),
              SizedBox(height: 16),
              PackageCard(
                key: lowWaterPressureKey,
                onAdd: () {
                  final cartData = Provider.of<CartData>(context, listen: false);
                  cartData.addPackage(context, 'Water Purifier Low Water Pressure', '399');
                },
                expansionData: lowWaterPressure,
                packageTitle: 'Water Purifier Low Water Pressure',
                packageDescription:
                'Diagnose pressure issues, clean/replace filters, and test for proper water pressure and flow\n',
                packageHighlight:
                'The Water Purifier Low Water Pressure service addresses issues with inadequate water pressure, essential for optimal purification performance\n',
                packagePrice: '₹399/-',
              ),
              SizedBox(height: 16),
              PackageCard(
                key: pumpRepairKey,
                onAdd: () {
                  final cartData = Provider.of<CartData>(context, listen: false);
                  cartData.addPackage(context, 'Water Purifier Pump Repair/Replacement', '399');
                },
                expansionData: pumpRepairReplacement,
                packageTitle: 'Water Purifier Pump Repair/Replacement',
                packageDescription:
                'Diagnose pump issues, repair/replace malfunctioning pump, and test for proper pressure and flow\n',
                packageHighlight:
                'The Water Purifier Pump Repair/Replacement service ensures that the pump, critical for water flow and pressure, operates efficiently to maintain purification levels\n',
                packagePrice: '₹399/-',
              ),
              SizedBox(height: 16),
              PackageCard(
                key: uvLampReplacementKey,
                onAdd: () {
                  final cartData = Provider.of<CartData>(context, listen: false);
                  cartData.addPackage(context, 'Water Purifier UV Lamp Replacement', '399');
                },
                expansionData: uvLampReplacement,
                packageTitle: 'Water Purifier UV Lamp Replacement',
                packageDescription:
                'Diagnose taste/odor issues, clean/replace filters, and test for improved water quality\n',
                packageHighlight:
                'The Water Purifier Taste and Odor Issues service addresses problems with unpleasant tastes or odors in purified water, restoring freshness and quality\n',
                packagePrice: '₹399/-',
              ),
              SizedBox(height: 16),
              PackageCard(
                key: filterReplacementKey,
                onAdd: () {
                  final cartData = Provider.of<CartData>(context, listen: false);
                  cartData.addPackage(context, 'Water Purifier Filter Replacement', '599');
                },
                expansionData: filterReplacement,
                packageTitle: 'Water Purifier Filter Replacement',
                packageDescription:
                'Remove old filters, install new ones, and test for optimal purification\n',
                packageHighlight:
                'The Water Purifier Filter Replacement service replaces worn-out filters, ensuring the purifier functions efficiently for clean, high-quality water\n',
                packagePrice: '₹599/-',
              ),
              SizedBox(height: 16),
              PackageCard(
                key: installationKey,
                onAdd: () {
                  final cartData = Provider.of<CartData>(context, listen: false);
                  cartData.addPackage(context, 'Water Purifier Installation', '349');
                },
                expansionData: installation,
                packageTitle: 'Water Purifier Installation',
                packageDescription:
                'Mount and install water purifier, connect to supply lines, test operation, and check for leaks and secure connections\n',
                packageHighlight:
                'The Water Purifier Installation service ensures that your water purifier is installed professionally and safely for optimal performance and convenience. Our trained technicians handle the installation process, connecting the purifier to the water supply and ensuring that it operates efficiently for clean, purified water\n',
                packagePrice: '₹349/-',
              ),
              SizedBox(height: 16),
              PackageCard(
                key: uninstallationKey,
                onAdd: () {
                  final cartData = Provider.of<CartData>(context, listen: false);
                  cartData.addPackage(context, 'Water Purifier Uninstallation', '349');
                },
                expansionData: uninstallation,
                packageTitle: 'Water Purifier Uninstallation',
                packageDescription:
                'Safely disconnect water purifier, unmount unit, seal connections to prevent leaks, and clean up the work area.\n',
                packageHighlight:
                'The Water Purifier Uninstallation service ensures safe and efficient removal of your water purifier unit for relocation, replacement, or disposal.',
                packagePrice: '₹349/-',
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Handle service card tap and scroll to corresponding section
  void _handleServiceTap(String serviceName) {
    if (serviceName.contains('Water Purifier Service') && !serviceName.contains('Not Dispensing') && !serviceName.contains('Low Water') && !serviceName.contains('Pump') && !serviceName.contains('UV') && !serviceName.contains('Filter') && !serviceName.contains('Installation') && !serviceName.contains('Uninstallation')) {
      scrollToSection(waterPurifierServiceKey);
    } else if (serviceName.contains('Not Dispensing Water')) {
      scrollToSection(notDispensingWaterKey);
    } else if (serviceName.contains('Low Water Pressure')) {
      scrollToSection(lowWaterPressureKey);
    } else if (serviceName.contains('Pump Repair/Replacement')) {
      scrollToSection(pumpRepairKey);
    } else if (serviceName.contains('UV Lamp Replacement')) {
      scrollToSection(uvLampReplacementKey);
    } else if (serviceName.contains('Filter Replacement')) {
      scrollToSection(filterReplacementKey);
    } else if (serviceName.contains('Installation') && !serviceName.contains('Uninstallation')) {
      scrollToSection(installationKey);
    } else if (serviceName.contains('Uninstallation')) {
      scrollToSection(uninstallationKey);
    }
  }
}