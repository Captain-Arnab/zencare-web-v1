import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zencare/common/footer.dart';
import 'package:zencare/common/zen_care_scaffold.dart';
import 'package:zencare/features/Services/widgets/Packages.dart';
import 'package:zencare/features/Services/widgets/RefrigeratorServicesGrid.dart';
import 'package:zencare/features/controller.dart';
import 'package:zencare/features/controller.dart';

class RefrigeratorServices extends StatefulWidget {
  const RefrigeratorServices({super.key});

  @override
  State<RefrigeratorServices> createState() => _RefrigeratorServicesState();
}

class _RefrigeratorServicesState extends State<RefrigeratorServices> {
  // Global keys for scrolling to sections
  final GlobalKey notCoolingKey = GlobalKey();
  final GlobalKey waterLeakageKey = GlobalKey();
  final GlobalKey iceMakerKey = GlobalKey();
  final GlobalKey defrostingKey = GlobalKey();
  final GlobalKey gasRefillingKey = GlobalKey();
  final GlobalKey singleDoorKey = GlobalKey();
  final GlobalKey doubleDoorInverterKey = GlobalKey();
  final GlobalKey doubleDoorNonInverterKey = GlobalKey();
  final GlobalKey sideBySideKey = GlobalKey();

  // Method to scroll to a specific section
  void scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
        alignment: 0.1,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isAndroid = defaultTargetPlatform == TargetPlatform.android;
    final isMobile = isAndroid || screenWidth < 768;
    final isTablet = !isAndroid && screenWidth >= 768 && screenWidth < 1024;
    final isDesktop = !isAndroid && screenWidth >= 1024;

    List<ExpansionTileData> notCoolingData = [
      ExpansionTileData(
          title: 'Common Problems',
          content: '1. Compressor failure leading to poor cooling.\n'
              '2. Blocked or malfunctioning vents affecting airflow.\n'
              '3. Faulty thermostat or temperature control.'),
      ExpansionTileData(
          title: 'What\'s Included',
          content:
          '1. Check-up & Quote: The technician inspects your refrigerator and provides a diagnosis with a repair quote.\n'
              '2. Sourcing Spare Parts (if required): If necessary, genuine spare parts will be sourced from the local market.\n'
              '3. Repair: The technician performs the necessary repairs to restore functionality.'),
      ExpansionTileData(
        title: 'Not Included',
        content:
        '1. Spare parts cost (if required for repair) is not included in the service package.\n'
            '2. Repair services for commercial refrigerators.',
      ),
      ExpansionTileData(
          title: 'Please Note',
          content:
          '1. Quote Provided After Diagnosis: Repair costs will be shared after the check-up.\n'
              '2. No Commercial Appliances: We do not service commercial refrigerators.'),
      ExpansionTileData(
        title: 'Duration',
        content:
        'The repair duration will depend on the complexity of the issue and the availability of spare parts. Generally completed within 1-2 hours after diagnosis.\n',
      ),
    ];

    List<ExpansionTileData> waterLeakageData = [
      ExpansionTileData(
          title: 'Common Problems',
          content:
          '1. Clogged or frozen defrost drain leading to water overflow.\n'
              '2. Damaged or misaligned water inlet valve causing leakage.\n'
              '3. Cracked or faulty water supply line.\n'
              '4. Blocked drainage system causing internal leaks.'),
      ExpansionTileData(
          title: 'What\'s Included',
          content: '1. Check-up & Quote:\n'
              '   The technician inspects your refrigerator to identify the cause of the water leakage and provides a repair quote.\n\n'
              '2. Sourcing Spare Parts (if required):\n'
              '   If necessary, genuine spare parts will be sourced from the local market.\n\n'
              '3. Repair:\n'
              '   The technician resolves the water leakage issue by repairing or replacing faulty components.'),
      ExpansionTileData(
        title: 'Not Included',
        content:
        '1. Spare parts cost (if required for repair) is not included in the service package.\n'
            '2. Repair services for commercial refrigerators.',
      ),
      ExpansionTileData(
          title: 'Please Note',
          content:
          '1. Quote Provided After Diagnosis: Repair costs will be shared after the check-up.\n'
              '2. No Commercial Appliances: We do not service commercial refrigerators.'),
      ExpansionTileData(
        title: 'Duration',
        content:
        'The repair duration will depend on the complexity of the issue and the availability of spare parts. Generally completed within 1-2 hours after diagnosis\n',
      ),
    ];

