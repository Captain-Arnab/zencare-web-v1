import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zencare/common/footer.dart';
import 'package:zencare/common/zen_care_scaffold.dart';
import 'package:zencare/features/Services/widgets/ChimneyRepairServicesGrid.dart';
import 'package:zencare/features/Services/widgets/Packages.dart';
import 'package:zencare/features/controller.dart';

class ChimneyRepairServices extends StatefulWidget {
  const ChimneyRepairServices({super.key});

  @override
  State<ChimneyRepairServices> createState() => _ChimneyRepairServicesState();
}

class _ChimneyRepairServicesState extends State<ChimneyRepairServices> {
  // Global keys for scrolling to sections
  final GlobalKey chimneyCleaningKey = GlobalKey();
  final GlobalKey chimneyCheckupFilterKey = GlobalKey();
  final GlobalKey chimneyCheckupAirflowKey = GlobalKey();
  final GlobalKey chimneyMotorRepairKey = GlobalKey();
  final GlobalKey chimneySuctionPowerKey = GlobalKey();
  final GlobalKey chimneyFanRepairKey = GlobalKey();
  final GlobalKey chimneyButtonRepairKey = GlobalKey();
  final GlobalKey chimneyDuctCheckupKey = GlobalKey();
  final GlobalKey chimneyInstallationKey = GlobalKey();
  final GlobalKey chimneyUninstallationKey = GlobalKey();

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

    List<ExpansionTileData> ChimneyCleaningService = [
      ExpansionTileData(
          title: 'Common Problems',
          content:
          '1.	Excessive grease buildup causing reduced suction power.\n'
              '2. Smoke and odor backflow into the kitchen due to clogged filters\n'
              '3.	Increased fire risk from accumulated residue.\n'
              '4.	Unpleasant odors emitted from the chimney due to residue buildup.\n'),
      ExpansionTileData(
          title: 'Service Included',
          content:
          '1. Thorough cleaning of chimney exterior and interior components \n'
              '2. Cleaning of filters, chimney duct, and airways for unobstructed airflow\n'
              '3. Removal of grease and soot buildup to restore optimal suction power\n'
              '4. Cleaning of chimney hood and blower (if applicable)\n'
              '5. Inspection for any potential issues that may affect performance\n'),
      ExpansionTileData(
          title: 'Excluded',
          content: '1. Filter replacement (covered under a separate service)\n'
              '2. Repair of malfunctioning parts (covered under a repair package)\n'
              '3. Electrical work or motor repairs\n'
              '4. Replacement of any damaged components')
    ];

    List<ExpansionTileData> completechimneycheck = [
      ExpansionTileData(
          title: 'What to Expect',
          content:
          ' 1. Inspection : Our technician will visit your home, check your chimney, and let you know what needs to be fixed along with the estimated cost.\n'
              '2. Getting Spare Parts (If Needed) :	If any spare parts are required, the technician will arrange them from the local market to ensure a smooth repair process\n'
              '3. Repair Work: Once everything is ready, the technician will carry out the necessary repairs to get your chimney working properly again\n'
              '4. Cleaning Up : •	After the repair is done, we make sure to clean up the area so you don\'t have to worry about any mess\n '),
      ExpansionTileData(
          title: 'Common Problems',
          content: '1. Poor suction performance due to clogged filters.\n'
              '2. Excessive smoke or odor in the kitchen.\n'
              '3.	Grease buildup leading to strain on the motor.\n'
              '4.	Overheating of the chimney caused by inefficient filtration.\n'),
      ExpansionTileData(
          title: 'Excluded',
          content: '1. Chimney cleaning (available as a separate package).\n'
              '2. Repair or replacement of non-filter components.\n'
              '3. Motor or fan issues that require separate attention.\n')
    ];

