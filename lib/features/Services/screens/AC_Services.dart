import 'package:flutter/material.dart';
import 'package:zencare/common/appbar.dart';
import 'package:zencare/common/footer.dart';
import 'package:zencare/features/Services/widgets/ACServicesGrid.dart';
import 'package:zencare/features/Services/widgets/Packages.dart';
import 'package:zencare/features/controller.dart';
import 'package:provider/provider.dart';

class ACService extends StatefulWidget {
  const ACService({super.key});

  @override
  State<ACService> createState() => _ACServiceState();
}

class _ACServiceState extends State<ACService> {
  // Global keys for scrolling to sections
  final GlobalKey foamServiceKey = GlobalKey();
  final GlobalKey gasRefillKey = GlobalKey();
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
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final isDesktop = screenWidth >= 1024;
    final isMobile = screenWidth < 768;

    List<ExpansionTileData> foamServiceData = [
      ExpansionTileData(
          title: 'What\'s Included?',
          content:
          '1.	Deep Cleaning of Indoor Unit : AdvancedFoam Jet cleaning filters, cooling coils, and drain tray\n'
              '2. Removes dust, improves airflow, and boosts cooling\n'
              '3.	Outdoor Unit Power jet Cleaning.\n'
              '4.	High-pressure Power Jet wash clean the outdoor unit.\n'
              '5.	Helps in faster cooling and extends AC life.\n'),
      ExpansionTileData(
          title: 'Full AC Checkup',
          content: '1. Gas level check ensure proper cooling.\n'
              '2.	Wiring & electrical inspection for safety.\n'),
      ExpansionTileData(
          title: 'Mess-Free Service',
          content: '1. AC is covered with a protective jacket avoid spills\n'
              '2. Full area cleaning after service'
              '3. Final Testing & Quality Check'
              '4. Technician checks for pipe blockages & water leakage'),
      ExpansionTileData(
          title: 'Why Choose This Saver Pack?',
          content: '1. Covers 2 ACs – Saves Money!.\n'
              '2.	Increases cooling efficiency & reduces electricity bills.\n'
              '3.	Service available for all top brands –LG, Voltas, Daikin, Blue Star, Samsung & more\n'
              '4.	Trained professionals for hassle-free service.\n'),
      ExpansionTileData(
        title: 'Ideal for',
        content: '1.	Homes & Flats\n'
            '2.	Offices & Shops.\n'
            '3.	Service Time: 1 to 1.5 hours per AC.\n',
      ),
    ];

    List<ExpansionTileData> GasRefill = <ExpansionTileData>[
      ExpansionTileData(
          title: 'Service Includes',
          content:
          '1.	Comprehensive inspection identify gas leaks using advanced leak detection methods\n'
              '2.	Repair of gas leaks in pipes, coils, or connections.\n'
              '3.	Vacuuming of the refrigerant system to remove moisture and contaminants\n'
              '4.	Refilling refrigerant gas(R22, R32, R410A, etc.) as per manufacturer specifications.\n'
              '5.	Pressure testing ensure the leak is fixed and the system is working efficiently\n'
              '6.	Post-repair testingto confirm optimal cooling performance.\n'),
      ExpansionTileData(
          title: 'Exclusion',
          content:
          'Part replacements like compressors or evaporator coils (available at additional cost)'),
      ExpansionTileData(
          title: 'Types of AC Units We Service',
          content: '1. Split AC Units.\n'
              '2.	Window AC Units.\n'
              '3.	Inverter AC Units.\n'),
      ExpansionTileData(
          title: 'Common Signs of a Gas Leak in AC',
          content: '1.AC Not Cooling Properly.\n'
              '2.Hissing Sound from AC.\n'
              '3.	Higher Energy Bills.\n'
              '4.	Frozen Evaporator Coils.\n'
              '5.	Water Leaking from AC.\n'),
    ];

    List<ExpansionTileData> installationData = [
      ExpansionTileData(
          title: 'Service Includes',
          content:
          '1.	Site inspection determine the best location for AC installation\n'
              '2.	Mounting and securing the indoor and outdoor units (for split ACs).\n'
              '3.	Proper alignment and leveling to ensure balanced airflow and reduced noise\n'
              '4.	Drilling and installation of the necessary pipes and cables for refrigerant and drainage.\n'
              '5.	Electrical wiring setup and safe connection to the power supply\n'
              '6.	Refrigerant pressure check to ensure proper cooling performance.\n'
              '7.	Initial testing the AC to verify cooling and overall functionality.\n'
              '8.	IBasic user guidance for operating the AC efficiently.\n'),
      ExpansionTileData(
          title: 'Exclusion',
          content:
          '1.Additional electrical wiring or plumbing work (available at an extra cost)'
              '2.Installation of stabilizers or voltage protectors (available upon request)\n'),
      ExpansionTileData(
          title: 'Types of AC Units We Install',
          content: '1. Split AC Units.\n'
              '2.	Window AC Units.\n'
              '3.	Inverter AC Units.\n'),
      ExpansionTileData(
          title: 'Common Signs You Need Professional AC Installation',
          content: '1.Improper Cooling or Airflow.\n'
              '2.Noise or Vibrations.\n'
              '3.	Water Leakage.\n'
              '4.	Increased Electricity Bills.\n'),
    ];