    List<ExpansionTileData> iceRepairData = [
      ExpansionTileData(
          title: 'Common Problems',
          content:
          '1. Clogged or frozen water supply line disrupting ice production.\n'
              '2. Faulty ice maker motor or thermostat causing malfunctions.\n'
              '3. Broken or misaligned ice mold or ejector arm affecting ice release.'),
      ExpansionTileData(
          title: 'What\'s Included',
          content: '1. Check-up & Quote:\n'
              '   The technician inspects your refrigerator\'s ice maker to diagnose the issue and provides a repair quote.\n\n'
              '2. Sourcing Spare Parts (if required):\n'
              '   If necessary, genuine spare parts like water supply lines, motors, or ice molds will be sourced from the local market.\n\n'
              '3. Repair:\n'
              '   The technician repairs or replaces the faulty components to restore proper ice-making functionality.'),
      ExpansionTileData(
        title: 'Not Included',
        content:
        '1. Spare parts cost (if required for repair) is not included in the service package.\n'
            '2. Repair services for commercial refrigerators.',
      ),
      ExpansionTileData(
          title: 'Please Note',
          content:
          '1. Quote Provided After Diagnosis: Repair costs will be shared after the check-up.\n'
              '2. No Commercial Appliances: We do not service commercial refrigerators.'),
      ExpansionTileData(
        title: 'Duration',
        content:
        'The repair duration will depend on the complexity of the issue and the availability of spare parts. Generally completed within 1-2 hours after diagnosis.',
      ),
    ];

    List<ExpansionTileData> defrostingData = [
      ExpansionTileData(
          title: 'Common Problems',
          content:
          '1. Faulty defrost timer or heater causing ice accumulation.\n'
              '2. Broken defrost thermostat disrupting the defrost cycle.\n'
              '3. Clogged or frozen defrost drain leading to water leakage and ice buildup.'),
      ExpansionTileData(
          title: 'What\'s Included',
          content: '1. Check-up & Quote:\n'
              '   The technician inspects your refrigerator\'s defrost system to identify the issue and provides a repair quote.\n\n'
              '2. Sourcing Spare Parts (if required):\n'
              '   If necessary, genuine spare parts like defrost timers, heaters, or thermostats will be sourced from the local market.\n\n'
              '3. Repair:\n'
              '   The technician repairs or replaces faulty components to restore the defrosting functionality.'),
      ExpansionTileData(
        title: 'Not Included',
        content:
        '1. Spare parts cost (if required for repair) is not included in the service package.\n'
            '2. Repair services for commercial refrigerators.',
      ),
      ExpansionTileData(
          title: 'Please Note',
          content:
          '1. Quote Provided After Diagnosis: Repair costs will be shared after the check-up.\n'
              '2. No Commercial Appliances: We do not service commercial refrigerators.'),
      ExpansionTileData(
        title: 'Duration',
        content:
        'The repair duration will depend on the complexity of the issue and the availability of spare parts. Generally completed within 1-2 hours after diagnosis.',
      ),
    ];