    List<ExpansionTileData> completechimneycheckBeforeAirRepair = [
      ExpansionTileData(
          title: 'What to Expect',
          content:
          ' 1. Inspection : Our technician will visit your home, check your chimney, and let you know what needs to be fixed along with the estimated cost.\n'
              '2. Getting Spare Parts (If Needed) :	If any spare parts are required, the technician will arrange them from the local market to ensure a smooth repair process\n'
              '3. Repair Work: Once everything is ready, the technician will carry out the necessary repairs to get your chimney working properly again\n'
              '4. Cleaning Up : •	After the repair is done, we make sure to clean up the area so you don\'t have to worry about any mess\n '),
      ExpansionTileData(
          title: 'Common Problems',
          content: '1. Poor suction performance due to clogged filters.\n'
              '2. Excessive smoke or odor in the kitchen.\n'
              '3.	Grease buildup leading to strain on the motor.\n'
              '4.	Overheating of the chimney caused by inefficient filtration.\n'),
      ExpansionTileData(
          title: 'Excluded',
          content: '1. Chimney cleaning (available as a separate package).\n'
              '2. Repair or replacement of non-filter components.\n'
              '3. Motor or fan issues that require separate attention.\n')
    ];

    List<ExpansionTileData> chimneyMotorRepair = [
      ExpansionTileData(
          title: 'What to Expect',
          content:
          ' 1. Inspection : •	Our technician will visit your home, check your chimney, and let you know what needs to be fixed along with the estimated cost..\n'
              '2. Getting Spare Parts (If Needed) :	If any spare parts are required, the technician will arrange them from the local market to ensure a smooth repair process\n'
              '3. Repair Work: Once everything is ready, the technician will carry out the necessary repairs to get your chimney working properly again\n'
              '4. Cleaning Up : •	After the repair is done, we make sure to clean up the area so you don\'t have to worry about any mess\n '),
      ExpansionTileData(
          title: 'Common Problems',
          content: '1. Motor not functioning or stalling during operation.\n'
              '2. Reduced suction power due to motor failure.\n'
              '3.	Overheating of the chimney system caused by a faulty motor.\n'),
      ExpansionTileData(
          title: 'Excluded',
          content:
          '1. Cleaning of other chimney components (available under cleaning services).\n'
              '2. Replacement of other parts, such as filters or fans.\n'
              '3. Electrical wiring repair outside of motor-related issues.\n')
    ];

    List<ExpansionTileData> chimneySuctionPowerIssues = [
      ExpansionTileData(
          title: 'What to Expect',
          content:
          ' 1. Inspection : Our technician will visit your home, check your chimney, and let you know what needs to be fixed along with the estimated cost.\n'
              '2. Getting Spare Parts (If Needed) :	If any spare parts are required, the technician will arrange them from the local market to ensure a smooth repair process\n'
              '3. Repair Work: Once everything is ready, the technician will carry out the necessary repairs to get your chimney working properly again\n'
              '4. Cleaning Up : •	After the repair is done, we make sure to clean up the area so you don\'t have to worry about any mess\n '),
      ExpansionTileData(
          title: 'Common Problems',
          content:
          '1. •	Poor suction, causing smoke to remain in the kitchen.\n'
              '2. Smoke or odor backflow due to inadequate suction.\n'
              '3.	Inefficient removal of cooking fumes and odors.\n'),
      ExpansionTileData(
          title: 'Excluded',
          content:
          '1. Full cleaning services (covered under separate packages).\n'
              '2. Replacement of parts like filters or ducts unless related to the issue.\n'
              '3. Electrical repairs outside of suction power issues.\n')
    ];

    List<ExpansionTileData> chimneyFanRepair = [
      ExpansionTileData(
          title: 'What to Expect',
          content:
          ' 1. Inspection : Our technician will visit your home, check your chimney, and let you know what needs to be fixed along with the estimated cost.\n'
              '2. Getting Spare Parts (If Needed) :	If any spare parts are required, the technician will arrange them from the local market to ensure a smooth repair process\n'
              '3. Repair Work: Once everything is ready, the technician will carry out the necessary repairs to get your chimney working properly again\n'
              '4. Cleaning Up : •	After the repair is done, we make sure to clean up the area so you don\'t have to worry about any mess\n '),
      ExpansionTileData(
          title: 'Common Problems',
          content: '1. Fan not rotating or making unusual noises..\n'
              '2. Reduced airflow due to blower malfunction.\n'
              '3.	Overheating of the chimney caused by fan issues.\n'),
      ExpansionTileData(
          title: 'Excluded',
          content: '1. Full chimney cleaning (available separately).\n'
              '2. Electrical repairs unrelated to the fan.\n'
              '3. Replacement of other parts, such as the motor or filters.\n')
    ];