    List<ExpansionTileData> uninstallationData = [
      ExpansionTileData(
          title: 'Service Includes',
          content:
          '1.	Turning off the power supply safely disconnecting the AC unit\n'
              '2.	Disconnecting the refrigerant lines and ensuring proper refrigerant recovery.\n'
              '3.	Careful removal of the indoor unit(for split ACs)\n'
              '4.	Uninstalling the outdoor unit from its mounting brackets (for split ACs).\n'
              '5.	Sealing the wall openingsto prevent dust and dirt from entering\n'
              '6.	Safe disconnection of electrical wiring and drain pipes.\n'
              '7.	IPost-uninstallation inspection to ensure no damage or leaks.\n'),
      ExpansionTileData(
          title: 'Exclusions',
          content:
          '1.Reinstallation of the AC at a new location (available at additional cost)\n'),
      ExpansionTileData(
          title: 'Types of AC Units We Uninstall',
          content: '1. Split AC Units'
              '2. Window AC Units'
              '3. Inverter AC Units'),
      ExpansionTileData(
          title: 'Common Reasons for AC Uninstallation\n',
          content: '1. Relocation'
              '2. Upgrading to a New Model'
              '3. Seasonal Storage')
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
                  ? _buildMobileLayout(foamServiceData, GasRefill, installationData, uninstallationData)
                  : _buildDesktopTabletLayout(foamServiceData, GasRefill, installationData, uninstallationData, isTablet),
            ),
            Footer()
          ],
        ),
      ),
    );
  }

// In your _buildMobileLayout method, replace the PackageCard onAdd callbacks:

  Widget _buildMobileLayout(
      List<ExpansionTileData> foamServiceData,
      List<ExpansionTileData> GasRefill,
      List<ExpansionTileData> installationData,
      List<ExpansionTileData> uninstallationData,
      ) {
    return Column(
      children: [
        // Services Grid on top for mobile
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: ACServiceGrid(
            onServiceTap: (String serviceName) {
              _handleServiceTap(serviceName);
            },
          ),
        ),
        // Package cards below
        Column(
          children: [
            PackageCard(
              key: foamServiceKey,
              expansionData: foamServiceData,
              packageTitle: 'Foam-jet service (2 ACs)',
              packageDescription:
              'Get professional AC cleaning & maintenance for better cooling and energy savings!',
              packageHighlight: '',
              packagePrice: '₹1400',
              onAdd: () {
                // Fixed: Use Provider instead of creating new instance
                Provider.of<CartData>(context, listen: false)
                    .addPackage(context, 'Foam-jet service (2 ACs)', '1400');
              },
            ),
            SizedBox(height: 16),
            PackageCard(
              key: gasRefillKey,
              expansionData: GasRefill,
              packageTitle: 'AC Gas Leak Fix & Refill',
              packageDescription:
              'Our AC Gas Leak Fix & Refill Service that your air conditioning unit is free of refrigerant leaks and has the right amount of refrigerant for optimal cooling performance!',
              packageHighlight: '',
              packagePrice: '₹2899',
              onAdd: () {
                // Fixed: Use Provider instead of creating new instance
                Provider.of<CartData>(context, listen: false)
                    .addPackage(context, 'AC Gas Leak Fix & Refill', '2899');
              },
            ),
            SizedBox(height: 16),
            PackageCard(
              key: installationKey,
              packageTitle: 'AC Installation',
              packageDescription:
              'Installation of split or window AC units, secure mounting, electrical connection, drainage setup, and system testing for optimal performance',
              packageHighlight:
              'Our AC Installation Service professional and efficient setup of your air conditioning unit, ensuring optimal cooling performance and safe operation.',
              packagePrice: '₹1499',
              expansionData: installationData,
              onAdd: () {
                // Fixed: Use Provider instead of creating new instance
                Provider.of<CartData>(context, listen: false)
                    .addPackage(context, 'AC Installation', '1499');
              },
            ),
            SizedBox(height: 16),
            PackageCard(
              key: uninstallationKey,
              packageTitle: 'AC Uninstallation',
              packageDescription:
              'Safe disconnection of electrical and drainage systems, removal of units, sealing pipes, damage inspection, and preparation for transport or storage',
              packageHighlight:
              'Our AC Uninstallation Service safe and professional removal of your air conditioning unit',
              packagePrice: '₹1299',
              expansionData: uninstallationData,
              onAdd: () {
                // Fixed: Use Provider instead of creating new instance
                Provider.of<CartData>(context, listen: false)
                    .addPackage(context, 'AC Uninstallation', '1299');
              },
            ),
          ],
        ),
      ],
    );
  }

