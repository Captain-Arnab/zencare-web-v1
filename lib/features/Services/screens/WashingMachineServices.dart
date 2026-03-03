import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zencare/common/appbar.dart';
import 'package:zencare/common/footer.dart';
import 'package:zencare/features/Services/widgets/Packages.dart';
import 'package:zencare/features/Services/widgets/WashingMachineServicesGrid.dart';
import 'package:zencare/features/controller.dart';

class WashingMachineServices extends StatefulWidget {
  const WashingMachineServices({super.key});

  @override
  State<WashingMachineServices> createState() => _WashingMachineServicesState();
}

class _WashingMachineServicesState extends State<WashingMachineServices> {
  // Global keys for scrolling to sections
  final GlobalKey topLoadKey = GlobalKey();
  final GlobalKey frontLoadKey = GlobalKey();
  final GlobalKey semiAutomaticKey = GlobalKey();
  final GlobalKey installationKey = GlobalKey();
  final GlobalKey uninstallationKey = GlobalKey();

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
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final isDesktop = screenWidth >= 1024;
    final isMobile = screenWidth < 768;

    List<ExpansionTileData> topLoad = [
      ExpansionTileData(
          title: 'Common Top Load Fully Automatic Washing Machine Problems',
          content: '1. Washing Machine Not Spinning\n'
              '2. Water Not Draining\n'
              '3. Excessive Noise During Operation\n'
              '4. Machine Not Starting\n'
              '5. Water Leaking from the Machine\n'
              '6. Washing Machine Shaking or Vibrating Excessively'),
      ExpansionTileData(
          title: 'What\'s Included',
          content: '1. Initial Check-Up:\n'
              '   • Detailed inspection of the washing machine to diagnose issues.\n'
              '   • Provision of a repair quote based on the diagnosis.\n\n'
              '2. Sourcing Spare Parts (If Required):\n'
              '   • Assistance in procuring spare parts from local markets.\n\n'
              '3. Repair:\n'
              '   • Repair of the washing machine issue.\n\n'
              '4. Post-Inspection Cleaning:\n'
              '   • Cleaning of the area and surfaces post-inspection for a tidy space.'),
      ExpansionTileData(
          title: 'What\'s Not Included',
          content: '1. Replacement or installation of water taps.\n'
              '2. Repair of commercial washing machines.\n'
              '3. Any repairs not agreed upon during the inspection.'),
      ExpansionTileData(
          title: 'Please Note',
          content:
          '1. Repair quotes will only be provided after the inspection.\n'
              '2. Visitation charges will be adjusted in the final repair quote.\n'
              '3. Payment to be made for the final repair amount.'),
      ExpansionTileData(
          title: 'Expertise Across Brands',
          content:
          'Service for all major brands including IFB, Siemens, Bosch, LG, Samsung, Whirlpool, Godrej, Panasonic, and more.'),
      ExpansionTileData(
          title: 'Duration',
          content:
          'The inspection typically takes 30-60 minutes depending on the condition of the washing machine.')
    ];

    List<ExpansionTileData> frontLoad = [
      ExpansionTileData(
          title: 'Common Top Load Fully Automatic Washing Machine Problems',
          content: '1. Washing Machine Door Not Closing\n'
              '2. Water Not Heating\n'
              '3. Drum Not Rotating\n'
              '4. Excessive Noise During Operation\n'
              '5. Machine Not Draining Water\n'
              '6. Leakage from the Machine'),
      ExpansionTileData(
          title: 'What\'s Included',
          content: '1. Initial Check-Up:\n'
              '   • Detailed inspection of the washing machine to diagnose issues.\n'
              '   • Provision of a repair quote based on the diagnosis.\n\n'
              '2. Sourcing Spare Parts (If Required):\n'
              '   • Assistance in procuring spare parts from local markets.\n\n'
              '3. Repair:\n'
              '   • Repair of the washing machine issue.\n\n'
              '4. Post-Inspection Cleaning:\n'
              '   • Cleaning of the area and surfaces post-inspection for a tidy space.'),
      ExpansionTileData(
          title: 'What\'s Not Included',
          content: '1. Replacement or installation of water taps.\n'
              '2. Repairs for commercial washing machines.\n'
              '3. Any repairs not agreed upon during the inspection.'),
      ExpansionTileData(
          title: 'Please Note',
          content:
          '1. Repair quotes will only be provided after the inspection.\n'
              '2. Visitation charges will be adjusted in the final repair quote.\n'
              '3. Final payment will exclude the booking fee already paid.'),
      ExpansionTileData(
          title: 'Expertise Across Brands',
          content:
          'Service for all major brands including IFB, Siemens, Bosch, LG, Samsung, Whirlpool, Godrej, Panasonic, and more.'),
      ExpansionTileData(
          title: 'Duration',
          content:
          'The inspection typically takes 30-60 minutes depending on the condition of the washing machine.')
    ];