    List<ExpansionTileData> chimneyButtonRepair = [
      ExpansionTileData(
          title: 'What to Expect',
          content:
          ' 1. Inspection : Our technician will visit your home, check your chimney, and let you know what needs to be fixed along with the estimated cost.\n'
              '2. Getting Spare Parts (If Needed) :	If any spare parts are required, the technician will arrange them from the local market to ensure a smooth repair process\n'
              '3. Repair Work: Once everything is ready, the technician will carry out the necessary repairs to get your chimney working properly again\n'
              '4. Cleaning Up : •	After the repair is done, we make sure to clean up the area so you don\'t have to worry about any mess\n '),
      ExpansionTileData(
          title: 'Common Problems',
          content: '1. Unresponsive buttons or control panel.\n'
              '2. Control panel not displaying or functioning correctly.\n'
              '3.	Difficulty in adjusting fan speed or lighting due to control issues.\n'),
      ExpansionTileData(
          title: 'Service Excluded',
          content:
          '1. Repair of other electrical issues not related to the control panel.\n'
              '2. Replacement of non-control related components like filters or fans.\n'
              '3. Cleaning services.\n')
    ];

    List<ExpansionTileData> completeChimneyCheckUpDuctIssues = [
      ExpansionTileData(
          title: 'What to Expect',
          content:
          ' 1. Inspection : Our technician will visit your home, check your chimney, and let you know what needs to be fixed along with the estimated cost.\n'
              '2. Getting Spare Parts (If Needed) :	If any spare parts are required, the technician will arrange them from the local market to ensure a smooth repair process\n'
              '3. Repair Work: Once everything is ready, the technician will carry out the necessary repairs to get your chimney working properly again\n'
              '4. Cleaning Up : •	After the repair is done, we make sure to clean up the area so you don\'t have to worry about any mess\n '),
      ExpansionTileData(
          title: 'Common Problems',
          content:
          '1. Leaking or damaged ductwork causing reduced performance.\n'
              '2. Smoke or odors entering the kitchen due to duct issues.\n'
              '3.	Poor suction caused by obstructed or faulty ducts.\n'),
      ExpansionTileData(
          title: 'Excluded',
          content:
          '1. Cleaning of ducts or chimney (available under cleaning services)\n'
              '2. Repair of other chimney components like motors or filters\n'
              '3. Electrical repairs unrelated to ductwork\n')
    ];

    List<ExpansionTileData> chimneyInstallation = [
      ExpansionTileData(
          title: 'Common Problems',
          content: ' 1. Incorrect installation leading to poor suction.\n'
              '2. Improper duct connections resulting in smoke backflow\n'
              '3. Lack of ventilation or overheating due to poor placement\n'),
      ExpansionTileData(
          title: 'Service Included',
          content: '1. Full installation of the chimney unit in your kitchen.\n'
              '2. Proper ducting and ventilation setup for efficient airflow.\n'
              '3.	Mounting of the chimney according to the kitchen layout.\n'
              '4.	Testing to ensure correct operation of the motor, fan, and suction system.\n'
              '5. •	Safety checks for electrical connections\n'),
      ExpansionTileData(
          title: 'Excluded',
          content:
          '1. Installation of additional electrical outlets or wiring\n'
              '2. Repairs or adjustments to pre-existing ductwork.\n'
              '3. Chimney cleaning after installation.\n')
    ];