    List<ExpansionTileData> gasRefillingData = [
      ExpansionTileData(
          title: 'Common Problems',
          content:
          '1. Low refrigerant levels causing insufficient cooling.\n'
              '2. Refrigerant leakage leading to poor performance.\n'
              '3. Faulty valves or connections resulting in gas loss.'),
      ExpansionTileData(
          title: 'What\'s Included',
          content:
          '1. Check-up: The technician inspects the refrigerator for refrigerant gas levels and identifies any leaks or related issues.\n'
              '2. Gas Refilling: The refrigerant gas is refilled to the required levels to restore optimal cooling performance.\n'
              '3. Leak Testing: After refilling, the technician checks for any leaks in the system to ensure long-term effectiveness.'),
      ExpansionTileData(
        title: 'Not Included',
        content:
        '1. Additional costs for repairing leaks or replacing faulty components are not included.\n'
            '2. Services for commercial refrigerators.',
      ),
      ExpansionTileData(
          title: 'Please Note',
          content:
          '1. Quote Provided After Diagnosis: Gas refilling costs will be shared after the check-up.\n'
              '2. No Commercial Appliances: We do not service commercial refrigerators.'),
      ExpansionTileData(
        title: 'Duration',
        content: 'The gas refilling process is generally completed within 1-2 hours after diagnosis.',
      ),
    ];

    List<ExpansionTileData> singleDoorData = [
      ExpansionTileData(
          title: 'Common Problems',
          content:
          '1. Compressor issues leading to insufficient cooling.\n'
              '2. Faulty thermostat or temperature control causing irregular cooling.\n'
              '3. Damaged or worn-out door gasket affecting sealing and cooling efficiency.\n'
              '4. Clogged defrost drain causing water leakage.\n'
              '5. Electrical or wiring faults disrupting refrigerator performance.'),
      ExpansionTileData(
          title: 'What\'s Included',
          content:
          '1. Check-up: The technician inspects your single-door refrigerator to identify the issue and provides a diagnosis with a repair quote.\n'
              '2. Sourcing Spare Parts (if required): If necessary, genuine spare parts will be sourced from the local market.\n'
              '3. Repair: The technician performs the necessary repairs to restore your refrigerator\'s functionality.'),
      ExpansionTileData(
        title: 'Not Included',
        content:
        '1. Spare parts cost (if required for repair) is not included in the service package.\n'
            '2. Repair services for commercial refrigerators.',
      ),
      ExpansionTileData(
          title: 'Please Note',
          content:
          '1. Quote Provided After Diagnosis: Repair costs will be shared after the check-up.\n'
              '2. No Commercial Appliances: We do not service commercial refrigerators.'),
      ExpansionTileData(
        title: 'Duration',
        content:
        'The repair duration will depend on the complexity of the issue and the availability of spare parts. Generally completed within 1-2 hours after diagnosis.',
      ),
    ];

    List<ExpansionTileData> doubleDoorInverterData = [
      ExpansionTileData(
          title: 'Common Problems',
          content:
          '1. Compressor failure or inverter board malfunction affecting cooling efficiency.\n'
              '2. Faulty temperature sensors leading to uneven cooling.\n'
              '3. Damaged or worn-out door gasket causing air leakage.\n'
              '4. Defrost system issues causing frost buildup.\n'
              '5. Electrical or wiring faults disrupting refrigerator performance.'),
      ExpansionTileData(
          title: 'What\'s Included',
          content:
          '1. Check-up: The technician inspects your inverter double-door refrigerator to identify the issue and provides a diagnosis with a repair quote.\n'
              '2. Sourcing Spare Parts (if required): If necessary, genuine spare parts like sensors, gaskets, or inverter boards will be sourced from the local market.\n'
              '3. Repair: The technician performs the necessary repairs to restore your refrigerator\'s functionality.'),
      ExpansionTileData(
        title: 'Not Included',
        content:
        '1. Spare parts cost (if required for repair) is not included in the service package.\n'
            '2. Repair services for commercial refrigerators.',
      ),
      ExpansionTileData(
          title: 'Please Note',
          content:
          '1. Quote Provided After Diagnosis: Repair costs will be shared after the check-up.\n'
              '2. No Commercial Appliances: We do not service commercial refrigerators.'),
      ExpansionTileData(
        title: 'Duration',
        content:
        'The repair duration will depend on the complexity of the issue and the availability of spare parts. Generally completed within 1-2 hours after diagnosis.',
      ),
    ];