// Similarly fix _buildDesktopTabletLayout method:
  Widget _buildDesktopTabletLayout(
      List<ExpansionTileData> foamServiceData,
      List<ExpansionTileData> GasRefill,
      List<ExpansionTileData> installationData,
      List<ExpansionTileData> uninstallationData,
      bool isTablet,
      ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Services Grid - adjusted sizing for tablet
        Expanded(
          flex: isTablet ? 5 : 4,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: isTablet ? 500 : 380,
              minWidth: isTablet ? 380 : 320,
            ),
            child: ACServiceGrid(
              onServiceTap: (String serviceName) {
                _handleServiceTap(serviceName);
              },
            ),
          ),
        ),
        SizedBox(width: isTablet ? 20 : 24),
        // Package cards - adjusted flex
        Expanded(
          flex: isTablet ? 7 : 6,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              children: [
                PackageCard(
                  key: foamServiceKey,
                  expansionData: foamServiceData,
                  packageTitle: 'Foam-jet service (2 ACs)',
                  packageDescription:
                  'Get professional AC cleaning & maintenance for better cooling and energy savings!',
                  packageHighlight: '',
                  packagePrice: '₹1400',
                  onAdd: () {
                    // Fixed: Use Provider instead of creating new instance
                    Provider.of<CartData>(context, listen: false)
                        .addPackage(context, 'Foam-jet service (2 ACs)', '1400');
                  },
                ),
                SizedBox(height: 16),
                PackageCard(
                  key: gasRefillKey,
                  expansionData: GasRefill,
                  packageTitle: 'AC Gas Leak Fix & Refill',
                  packageDescription:
                  'Our AC Gas Leak Fix & Refill Service that your air conditioning unit is free of refrigerant leaks and has the right amount of refrigerant for optimal cooling performance!',
                  packageHighlight: '',
                  packagePrice: '₹2899',
                  onAdd: () {
                    // Fixed: Use Provider instead of creating new instance
                    Provider.of<CartData>(context, listen: false)
                        .addPackage(context, 'AC Gas Leak Fix & Refill', '2899');
                  },
                ),
                SizedBox(height: 16),
                PackageCard(
                  key: installationKey,
                  packageTitle: 'AC Installation',
                  packageDescription:
                  'Installation of split or window AC units, secure mounting, electrical connection, drainage setup, and system testing for optimal performance',
                  packageHighlight:
                  'Our AC Installation Service professional and efficient setup of your air conditioning unit, ensuring optimal cooling performance and safe operation.',
                  packagePrice: '₹1499',
                  expansionData: installationData,
                  onAdd: () {
                    // Fixed: Use Provider instead of creating new instance
                    Provider.of<CartData>(context, listen: false)
                        .addPackage(context, 'AC Installation', '1499');
                  },
                ),
                SizedBox(height: 16),
                PackageCard(
                  key: uninstallationKey,
                  packageTitle: 'AC Uninstallation',
                  packageDescription:
                  'Safe disconnection of electrical and drainage systems, removal of units, sealing pipes, damage inspection, and preparation for transport or storage',
                  packageHighlight:
                  'Our AC Uninstallation Service safe and professional removal of your air conditioning unit',
                  packagePrice: '₹1299',
                  expansionData: uninstallationData,
                  onAdd: () {
                    // Fixed: Use Provider instead of creating new instance
                    Provider.of<CartData>(context, listen: false)
                        .addPackage(context, 'AC Uninstallation', '1299');
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
    if (serviceName.contains('Foam-jet')) {
      scrollToSection(foamServiceKey);
    } else if (serviceName.contains('Gas Refill')) {
      scrollToSection(gasRefillKey);
    } else if (serviceName.contains('Installation') && !serviceName.contains('Uninstallation')) {
      scrollToSection(installationKey);
    } else if (serviceName.contains('Uninstallation')) {
      scrollToSection(uninstallationKey);
    }
  }
}