    List<ExpansionTileData> chimneyUnInstallation = [
      ExpansionTileData(
          title: 'Common Problems',
          content: ' 1. Potential damage to walls or ducts during removal.\n'
              '2. Improper disconnection leading to electrical hazards\n'
              '3. Unwanted debris or residual soot left behind after removal\n'),
      ExpansionTileData(
          title: 'Service Included',
          content: '1. Safe and careful removal of the chimney unit.\n'
              '2. Disconnection of all electrical and ductwork components.\n'
              '3.	Sealing of duct and electrical outlets (if required).\n'
              '4.	Cleaning of the area after uninstallation to remove any debris or soot.\n'
              '5. Inspection to ensure no damage is caused to the surrounding area\n'),
      ExpansionTileData(
          title: 'Excluded',
          content:
          '1. Repair of wall or duct damage caused by previous installations\n'
              '2. Installation of replacement chimneys (available as a separate service).\n'
              '3. Extensive cleaning or repair of the removed chimney unit.\n')
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
                ChimneyCleaningService,
                completechimneycheck,
                completechimneycheckBeforeAirRepair,
                chimneyMotorRepair,
                chimneySuctionPowerIssues,
                chimneyFanRepair,
                chimneyButtonRepair,
                completeChimneyCheckUpDuctIssues,
                chimneyInstallation,
                chimneyUnInstallation,
              )
                  : _buildDesktopTabletLayout(
                context,
                ChimneyCleaningService,
                completechimneycheck,
                completechimneycheckBeforeAirRepair,
                chimneyMotorRepair,
                chimneySuctionPowerIssues,
                chimneyFanRepair,
                chimneyButtonRepair,
                completeChimneyCheckUpDuctIssues,
                chimneyInstallation,
                chimneyUnInstallation,
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
      List<ExpansionTileData> ChimneyCleaningService,
      List<ExpansionTileData> completechimneycheck,
      List<ExpansionTileData> completechimneycheckBeforeAirRepair,
      List<ExpansionTileData> chimneyMotorRepair,
      List<ExpansionTileData> chimneySuctionPowerIssues,
      List<ExpansionTileData> chimneyFanRepair,
      List<ExpansionTileData> chimneyButtonRepair,
      List<ExpansionTileData> completeChimneyCheckUpDuctIssues,
      List<ExpansionTileData> chimneyInstallation,
      List<ExpansionTileData> chimneyUnInstallation,
      ) {
    return Column(
      children: [
        // Services Grid on top for mobile
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: ChimneyRepairServicesGrid(
            onServiceTap: (String serviceName) {
              _handleServiceTap(serviceName);
            },
          ),
        ),
        // Package cards below
        Column(
          children: [
            PackageCard(
              key: chimneyCleaningKey,
              expansionData: ChimneyCleaningService,
              packageTitle: 'Chimney Cleaning Service',
              packageDescription:
              'Cleans chimney components and ducts; excludes filter replacement, repairs, and electrical work',
              packageHighlight:
              'The Chimney Cleaning Service ensures that your chimney remains free from grease, soot, and other residues that accumulate with regular use. This service helps maintain the efficiency of the chimney, preventing malfunctions, reducing fire risks, and extending the unit\'s lifespan. Regular cleaning is recommended for optimal performance.',
              packagePrice: '₹399',
              onAdd: () {
                final cartData = Provider.of<CartData>(context, listen: false);
                cartData.addPackage(context, 'Chimney Cleaning Service', '399');
              },
            ),
            SizedBox(height: 16),
            PackageCard(
              key: chimneyCheckupFilterKey,
              packageTitle: 'Complete Chimney check-up to identify filter issues before repair/replacement',
              packageDescription:
              'The Chimney Filter Replacement service is essential for maintaining proper airflow and filtration in your chimney. Over time, filters can become clogged with grease and smoke particles, hindering suction power',
              packageHighlight: '',
              packagePrice: '₹499',
              onAdd: () {
                final cartData = Provider.of<CartData>(context, listen: false);
                cartData.addPackage(context, 'Complete Chimney check-up filter issues', '499');
              },
              expansionData: completechimneycheck,
            ),
            SizedBox(height: 16),
            PackageCard(
              key: chimneyCheckupAirflowKey,
              packageTitle: 'Complete Chimney check-up to identify airflow blockage issues before repair',
              packageDescription:
              'The Chimney Filter Replacement service is essential for maintaining proper airflow and filtration in your chimney. Over time, filters can become clogged with grease and smoke particles, hindering suction power',
              packageHighlight: '',
              packagePrice: '₹499',
              onAdd: () {
                final cartData = Provider.of<CartData>(context, listen: false);
                cartData.addPackage(context, 'Complete Chimney check-up airflow blockage', '499');
              },
              expansionData: completechimneycheckBeforeAirRepair,
            ),
            SizedBox(height: 16),
            PackageCard(
              key: chimneyMotorRepairKey,
              packageTitle: 'Chimney Motor Repair',
              packageDescription:
              'Complete Chimney check-up to identify motor issues before repair\n',
              packageHighlight:
              'The motor is a critical component of the chimney, ensuring proper suction of smoke and fumes from your kitchen. The Chimney Motor Repair service is designed to address issues with the motor, whether it\'s malfunctioning or requires complete replacement\n',
              packagePrice: '₹499',
              onAdd: () {
                final cartData = Provider.of<CartData>(context, listen: false);
                cartData.addPackage(context, 'Chimney Motor Repair', '499');
              },
              expansionData: chimneyMotorRepair,
            ),
            SizedBox(height: 16),
            PackageCard(
              key: chimneySuctionPowerKey,
              packageTitle: 'Chimney Suction Power Issues',
              packageDescription:
              'Complete Chimney check-up to identify suction power issues before repair',
              packageHighlight:
              'The Chimney Suction Power Issues service focuses on restoring the suction efficiency of your chimney. Reduced suction can result from several factors, including blockages, motor issues, or poor filter performance\n',
              packagePrice: '₹499',
              onAdd: () {
                final cartData = Provider.of<CartData>(context, listen: false);
                cartData.addPackage(context, 'Chimney Suction Power Issues', '499');
              },
              expansionData: chimneySuctionPowerIssues,
            ),
            SizedBox(height: 16),
            PackageCard(
              key: chimneyFanRepairKey,
              packageTitle: 'Chimney Fan/Blower Repair',
              packageDescription:
              'Complete Chimney check-up to identify fan blower issues before repair',
              packageHighlight:
              'The Chimney Fan/Blower Repair service ensures that the fan or blower, essential for effective smoke extraction, functions correctly. Over time, the fan can become clogged with grease or suffer from mechanical failure\n',
              packagePrice: '₹599',
              onAdd: () {
                final cartData = Provider.of<CartData>(context, listen: false);
                cartData.addPackage(context, 'Chimney Fan/Blower Repair', '599');
              },
              expansionData: chimneyFanRepair,
            ),
            SizedBox(height: 16),
            PackageCard(
              key: chimneyButtonRepairKey,
              packageTitle: 'Chimney Button/Control Panel Repair',
              packageDescription:
              'Complete Chimney check-up to identify control panel issues before repair',
              packageHighlight:
              'The Chimney Button/Control Panel Repair service addresses issues with the control panel or buttons that control the chimney\'s functions.\n',
              packagePrice: '₹499',
              onAdd: () {
                final cartData = Provider.of<CartData>(context, listen: false);
                cartData.addPackage(context, 'Chimney Button/Control Panel Repair', '499');
              },
              expansionData: chimneyButtonRepair,
            ),
            SizedBox(height: 16),
            PackageCard(
              key: chimneyDuctCheckupKey,
              packageTitle: 'Complete Chimney check-up to identify duct issues before repair/replacement',
              packageDescription:
              'The Chimney Duct Repair/Replacement service ensures that the ductwork of your chimney is in good condition, allowing efficient smoke extraction\n',
              packageHighlight: '',
              packagePrice: '₹549',
              onAdd: () {
                final cartData = Provider.of<CartData>(context, listen: false);
                cartData.addPackage(context, 'Complete Chimney check-up duct issues', '549');
              },
              expansionData: completeChimneyCheckUpDuctIssues,
            ),
            SizedBox(height: 16),
            PackageCard(
              key: chimneyInstallationKey,
              packageTitle: 'Chimney Installation Service',
              packageDescription:
              'Installs chimney unit, sets up ducting, tests operation, and checks electrical safety\n',
              packageHighlight:
              'The Chimney Installation Service ensures that your chimney is installed professionally, following all safety and operational guidelines\n',
              packagePrice: '₹499',
              onAdd: () {
                final cartData = Provider.of<CartData>(context, listen: false);
                cartData.addPackage(context, 'Chimney Installation Service', '499');
              },
              expansionData: chimneyInstallation,
            ),
            SizedBox(height: 16),
            PackageCard(
              key: chimneyUninstallationKey,
              packageTitle: 'Chimney Uninstallation Service',
              packageDescription:
              ' Removes chimney unit safely, disconnects components, seals ducts, cleans area, and inspects for damage post-uninstallation\n',
              packageHighlight:
              'The Chimney Uninstallation Service provides a safe and efficient removal of your chimney unit. Whether you are relocating, replacing the chimney, or no longer require it, this service ensures that the unit is uninstalled without causing damage to the kitchen or surrounding structures\n',
              packagePrice: '₹499',
              onAdd: () {
                final cartData = Provider.of<CartData>(context, listen: false);
                cartData.addPackage(context, 'Chimney Uninstallation Service', '499');
              },
              expansionData: chimneyUnInstallation,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopTabletLayout(
      BuildContext context,
      List<ExpansionTileData> ChimneyCleaningService,
      List<ExpansionTileData> completechimneycheck,
      List<ExpansionTileData> completechimneycheckBeforeAirRepair,
      List<ExpansionTileData> chimneyMotorRepair,
      List<ExpansionTileData> chimneySuctionPowerIssues,
      List<ExpansionTileData> chimneyFanRepair,
      List<ExpansionTileData> chimneyButtonRepair,
      List<ExpansionTileData> completeChimneyCheckUpDuctIssues,
      List<ExpansionTileData> chimneyInstallation,
      List<ExpansionTileData> chimneyUnInstallation,
      bool isTablet,
      ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Services Grid
        Expanded(
          flex: isTablet ? 5 : 4,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: isTablet ? 500 : 380,
              minWidth: isTablet ? 380 : 320,
            ),
            child: ChimneyRepairServicesGrid(
              onServiceTap: (String serviceName) {
                _handleServiceTap(serviceName);
              },
            ),
          ),
        ),
        SizedBox(width: isTablet ? 20 : 24),
        // Package cards
        Expanded(
          flex: isTablet ? 7 : 6,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              children: [
                PackageCard(
                  key: chimneyCleaningKey,
                  expansionData: ChimneyCleaningService,
                  packageTitle: 'Chimney Cleaning Service',
                  packageDescription:
                  'Cleans chimney components and ducts; excludes filter replacement, repairs, and electrical work',
                  packageHighlight:
                  'The Chimney Cleaning Service ensures that your chimney remains free from grease, soot, and other residues that accumulate with regular use. This service helps maintain the efficiency of the chimney, preventing malfunctions, reducing fire risks, and extending the unit\'s lifespan. Regular cleaning is recommended for optimal performance.',
                  packagePrice: '₹399',
                  onAdd: () {
                    final cartData = Provider.of<CartData>(context, listen: false);
                    cartData.addPackage(context, 'Chimney Cleaning Service', '399');
                  },
                ),
                SizedBox(height: 16),
                PackageCard(
                  key: chimneyMotorRepairKey,
                  packageTitle: 'Chimney Motor Repair',
                  packageDescription:
                  'Complete Chimney check-up to identify motor issues before repair\n',
                  packageHighlight:
                  'The motor is a critical component of the chimney, ensuring proper suction of smoke and fumes from your kitchen. The Chimney Motor Repair service is designed to address issues with the motor, whether it\'s malfunctioning or requires complete replacement\n',
                  packagePrice: '₹499',
                  onAdd: () {
                    final cartData = Provider.of<CartData>(context, listen: false);
                    cartData.addPackage(context, 'Chimney Motor Repair', '499');
                  },
                  expansionData: chimneyMotorRepair,
                ),
                SizedBox(height: 16),
                PackageCard(
                  key: chimneySuctionPowerKey,
                  packageTitle: 'Chimney Suction Power Issues',
                  packageDescription:
                  'Complete Chimney check-up to identify suction power issues before repair',
                  packageHighlight:
                  'The Chimney Suction Power Issues service focuses on restoring the suction efficiency of your chimney. Reduced suction can result from several factors, including blockages, motor issues, or poor filter performance\n',
                  packagePrice: '₹499',
                  onAdd: () {
                    final cartData = Provider.of<CartData>(context, listen: false);
                    cartData.addPackage(context, 'Chimney Suction Power Issues', '499');
                  },
                  expansionData: chimneySuctionPowerIssues,
                ),
                SizedBox(height: 16),
                PackageCard(
                  key: chimneyFanRepairKey,
                  packageTitle: 'Chimney Fan/Blower Repair',
                  packageDescription:
                  'Complete Chimney check-up to identify fan blower issues before repair',
                  packageHighlight:
                  'The Chimney Fan/Blower Repair service ensures that the fan or blower, essential for effective smoke extraction, functions correctly. Over time, the fan can become clogged with grease or suffer from mechanical failure\n',
                  packagePrice: '₹599',
                  onAdd: () {
                    final cartData = Provider.of<CartData>(context, listen: false);
                    cartData.addPackage(context, 'Chimney Fan/Blower Repair', '599');
                  },
                  expansionData: chimneyFanRepair,
                ),
                SizedBox(height: 16),
                PackageCard(
                  key: chimneyButtonRepairKey,
                  packageTitle: 'Chimney Button/Control Panel Repair',
                  packageDescription:
                  'Complete Chimney check-up to identify control panel issues before repair',
                  packageHighlight:
                  'The Chimney Button/Control Panel Repair service addresses issues with the control panel or buttons that control the chimney\'s functions.\n',
                  packagePrice: '₹499',
                  onAdd: () {
                    final cartData = Provider.of<CartData>(context, listen: false);
                    cartData.addPackage(context, 'Chimney Button/Control Panel Repair', '499');
                  },
                  expansionData: chimneyButtonRepair,
                ),
                SizedBox(height: 16),
                PackageCard(
                  key: chimneyDuctCheckupKey,
                  packageTitle: 'Complete Chimney check-up to identify duct issues before repair/replacement',
                  packageDescription:
                  'The Chimney Duct Repair/Replacement service ensures that the ductwork of your chimney is in good condition, allowing efficient smoke extraction\n',
                  packageHighlight: '',
                  packagePrice: '₹549',
                  onAdd: () {
                    final cartData = Provider.of<CartData>(context, listen: false);
                    cartData.addPackage(context, 'Complete Chimney check-up duct issues', '549');
                  },
                  expansionData: completeChimneyCheckUpDuctIssues,
                ),
                SizedBox(height: 16),
                PackageCard(
                  key: chimneyInstallationKey,
                  packageTitle: 'Chimney Installation Service',
                  packageDescription:
                  'Installs chimney unit, sets up ducting, tests operation, and checks electrical safety\n',
                  packageHighlight:
                  'The Chimney Installation Service ensures that your chimney is installed professionally, following all safety and operational guidelines\n',
                  packagePrice: '₹499',
                  onAdd: () {
                    final cartData = Provider.of<CartData>(context, listen: false);
                    cartData.addPackage(context, 'Chimney Installation Service', '499');
                  },
                  expansionData: chimneyInstallation,
                ),
                SizedBox(height: 16),
                PackageCard(
                  key: chimneyUninstallationKey,
                  packageTitle: 'Chimney Uninstallation Service',
                  packageDescription:
                  ' Removes chimney unit safely, disconnects components, seals ducts, cleans area, and inspects for damage post-uninstallation\n',
                  packageHighlight:
                  'The Chimney Uninstallation Service provides a safe and efficient removal of your chimney unit. Whether you are relocating, replacing the chimney, or no longer require it, this service ensures that the unit is uninstalled without causing damage to the kitchen or surrounding structures\n',
                  packagePrice: '₹499',
                  onAdd: () {
                    final cartData = Provider.of<CartData>(context, listen: false);
                    cartData.addPackage(context, 'Chimney Uninstallation Service', '499');
                  },
                  expansionData: chimneyUnInstallation,
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
    if (serviceName.contains('Chimney Cleaning Service')) {
      scrollToSection(chimneyCleaningKey);
    } else if (serviceName.contains('Chimney Check-up')) {
      scrollToSection(chimneyCheckupFilterKey);
    } else if (serviceName.contains('Motor Repair')) {
      scrollToSection(chimneyMotorRepairKey);
    } else if (serviceName.contains('Suction Power')) {
      scrollToSection(chimneySuctionPowerKey);
    } else if (serviceName.contains('Fan') || serviceName.contains('Blower')) {
      scrollToSection(chimneyFanRepairKey);
    } else if (serviceName.contains('Button') || serviceName.contains('Control Panel')) {
      scrollToSection(chimneyButtonRepairKey);
    } else if (serviceName.contains('Installation') && serviceName.contains('Removal')) {
      scrollToSection(chimneyInstallationKey);
    } else if (serviceName.contains('Uninstallation')) {
      scrollToSection(chimneyUninstallationKey);
    }
  }
}