    List<ExpansionTileData> doubleDoorNonInverterData = [
      ExpansionTileData(
          title: 'Common Problems',
          content:
          '1. Compressor issues leading to poor cooling performance.\n'
              '2. Faulty thermostat or temperature sensors causing uneven cooling.\n'
              '3. Worn-out or damaged door gasket affecting proper sealing.\n'
              '4. Clogged defrost drain resulting in water leakage.\n'
              '5. Electrical or wiring faults disrupting refrigerator operation.'),
      ExpansionTileData(
          title: 'What\'s Included',
          content:
          '1. Check-up: The technician inspects your non-inverter double-door refrigerator to identify the issue and provides a diagnosis with a repair quote.\n'
              '2. Sourcing Spare Parts (if required): If necessary, genuine spare parts like compressors, gaskets, or sensors will be sourced from the local market.\n'
              '3. Repair: The technician performs the necessary repairs to restore your refrigerator\'s functionality.'),
      ExpansionTileData(
        title: 'Not Included',
        content:
        '1. Spare parts cost (if required for repair) is not included in the service package.\n'
            '2. Repair services for commercial refrigerators.',
      ),
      ExpansionTileData(
          title: 'Please Note',
          content:
          '1. Quote Provided After Diagnosis: Repair costs will be shared after the check-up.\n'
              '2. No Commercial Appliances: We do not service commercial refrigerators.'),
      ExpansionTileData(
        title: 'Duration',
        content:
        'The repair duration will depend on the complexity of the issue and the availability of spare parts. Generally completed within 1-2 hours after diagnosis.',
      ),
    ];