    List<ExpansionTileData> semiAutomatic = [
      ExpansionTileData(
          title: 'Common Top Load Fully Automatic Washing Machine Problems',
          content: '1. Washing Machine Not Spinning\n'
              '2. Water Not Draining\n'
              '3. Timer Not Functioning\n'
              '4. Excessive Noise During Operation\n'
              '5. Water Leakage from the Machine\n'
              '6. Machine Not Starting'),
      ExpansionTileData(
          title: 'What\'s Included',
          content: '1. Initial Check-Up:\n'
              '   • Detailed inspection of the washing machine to diagnose issues.\n'
              '   • Provision of a repair quote based on the diagnosis.\n\n'
              '2. Sourcing Spare Parts (If Required):\n'
              '   • Assistance in procuring spare parts from local markets.\n\n'
              '3. Repair:\n'
              '   • Repair of the washing machine issue.\n\n'
              '4. Post-Inspection Cleaning:\n'
              '   • Cleaning of the area and surfaces post-inspection for a tidy space.'),
      ExpansionTileData(
          title: 'What\'s Not Included',
          content: '1. Replacement or installation of water taps.\n'
              '2. Repairs for commercial washing machines.\n'
              '3. Any repairs not agreed upon during the inspection.'),
      ExpansionTileData(
          title: 'Please Note',
          content:
          '1. Repair quotes will only be provided after the inspection.\n'
              '2. Visitation charges will be adjusted in the final repair quote.\n'
              '3. Final payment will exclude the booking fee already paid.'),
      ExpansionTileData(
          title: 'Expertise Across Brands',
          content:
          'Service for all major brands including IFB, Siemens, Bosch, LG, Samsung, Whirlpool, Godrej, Panasonic, and more.'),
      ExpansionTileData(
          title: 'Duration',
          content:
          'The inspection typically takes 30-60 minutes depending on the condition of the washing machine.')
    ];

    List<ExpansionTileData> installation = [
      ExpansionTileData(
          title: 'What\'s Included',
          content:
          '1. Unboxing and inspection of the washing machine for any transport damages.\n'
              '2. Positioning and leveling of the washing machine at the designated spot.\n'
              '3. Connection of water inlet and drainage pipes.\n'
              '4. Electrical connection setup and safe plug-in to a power outlet.\n'
              '5. Calibration and testing to ensure the washing machine operates smoothly.\n'
              '6. Basic usage instructions to help you get started.'),
      ExpansionTileData(
          title: 'Exclusions',
          content:
          '1. Additional plumbing or electrical work, if required, is not included.\n'
              '2. Modifications to the location (like drilling for drain pipes) are not covered.'),
      ExpansionTileData(
          title: 'Types of Washing Machines We Install',
          content: '1. Top Load Fully Automatic Washing Machines\n'
              '2. Front Load Fully Automatic Washing Machines\n'
              '3. Semi-Automatic Washing Machines')
    ];