    List<ExpansionTileData> sideBySideData = [
      ExpansionTileData(
          title: 'Common Problems',
          content:
          '1. Faulty compressor or cooling system affecting performance.\n'
              '2. Malfunctioning temperature sensors leading to uneven cooling.\n'
              '3. Defrost system issues causing frost buildup.\n'
              '4. Damaged door gaskets or seals resulting in air leakage.\n'
              '5. Electrical or wiring faults disrupting the refrigerator\'s operation.'),
      ExpansionTileData(
          title: 'What\'s Included',
          content:
          '1. Check-up: The technician inspects your side-by-side refrigerator to identify the issue and provides a diagnosis with a repair quote.\n'
              '2. Sourcing Spare Parts (if required): If necessary, genuine spare parts like compressors, sensors, or gaskets will be sourced from the local market.\n'
              '3. Repair: The technician performs the necessary repairs to restore your refrigerator\'s functionality.'),
      ExpansionTileData(
        title: 'Not Included',
        content:
        '1. Spare parts cost (if required for repair) is not included in the service package.\n'
            '2. Repair services for commercial refrigerators.',
      ),
      ExpansionTileData(
          title: 'Please Note',
          content:
          '1. Quote Provided After Diagnosis: Repair costs will be shared after the check-up.\n'
              '2. No Commercial Appliances: We do not service commercial refrigerators.'),
      ExpansionTileData(
        title: 'Duration',
        content:
        'The repair duration will depend on the complexity of the issue and the availability of spare parts. Generally completed within 2-3 hours after diagnosis.',
      ),
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
                  ? _buildMobileLayout(context, notCoolingData, waterLeakageData, iceRepairData, defrostingData, gasRefillingData, singleDoorData, doubleDoorInverterData, doubleDoorNonInverterData, sideBySideData)
                  : _buildDesktopTabletLayout(context, notCoolingData, waterLeakageData, iceRepairData, defrostingData, gasRefillingData, singleDoorData, doubleDoorInverterData, doubleDoorNonInverterData, sideBySideData, isTablet),
            ),
            Footer()
          ],
        ),
      ),
    );
  }

  Widget _buildMobileLayout(
      BuildContext context,
      List<ExpansionTileData> notCoolingData,
      List<ExpansionTileData> waterLeakageData,
      List<ExpansionTileData> iceRepairData,
      List<ExpansionTileData> defrostingData,
      List<ExpansionTileData> gasRefillingData,
      List<ExpansionTileData> singleDoorData,
      List<ExpansionTileData> doubleDoorInverterData,
      List<ExpansionTileData> doubleDoorNonInverterData,
      List<ExpansionTileData> sideBySideData,
      ) {
    return Column(
      children: [
        // Services Grid on top for mobile
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: RefrigeratorServicesGrid(
            onServiceTap: (String serviceName) {
              _handleServiceTap(serviceName);
            },
          ),
        ),
        // Package cards below
        Column(
          children: [
            PackageCard(
              key: notCoolingKey,
              onAdd: () {
                final cartData = Provider.of<CartData>(context, listen: false);
                cartData.addPackage(context, 'Refrigerator Not Cooling – Inspection', '349');
              },
              expansionData: notCoolingData,
              packageTitle: 'Refrigerator Not Cooling – Inspection',
              packageDescription:
              'Expert diagnosis, sourcing genuine parts, efficient repairs, and thorough clean-up post-repair for your fridge',
              packageHighlight:
              'The Refrigerator Not Cooling Repair service diagnoses and addresses issues causing insufficient cooling in your refrigerator.',
              packagePrice: '₹349/-',
            ),
            SizedBox(height: 16),
            PackageCard(
              key: waterLeakageKey,
              onAdd: () {
                final cartData = Provider.of<CartData>(context, listen: false);
                cartData.addPackage(context, 'Refrigerator Water Leakage', '399');
              },
              expansionData: waterLeakageData,
              packageTitle: 'Refrigerator Water Leakage',
              packageDescription:
              'Diagnose and clear blocked drains, inspect/replace seals, and test for leak-free operation',
              packageHighlight:
              'The Refrigerator Water Leakage Repair service identifies and resolves issues causing water leakage in your refrigerator to prevent further damage and ensure smooth functionality.',
              packagePrice: '₹399/-',
            ),
            SizedBox(height: 16),
            PackageCard(
              key: iceMakerKey,
              onAdd: () {
                final cartData = Provider.of<CartData>(context, listen: false);
                cartData.addPackage(context, 'Refrigerator Ice Maker Repair', '999');
              },
              expansionData: iceRepairData,
              packageTitle: 'Refrigerator Ice Maker Repair',
              packageDescription:
              'Ice maker check, diagnosis, parts sourcing (if needed), and repair to restore proper ice-making functionality\n',
              packageHighlight:
              'The Refrigerator Ice Maker Repair service identifies and resolves issues affecting your refrigerators ice maker, ensuring it functions efficiently to provide a steady supply of ice.\n',
              packagePrice: '₹999/-',
            ),
            SizedBox(height: 16),
            PackageCard(
              key: defrostingKey,
              onAdd: () {
                final cartData = Provider.of<CartData>(context, listen: false);
                cartData.addPackage(context, 'Refrigerator Defrosting Issues', '999');
              },
              expansionData: defrostingData,
              packageTitle: 'Refrigerator Defrosting Issues',
              packageDescription:
              'Defrost system check, diagnosis, parts sourcing (if needed), and repair to restore proper defrost functionality\n',
              packageHighlight:
              'The Refrigerator Defrosting Issues Repair service diagnoses and resolves problems with your refrigerators defrosting system, ensuring proper cooling and preventing ice buildup.\n',
              packagePrice: '₹999/-',
            ),
            SizedBox(height: 16),
            PackageCard(
              key: gasRefillingKey,
              onAdd: () {
                final cartData = Provider.of<CartData>(context, listen: false);
                cartData.addPackage(context, 'Refrigerator Gas Refilling', '1499');
              },
              expansionData: gasRefillingData,
              packageTitle: 'Refrigerator Gas Refilling',
              packageDescription:
              'Gas level check, leak inspection, refrigerant refill, and post-refill testing to ensure optimal cooling performance',
              packageHighlight:
              'The Refrigerator Gas Refilling service restores the cooling efficiency of your refrigerator by refilling its refrigerant gas to the required levels.',
              packagePrice: '₹1499/-',
            ),
            SizedBox(height: 16),
            PackageCard(
              key: singleDoorKey,
              onAdd: () {
                final cartData = Provider.of<CartData>(context, listen: false);
                cartData.addPackage(context, 'Single Door Refrigerator', '599');
              },
              expansionData: singleDoorData,
              packageTitle: 'Single Door Refrigerator',
              packageDescription:
              'Inspection, diagnosis, spare part sourcing (if needed), and repair to restore your single-door refrigerator',
              packageHighlight:
              'The Single Door Refrigerator Repair service diagnoses and resolves a range of issues to ensure your single-door refrigerator functions efficiently and effectively.',
              packagePrice: '₹599/-',
            ),
            SizedBox(height: 16),
            PackageCard(
              key: doubleDoorInverterKey,
              onAdd: () {
                final cartData = Provider.of<CartData>(context, listen: false);
                cartData.addPackage(context, 'Double Door Refrigerator (Inverter)', '799');
              },
              expansionData: doubleDoorInverterData,
              packageTitle: 'Double Door Refrigerator (Inverter)',
              packageDescription:
              'Inspection, diagnosis, spare part sourcing (sensors, gaskets, inverter boards), and repair for your fridge',
              packageHighlight:
              'The Double Door Refrigerator Repair (Inverter) service diagnoses and resolves a range of issues to ensure your inverter double-door refrigerator operates smoothly and efficiently.',
              packagePrice: '₹799/-',
            ),
            SizedBox(height: 16),
            PackageCard(
              key: doubleDoorNonInverterKey,
              onAdd: () {
                final cartData = Provider.of<CartData>(context, listen: false);
                cartData.addPackage(context, 'Double Door Refrigerator (Non-Inverter)', '799');
              },
              expansionData: doubleDoorNonInverterData,
              packageTitle: 'Double Door Refrigerator (Non-Inverter)',
              packageDescription:
              'Inspection, diagnosis, spare part sourcing (compressors, gaskets, sensors), and repair for your fridge',
              packageHighlight:
              'The Double Door Refrigerator Repair (Non-Inverter) service diagnoses and addresses a range of issues to ensure your non-inverter double-door refrigerator functions efficiently.',
              packagePrice: '₹799/-',
            ),
            SizedBox(height: 16),
            PackageCard(
              key: sideBySideKey,
              onAdd: () {
                final cartData = Provider.of<CartData>(context, listen: false);
                cartData.addPackage(context, 'Side by Side Door Refrigerator', '999');
              },
              expansionData: sideBySideData,
              packageTitle: 'Side by Side Door Refrigerator',
              packageDescription:
              'Inspection, diagnosis, spare part sourcing (compressors, sensors, gaskets), and repair for side-by-side fridge',
              packageHighlight:
              'The Side-by-Side Door Refrigerator Repair service diagnoses and resolves issues to ensure your side-by-side refrigerator operates efficiently and reliably.',
              packagePrice: '₹999/-',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopTabletLayout(
      BuildContext context,
      List<ExpansionTileData> notCoolingData,
      List<ExpansionTileData> waterLeakageData,
      List<ExpansionTileData> iceRepairData,
      List<ExpansionTileData> defrostingData,
      List<ExpansionTileData> gasRefillingData,
      List<ExpansionTileData> singleDoorData,
      List<ExpansionTileData> doubleDoorInverterData,
      List<ExpansionTileData> doubleDoorNonInverterData,
      List<ExpansionTileData> sideBySideData,
      bool isTablet,
      ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Services Grid - flexible sizing based on screen
        Expanded(
          flex: isTablet ? 5 : 4,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: isTablet ? 500 : 380,
              minWidth: isTablet ? 380 : 320,
            ),
            child: RefrigeratorServicesGrid(
              onServiceTap: (String serviceName) {
                _handleServiceTap(serviceName);
              },
            ),
          ),
        ),
        SizedBox(width: isTablet ? 20 : 24),
        // Package cards - takes more space
        Expanded(
          flex: isTablet ? 7 : 6,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              children: [
                PackageCard(
                  key: notCoolingKey,
                  onAdd: () {
                    final cartData = Provider.of<CartData>(context, listen: false);
                    cartData.addPackage(context, 'Refrigerator Not Cooling – Inspection', '349');
                  },
                  expansionData: notCoolingData,
                  packageTitle: 'Refrigerator Not Cooling – Inspection',
                  packageDescription:
                  'Expert diagnosis, sourcing genuine parts, efficient repairs, and thorough clean-up post-repair for your fridge',
                  packageHighlight:
                  'The Refrigerator Not Cooling Repair service diagnoses and addresses issues causing insufficient cooling in your refrigerator.',
                  packagePrice: '₹349/-',
                ),
                SizedBox(height: 16),
                PackageCard(
                  key: waterLeakageKey,
                  onAdd: () {
                    final cartData = Provider.of<CartData>(context, listen: false);
                    cartData.addPackage(context, 'Refrigerator Water Leakage', '399');
                  },
                  expansionData: waterLeakageData,
                  packageTitle: 'Refrigerator Water Leakage',
                  packageDescription:
                  'Diagnose and clear blocked drains, inspect/replace seals, and test for leak-free operation',
                  packageHighlight:
                  'The Refrigerator Water Leakage Repair service identifies and resolves issues causing water leakage in your refrigerator to prevent further damage and ensure smooth functionality.',
                  packagePrice: '₹399/-',
                ),
                SizedBox(height: 16),
                PackageCard(
                  key: iceMakerKey,
                  onAdd: () {
                    final cartData = Provider.of<CartData>(context, listen: false);
                    cartData.addPackage(context, 'Refrigerator Ice Maker Repair', '999');
                  },
                  expansionData: iceRepairData,
                  packageTitle: 'Refrigerator Ice Maker Repair',
                  packageDescription:
                  'Ice maker check, diagnosis, parts sourcing (if needed), and repair to restore proper ice-making functionality\n',
                  packageHighlight:
                  'The Refrigerator Ice Maker Repair service identifies and resolves issues affecting your refrigerators ice maker, ensuring it functions efficiently to provide a steady supply of ice.\n',
                  packagePrice: '₹999/-',
                ),
                SizedBox(height: 16),
                PackageCard(
                  key: defrostingKey,
                  onAdd: () {
                    final cartData = Provider.of<CartData>(context, listen: false);
                    cartData.addPackage(context, 'Refrigerator Defrosting Issues', '999');
                  },
                  expansionData: defrostingData,
                  packageTitle: 'Refrigerator Defrosting Issues',
                  packageDescription:
                  'Defrost system check, diagnosis, parts sourcing (if needed), and repair to restore proper defrost functionality\n',
                  packageHighlight:
                  'The Refrigerator Defrosting Issues Repair service diagnoses and resolves problems with your refrigerators defrosting system, ensuring proper cooling and preventing ice buildup.\n',
                  packagePrice: '₹999/-',
                ),
                SizedBox(height: 16),
                PackageCard(
                  key: gasRefillingKey,
                  onAdd: () {
                    final cartData = Provider.of<CartData>(context, listen: false);
                    cartData.addPackage(context, 'Refrigerator Gas Refilling', '1499');
                  },
                  expansionData: gasRefillingData,
                  packageTitle: 'Refrigerator Gas Refilling',
                  packageDescription:
                  'Gas level check, leak inspection, refrigerant refill, and post-refill testing to ensure optimal cooling performance',
                  packageHighlight:
                  'The Refrigerator Gas Refilling service restores the cooling efficiency of your refrigerator by refilling its refrigerant gas to the required levels.',
                  packagePrice: '₹1499/-',
                ),
                SizedBox(height: 16),
                PackageCard(
                  key: singleDoorKey,
                  onAdd: () {
                    final cartData = Provider.of<CartData>(context, listen: false);
                    cartData.addPackage(context, 'Single Door Refrigerator', '599');
                  },
                  expansionData: singleDoorData,
                  packageTitle: 'Single Door Refrigerator',
                  packageDescription:
                  'Inspection, diagnosis, spare part sourcing (if needed), and repair to restore your single-door refrigerator',
                  packageHighlight:
                  'The Single Door Refrigerator Repair service diagnoses and resolves a range of issues to ensure your single-door refrigerator functions efficiently and effectively.',
                  packagePrice: '₹599/-',
                ),
                SizedBox(height: 16),
                PackageCard(
                  key: doubleDoorInverterKey,
                  onAdd: () {
                    final cartData = Provider.of<CartData>(context, listen: false);
                    cartData.addPackage(context, 'Double Door Refrigerator (Inverter)', '799');
                  },
                  expansionData: doubleDoorInverterData,
                  packageTitle: 'Double Door Refrigerator (Inverter)',
                  packageDescription:
                  'Inspection, diagnosis, spare part sourcing (sensors, gaskets, inverter boards), and repair for your fridge',
                  packageHighlight:
                  'The Double Door Refrigerator Repair (Inverter) service diagnoses and resolves a range of issues to ensure your inverter double-door refrigerator operates smoothly and efficiently.',
                  packagePrice: '₹799/-',
                ),
                SizedBox(height: 16),
                PackageCard(
                  key: doubleDoorNonInverterKey,
                  onAdd: () {
                    final cartData = Provider.of<CartData>(context, listen: false);
                    cartData.addPackage(context, 'Double Door Refrigerator (Non-Inverter)', '799');
                  },
                  expansionData: doubleDoorNonInverterData,
                  packageTitle: 'Double Door Refrigerator (Non-Inverter)',
                  packageDescription:
                  'Inspection, diagnosis, spare part sourcing (compressors, gaskets, sensors), and repair for your fridge',
                  packageHighlight:
                  'The Double Door Refrigerator Repair (Non-Inverter) service diagnoses and addresses a range of issues to ensure your non-inverter double-door refrigerator functions efficiently.',
                  packagePrice: '₹799/-',
                ),
                SizedBox(height: 16),
                PackageCard(
                  key: sideBySideKey,
                  onAdd: () {
                    final cartData = Provider.of<CartData>(context, listen: false);
                    cartData.addPackage(context, 'Side by Side Door Refrigerator', '999');
                  },
                  expansionData: sideBySideData,
                  packageTitle: 'Side by Side Door Refrigerator',
                  packageDescription:
                  'Inspection, diagnosis, spare part sourcing (compressors, sensors, gaskets), and repair for side-by-side fridge',
                  packageHighlight:
                  'The Side-by-Side Door Refrigerator Repair service diagnoses and resolves issues to ensure your side-by-side refrigerator operates efficiently and reliably.',
                  packagePrice: '₹999/-',
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
    if (serviceName.contains('Not Cooling')) {
      scrollToSection(notCoolingKey);
    } else if (serviceName.contains('Water Leakage')) {
      scrollToSection(waterLeakageKey);
    } else if (serviceName.contains('Ice Maker')) {
      scrollToSection(iceMakerKey);
    } else if (serviceName.contains('Defrosting')) {
      scrollToSection(defrostingKey);
    } else if (serviceName.contains('Gas Refilling')) {
      scrollToSection(gasRefillingKey);
    } else if (serviceName.contains('Single Door')) {
      scrollToSection(singleDoorKey);
    } else if (serviceName.contains('Double Door') && serviceName.contains('Inverter')) {
      scrollToSection(doubleDoorInverterKey);
    } else if (serviceName.contains('Non-Inverter')) {
      scrollToSection(doubleDoorNonInverterKey);
    } else if (serviceName.contains('Side by Side')) {
      scrollToSection(sideBySideKey);
    }
  }
}