    List<ExpansionTileData> unInstallation = [
      ExpansionTileData(
          title: 'What\'s Included',
          content:
          '1. Turning off water and power supply to the washing machine.\n'
              '2. Disconnecting the water inlet and drainage pipes.\n'
              '3. Safe removal of electrical connections.\n'
              '4. Careful unmounting of the machine (if wall-mounted or positioned in tight spaces).\n'
              '5. Post-uninstallation inspection to ensure no damage or leaks remain.'),
      ExpansionTileData(
          title: 'Exclusions',
          content:
          '1. Reinstallation of the washing machine at a new location (available as an additional service).\n'
              '2. Disposing of the old washing machine (disposal services available at extra cost).'),
      ExpansionTileData(
          title: 'Types of Washing Machines We Install',
          content: '1. Top Load Fully Automatic Washing Machines\n'
              '2. Front Load Fully Automatic Washing Machines\n'
              '3. Semi-Automatic Washing Machines')
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
                context,
                topLoad,
                frontLoad,
                semiAutomatic,
                installation,
                unInstallation,
              )
                  : _buildDesktopTabletLayout(
                context,
                topLoad,
                frontLoad,
                semiAutomatic,
                installation,
                unInstallation,
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
      List<ExpansionTileData> topLoad,
      List<ExpansionTileData> frontLoad,
      List<ExpansionTileData> semiAutomatic,
      List<ExpansionTileData> installation,
      List<ExpansionTileData> unInstallation,
      ) {
    return Column(
      children: [
        // Services Grid on top for mobile
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: WashingMachineServicesGrid(
            onServiceTap: (String serviceName) {
              _handleServiceTap(serviceName);
            },
          ),
        ),
        // Package cards below
        Column(
          children: [
            PackageCard(
              key: topLoadKey,
              onAdd: () {
                final cartData = Provider.of<CartData>(context, listen: false);
                cartData.addPackage(context, 'Top Load Fully Automatic - Inspection', '449');
              },
              expansionData: topLoad,
              packageTitle: 'Top Load Fully Automatic - Inspection',
              packageDescription:
              'Inspection & diagnosis, repair quote, spare part sourcing help, post-inspection area cleaning.',
              packageHighlight:
              'Our Top Load Fully Automatic Washing Machine Repair Service provides expert solutions for all types of issues specific to top load fully automatic washing machines.',
              packagePrice: '₹449/-',
            ),
            SizedBox(height: 16),
            PackageCard(
              key: frontLoadKey,
              onAdd: () {
                final cartData = Provider.of<CartData>(context, listen: false);
                cartData.addPackage(context, 'Front Load Fully Automatic - Inspection', '449');
              },
              expansionData: frontLoad,
              packageTitle: 'Front Load Fully Automatic - Inspection',
              packageDescription:
              'Inspection & diagnosis, repair quote, spare part sourcing help, post-inspection area cleaning.',
              packageHighlight:
              'Our Front Load Fully Automatic Washing Machine Repair Service provides expert solutions for all types of issues specific to front load fully automatic washing machines.',
              packagePrice: '₹449/-',
            ),
            SizedBox(height: 16),
            PackageCard(
              key: semiAutomaticKey,
              onAdd: () {
                final cartData = Provider.of<CartData>(context, listen: false);
                cartData.addPackage(context, 'Semi-Automatic - Inspection', '449');
              },
              expansionData: semiAutomatic,
              packageTitle: 'Semi-Automatic - Inspection',
              packageDescription:
              'Inspection & diagnosis, repair quote, spare part sourcing help, post-inspection area cleaning.',
              packageHighlight:
              'Our Semi-Automatic Washing Machine Repairs - Inspection Service provides expert solutions for all types of issues specific to semi-automatic washing machines.',
              packagePrice: '₹449/-',
            ),
            SizedBox(height: 16),
            PackageCard(
              key: installationKey,
              onAdd: () {
                final cartData = Provider.of<CartData>(context, listen: false);
                cartData.addPackage(context, 'Washing Machine Installation', '499');
              },
              expansionData: installation,
              packageTitle: 'Washing Machine Installation',
              packageDescription:
              'Unpacking, placement, connections, leveling, test cycle, and demo. All models installed with care.',
              packageHighlight:
              'Our Washing Machine Installation Service ensures that your new washing machine is installed correctly and efficiently. Whether it\'s a top load, front load, or semi-automatic washing machine, our skilled technicians provide hassle-free installation, ensuring the machine operates safely and effectively from day one.',
              packagePrice: '₹499/-',
            ),
            SizedBox(height: 16),
            PackageCard(
              key: uninstallationKey,
              onAdd: () {
                final cartData = Provider.of<CartData>(context, listen: false);
                cartData.addPackage(context, 'Washing Machine Uninstallation', '499');
              },
              expansionData: unInstallation,
              packageTitle: 'Washing Machine Uninstallation',
              packageDescription:
              'Our washing machine uninstallation service includes disconnecting, removing, disposing, and cleaning up the area.',
              packageHighlight:
              'Our Washing Machine Uninstallation Service ensures a safe and hassle-free removal of your washing machine. Whether you\'re moving to a new home or replacing an old machine, our expert technicians will uninstall the washing machine without causing damage to your plumbing, electrical connections, or surrounding space.',
              packagePrice: '₹499/-',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopTabletLayout(
      BuildContext context,
      List<ExpansionTileData> topLoad,
      List<ExpansionTileData> frontLoad,
      List<ExpansionTileData> semiAutomatic,
      List<ExpansionTileData> installation,
      List<ExpansionTileData> unInstallation,
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
            child: WashingMachineServicesGrid(
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
                  key: topLoadKey,
                  onAdd: () {
                    final cartData = Provider.of<CartData>(context, listen: false);
                    cartData.addPackage(context, 'Top Load Fully Automatic - Inspection', '449');
                  },
                  expansionData: topLoad,
                  packageTitle: 'Top Load Fully Automatic - Inspection',
                  packageDescription:
                  'Inspection & diagnosis, repair quote, spare part sourcing help, post-inspection area cleaning.',
                  packageHighlight:
                  'Our Top Load Fully Automatic Washing Machine Repair Service provides expert solutions for all types of issues specific to top load fully automatic washing machines.',
                  packagePrice: '₹449/-',
                ),
                SizedBox(height: 16),
                PackageCard(
                  key: frontLoadKey,
                  onAdd: () {
                    final cartData = Provider.of<CartData>(context, listen: false);
                    cartData.addPackage(context, 'Front Load Fully Automatic - Inspection', '449');
                  },
                  expansionData: frontLoad,
                  packageTitle: 'Front Load Fully Automatic - Inspection',
                  packageDescription:
                  'Inspection & diagnosis, repair quote, spare part sourcing help, post-inspection area cleaning.',
                  packageHighlight:
                  'Our Front Load Fully Automatic Washing Machine Repair Service provides expert solutions for all types of issues specific to front load fully automatic washing machines.',
                  packagePrice: '₹449/-',
                ),
                SizedBox(height: 16),
                PackageCard(
                  key: semiAutomaticKey,
                  onAdd: () {
                    final cartData = Provider.of<CartData>(context, listen: false);
                    cartData.addPackage(context, 'Semi-Automatic - Inspection', '449');
                  },
                  expansionData: semiAutomatic,
                  packageTitle: 'Semi-Automatic - Inspection',
                  packageDescription:
                  'Inspection & diagnosis, repair quote, spare part sourcing help, post-inspection area cleaning.',
                  packageHighlight:
                  'Our Semi-Automatic Washing Machine Repairs - Inspection Service provides expert solutions for all types of issues specific to semi-automatic washing machines.',
                  packagePrice: '₹449/-',
                ),
                SizedBox(height: 16),
                PackageCard(
                  key: installationKey,
                  onAdd: () {
                    final cartData = Provider.of<CartData>(context, listen: false);
                    cartData.addPackage(context, 'Washing Machine Installation', '499');
                  },
                  expansionData: installation,
                  packageTitle: 'Washing Machine Installation',
                  packageDescription:
                  'Unpacking, placement, connections, leveling, test cycle, and demo. All models installed with care.',
                  packageHighlight:
                  'Our Washing Machine Installation Service ensures that your new washing machine is installed correctly and efficiently. Whether it\'s a top load, front load, or semi-automatic washing machine, our skilled technicians provide hassle-free installation, ensuring the machine operates safely and effectively from day one.',
                  packagePrice: '₹499/-',
                ),
                SizedBox(height: 16),
                PackageCard(
                  key: uninstallationKey,
                  onAdd: () {
                    final cartData = Provider.of<CartData>(context, listen: false);
                    cartData.addPackage(context, 'Washing Machine Uninstallation', '499');
                  },
                  expansionData: unInstallation,
                  packageTitle: 'Washing Machine Uninstallation',
                  packageDescription:
                  'Our washing machine uninstallation service includes disconnecting, removing, disposing, and cleaning up the area.',
                  packageHighlight:
                  'Our Washing Machine Uninstallation Service ensures a safe and hassle-free removal of your washing machine. Whether you\'re moving to a new home or replacing an old machine, our expert technicians will uninstall the washing machine without causing damage to your plumbing, electrical connections, or surrounding space.',
                  packagePrice: '₹499/-',
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
    if (serviceName.contains('Top Load Fully Automatic')) {
      scrollToSection(topLoadKey);
    } else if (serviceName.contains('Front Load Fully Automatic')) {
      scrollToSection(frontLoadKey);
    } else if (serviceName.contains('Semi-Automatic')) {
      scrollToSection(semiAutomaticKey);
    } else if (serviceName.contains('Installation') && !serviceName.contains('Uninstallation')) {
      scrollToSection(installationKey);
    } else if (serviceName.contains('Uninstallation')) {
      scrollToSection(uninstallationKey);
    }
  }
}