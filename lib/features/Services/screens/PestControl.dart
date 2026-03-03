import 'package:flutter/material.dart';
import 'package:zencare/common/appbar.dart';
import 'package:zencare/common/footer.dart';
import 'package:zencare/features/Services/widgets/Packages.dart';
import 'package:zencare/features/Services/widgets/PestControlGrid.dart';
import 'package:provider/provider.dart';
import 'package:zencare/features/controller.dart';

class PestControl extends StatefulWidget {
  const PestControl({super.key});

  @override
  State<PestControl> createState() => _PestControlState();
}

class _PestControlState extends State<PestControl> {
  // Global keys for scrolling to sections
  final GlobalKey kitchenBathroomKey = GlobalKey();
  final GlobalKey apartmentWithUtensilKey = GlobalKey();
  final GlobalKey apartmentWithoutUtensilKey = GlobalKey();
  final GlobalKey independentHouseKey = GlobalKey();
  final GlobalKey cockroachControlKey = GlobalKey();
  final GlobalKey bedBugControlKey = GlobalKey();
  final GlobalKey commercialPestControlKey = GlobalKey();

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

    List<ExpansionTileData> kitchenPestControl = [
      ExpansionTileData(
          title: 'Service Includes',
          content:
          '1. Thorough inspection to identify infestation sources and entry points.\n'
              '2. Removal of utensils for comprehensive treatment of all areas.\n'
              '3. Application of eco-friendly and safe pest control solutions to eradicate pests.\n'
              '4. Treatment of cracks, drains, and hidden breeding zones.\n'
              '5. Perimeter protection to prevent future infestations.\n'
              '6. Expert advice on maintaining a pest-free kitchen and bathroom.'),
      ExpansionTileData(
          title: 'Not Included',
          content: '1. Replacing or reorganizing utensils after the service.\n'
              '2. Pest control services outside the designated kitchen or bathroom areas.\n'
              '3.	Specialized treatments for pests such as termites, bed bugs, or honey bees.\n'
              '4.	Structural repairs or sealing of large cracks or gaps.\n'),
      ExpansionTileData(
          title: 'Benefits',
          content:
          '1. Thorough Coverage: Utensil removal ensures no area is left untreated.\n'
              '2. Safe for Families: Non-toxic treatments are safe for children and pets.\n'
              '3. Hygienic Spaces: Eliminates disease-causing pests for a cleaner kitchen and bathroom.\n'
              '4.	Long-Lasting Protection: Preventive measures keep pests away for longer.\n'
              '5.	Convenient Service: Professionals handle utensil removal for your convenience.')
    ];
    List<ExpansionTileData> apartmentWithUtensilPestControl = [
      ExpansionTileData(
          title: 'Service Includes',
          content:
          '1. Inspection to identify pest entry points and infested areas.\n'
              '2. Removal of utensils to access all hidden and hard-to-reach spaces.\n'
              '3. Application of safe and effective pest control treatments.\n'
              '4. Treatment of cracks, drains, and breeding zones.\n'
              '5. Perimeter protection to block future pest entry.\n'
              '6. Expert advice on maintaining a pest-free apartment.'),
      ExpansionTileData(
          title: 'Not Included',
          content: '1. Replacing or reorganizing utensils after the service.\n'
              '2. Pest control for areas outside the apartment premises.\n'
              '3. Specialized treatments for termites, bed bugs, or honey bees.\n'
              '4. Structural repairs or sealing of major cracks or gaps.'),
      ExpansionTileData(
          title: 'Benefits',
          content:
          '1. Comprehensive Treatment: Utensil removal ensures thorough pest control.\n'
              '2. Safe & Eco-Friendly: Non-toxic solutions are safe for families and pets.\n'
              '3. Long-Term Protection: Preventive measures keep pests from returning.\n'
              '4. Convenient Service: Minimal effort required as professionals handle utensil removal.\n'
              '5. Apartment-Focused Solutions: Specifically designed for pest issues in apartment living.')
    ];
    List<ExpansionTileData> apartmentWithOutUtensilPestControl = [
      ExpansionTileData(
          title: 'Service Includes',
          content:
          '1. Inspection to locate pest entry points and infestation sources.\n'
              '2. Application of family-safe pest control solutions to eliminate pests.\n'
              '3. Treatment of cracks, drains, and breeding areas.\n'
              '4. Perimeter protection to prevent future pest entry.\n'
              '5. Guidance from professionals on pest prevention and maintenance.'),
      ExpansionTileData(
          title: 'Not Included',
          content:
          '1. Removal or reorganization of utensils before or after the service.\n'
              '2. Pest control for areas outside the apartment premises.\n'
              '3. Specialized treatments for termites, bed bugs, or honey bees.\n'
              '4. Repairs or sealing of structural issues.'),
      ExpansionTileData(
          title: 'Benefits',
          content:
          '1. Cost-Effective Solution: Save money by managing utensil removal yourself.\n'
              '2. Safe & Reliable: Non-toxic treatments that ensure effective pest elimination.\n'
              '3. Long-Term Results: Preventive measures to maintain pest-free spaces.\n'
              '4. Apartment-Specific Service: Designed for common pest issues in apartments.')
    ];
    List<ExpansionTileData> independentHousePestControl = [
      ExpansionTileData(
          title: 'Service Includes',
          content:
          '1. Detailed inspection to identify pest entry points and breeding zones.\n'
              '2. Removal of utensils to enable thorough access and treatment.\n'
              '3. Application of eco-friendly and family-safe pest control solutions.\n'
              '4. Crack and crevice treatment, including drains and hidden spaces.\n'
              '5. Perimeter protection to block future pest entry points.\n'
              '6. Professional guidance on maintaining a pest-free home.'),
      ExpansionTileData(
          title: 'Not Included',
          content: '1. Replacing or reorganizing utensils after the service.\n'
              '2. Pest control for external areas like gardens or outhouses (available separately).\n'
              '3. Specialized treatments for termites, bed bugs, or honey bees.\n'
              '4. Repairs or sealing of structural issues such as large cracks or gaps.'),
      ExpansionTileData(
          title: 'Benefits',
          content:
          '1. Comprehensive Treatment: Utensil removal ensures no area is left untreated.\n'
              '2. Family-Safe Solutions: Non-toxic products safe for children and pets.\n'
              '3. Long-Term Protection: Preventive measures help keep pests away.\n'
              '4. Convenient Service: Professionals handle utensil removal for a stress-free experience.\n'
              '5. Tailored for Bungalows: Specifically designed for larger, independent homes.')
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
                kitchenPestControl,
                apartmentWithUtensilPestControl,
                apartmentWithOutUtensilPestControl,
                independentHousePestControl,
              )
                  : _buildDesktopTabletLayout(
                context,
                kitchenPestControl,
                apartmentWithUtensilPestControl,
                apartmentWithOutUtensilPestControl,
                independentHousePestControl,
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
      List<ExpansionTileData> kitchenPestControl,
      List<ExpansionTileData> apartmentWithUtensilPestControl,
      List<ExpansionTileData> apartmentWithOutUtensilPestControl,
      List<ExpansionTileData> independentHousePestControl,
      ) {
    return Column(
      children: [
        // Services Grid on top for mobile
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: PestControlGrid(
            onServiceTap: (String serviceName) {
              _handleServiceTap(serviceName);
            },
          ),
        ),
        // Package cards below
        Column(
          children: [
            PackageCard(
              key: kitchenBathroomKey,
              onAdd: () {
                final cartData = Provider.of<CartData>(context, listen: false);
                cartData.addPackage(context, 'Kitchen & Bathroom', '500');
              },
              expansionData: kitchenPestControl,
              packageTitle: 'Kitchen & Bathroom',
              packageDescription:
              'Inspection, eco-friendly treatment, crack/drain coverage, perimeter safety, expert advice.',
              packageHighlight:
              'This pest control service for kitchens and bathrooms is designed to ensure complete pest elimination with minimal hassle. It includes utensil removal, allowing professionals to access and treat every hidden area effectively. Perfect for addressing cockroaches, ants, and other common pests in these spaces.',
              packagePrice: '₹500',
            ),
            SizedBox(height: 16),
            PackageCard(
              key: apartmentWithUtensilKey,
              onAdd: () {
                final cartData = Provider.of<CartData>(context, listen: false);
                cartData.addPackage(context, 'Apartment Pest Control (With Utensils)', '1000');
              },
              expansionData: apartmentWithUtensilPestControl,
              packageTitle:
              'Apartment Pest Control (Includes Utensil Removal)',
              packageDescription:
              'Thorough inspection, utensil removal, safe treatment, crack/drain coverage, perimeter safety, expert tips.',
              packageHighlight:
              'This pest control service is tailored for apartments, ensuring complete pest removal with the added convenience of utensil removal. Professionals access every hidden area to treat pests effectively, making it ideal for dealing with cockroaches, ants, and other common infestations in apartment settings.',
              packagePrice: '₹1000',
            ),
            SizedBox(height: 16),
            PackageCard(
              key: apartmentWithoutUtensilKey,
              onAdd: () {
                final cartData = Provider.of<CartData>(context, listen: false);
                cartData.addPackage(context, 'Apartment Pest Control (Without Utensils)', '750');
              },
              expansionData: apartmentWithOutUtensilPestControl,
              packageTitle:
              'Apartment Pest Control (Excludes Utensil Removal)',
              packageDescription:
              'Inspection, safe solutions, crack/drain treatment, perimeter safety, expert pest prevention tips.',
              packageHighlight:
              'This budget-friendly pest control service is designed for apartments where utensil removal can be managed by the homeowner. It delivers effective pest treatments to eliminate infestations and maintain a clean, pest-free environment.',
              packagePrice: '₹750',
            ),
            SizedBox(height: 16),
            PackageCard(
              key: independentHouseKey,
              onAdd: () {
                final cartData = Provider.of<CartData>(context, listen: false);
                cartData.addPackage(context, 'Independent House', '1500');
              },
              expansionData: independentHousePestControl,
              packageTitle:
              'Independent House',
              packageDescription:
              'Inspection, utensil removal, eco-friendly solutions, crack/drain treatment, perimeter safety, expert tips.',
              packageHighlight:
              'This premium pest control service for bungalows and independent houses ensures complete pest removal with the added convenience of utensil removal. Professionals access hidden and hard-to-reach areas, providing effective treatment for cockroaches, ants, and other pests commonly found in larger homes.',
              packagePrice: '₹1500',
            ),
            SizedBox(height: 16),
            PackageCard(
              key: cockroachControlKey,
              onAdd: () {
                final cartData = Provider.of<CartData>(context, listen: false);
                cartData.addPackage(context, 'Cockroach Control Treatment', '500');
              },
              expansionData: [],
              packageTitle:
              'Cockroach Control Treatment',
              packageDescription:
              'Inspection, gel bait/spray treatment, crack/drain coverage, perimeter safety, expert prevention tips.',
              packageHighlight:
              '',
              packagePrice: '₹500',
            ),
            SizedBox(height: 16),
            PackageCard(
              key: bedBugControlKey,
              onAdd: () {
                final cartData = Provider.of<CartData>(context, listen: false);
                cartData.addPackage(context, 'Bed Bug Control', '350');
              },
              expansionData: [],
              packageTitle:
              'Bed Bug Control',
              packageDescription:
              'Inspection, safe treatments, mattress/furniture care, crack coverage, expert prevention tips.',
              packageHighlight:
              '',
              packagePrice: '₹350',
            ),
            SizedBox(height: 16),
            PackageCard(
              key: commercialPestControlKey,
              onAdd: () {
                final cartData = Provider.of<CartData>(context, listen: false);
                cartData.addPackage(context, 'Commercial Office/Shop Pest Control', '1500');
              },
              expansionData: [],
              packageTitle:
              'Commercial Office/Shop Pest Control',
              packageDescription:
              'Comprehensive inspections, tailored treatments, and ongoing monitoring ensure effective pest control for your business.',
              packageHighlight:
              '',
              packagePrice: '₹1500',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopTabletLayout(
      BuildContext context,
      List<ExpansionTileData> kitchenPestControl,
      List<ExpansionTileData> apartmentWithUtensilPestControl,
      List<ExpansionTileData> apartmentWithOutUtensilPestControl,
      List<ExpansionTileData> independentHousePestControl,
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
            child: PestControlGrid(
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
                  key: kitchenBathroomKey,
                  onAdd: () {
                    final cartData = Provider.of<CartData>(context, listen: false);
                    cartData.addPackage(context, 'Kitchen & Bathroom', '500');
                  },
                  expansionData: kitchenPestControl,
                  packageTitle: 'Kitchen & Bathroom',
                  packageDescription:
                  'Inspection, eco-friendly treatment, crack/drain coverage, perimeter safety, expert advice.',
                  packageHighlight:
                  'This pest control service for kitchens and bathrooms is designed to ensure complete pest elimination with minimal hassle. It includes utensil removal, allowing professionals to access and treat every hidden area effectively. Perfect for addressing cockroaches, ants, and other common pests in these spaces.',
                  packagePrice: '₹500',
                ),
                SizedBox(height: 16),
                PackageCard(
                  key: apartmentWithUtensilKey,
                  onAdd: () {
                    final cartData = Provider.of<CartData>(context, listen: false);
                    cartData.addPackage(context, 'Apartment Pest Control (With Utensils)', '1000');
                  },
                  expansionData: apartmentWithUtensilPestControl,
                  packageTitle:
                  'Apartment Pest Control (Includes Utensil Removal)',
                  packageDescription:
                  'Thorough inspection, utensil removal, safe treatment, crack/drain coverage, perimeter safety, expert tips.',
                  packageHighlight:
                  'This pest control service is tailored for apartments, ensuring complete pest removal with the added convenience of utensil removal. Professionals access every hidden area to treat pests effectively, making it ideal for dealing with cockroaches, ants, and other common infestations in apartment settings.',
                  packagePrice: '₹1000',
                ),
                SizedBox(height: 16),
                PackageCard(
                  key: apartmentWithoutUtensilKey,
                  onAdd: () {
                    final cartData = Provider.of<CartData>(context, listen: false);
                    cartData.addPackage(context, 'Apartment Pest Control (Without Utensils)', '750');
                  },
                  expansionData: apartmentWithOutUtensilPestControl,
                  packageTitle:
                  'Apartment Pest Control (Excludes Utensil Removal)',
                  packageDescription:
                  'Inspection, safe solutions, crack/drain treatment, perimeter safety, expert pest prevention tips.',
                  packageHighlight:
                  'This budget-friendly pest control service is designed for apartments where utensil removal can be managed by the homeowner. It delivers effective pest treatments to eliminate infestations and maintain a clean, pest-free environment.',
                  packagePrice: '₹750',
                ),
                SizedBox(height: 16),
                PackageCard(
                  key: independentHouseKey,
                  onAdd: () {
                    final cartData = Provider.of<CartData>(context, listen: false);
                    cartData.addPackage(context, 'Independent House', '1500');
                  },
                  expansionData: independentHousePestControl,
                  packageTitle:
                  'Independent House',
                  packageDescription:
                  'Inspection, utensil removal, eco-friendly solutions, crack/drain treatment, perimeter safety, expert tips.',
                  packageHighlight:
                  'This premium pest control service for bungalows and independent houses ensures complete pest removal with the added convenience of utensil removal. Professionals access hidden and hard-to-reach areas, providing effective treatment for cockroaches, ants, and other pests commonly found in larger homes.',
                  packagePrice: '₹1500',
                ),
                SizedBox(height: 16),
                PackageCard(
                  key: cockroachControlKey,
                  onAdd: () {
                    final cartData = Provider.of<CartData>(context, listen: false);
                    cartData.addPackage(context, 'Cockroach Control Treatment', '500');
                  },
                  expansionData: [],
                  packageTitle:
                  'Cockroach Control Treatment',
                  packageDescription:
                  'Inspection, gel bait/spray treatment, crack/drain coverage, perimeter safety, expert prevention tips.',
                  packageHighlight:
                  '',
                  packagePrice: '₹500',
                ),
                SizedBox(height: 16),
                PackageCard(
                  key: bedBugControlKey,
                  onAdd: () {
                    final cartData = Provider.of<CartData>(context, listen: false);
                    cartData.addPackage(context, 'Bed Bug Control', '350');
                  },
                  expansionData: [],
                  packageTitle:
                  'Bed Bug Control',
                  packageDescription:
                  'Inspection, safe treatments, mattress/furniture care, crack coverage, expert prevention tips.',
                  packageHighlight:
                  '',
                  packagePrice: '₹350',
                ),
                SizedBox(height: 16),
                PackageCard(
                  key: commercialPestControlKey,
                  onAdd: () {
                    final cartData = Provider.of<CartData>(context, listen: false);
                    cartData.addPackage(context, 'Commercial Office/Shop Pest Control', '1500');
                  },
                  expansionData: [],
                  packageTitle:
                  'Commercial Office/Shop Pest Control',
                  packageDescription:
                  'Comprehensive inspections, tailored treatments, and ongoing monitoring ensure effective pest control for your business.',
                  packageHighlight:
                  '',
                  packagePrice: '₹1500',
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
    if (serviceName.contains('Kitchen and Bathroom')) {
      scrollToSection(kitchenBathroomKey);
    } else if (serviceName.contains('Includes Utensil Removal')) {
      scrollToSection(apartmentWithUtensilKey);
    } else if (serviceName.contains('Excludes Utensil Removal')) {
      scrollToSection(apartmentWithoutUtensilKey);
    } else if (serviceName.contains('Independent House')) {
      scrollToSection(independentHouseKey);
    } else if (serviceName.contains('Cockroach Control')) {
      scrollToSection(cockroachControlKey);
    } else if (serviceName.contains('Bed Bug Control')) {
      scrollToSection(bedBugControlKey);
    } else if (serviceName.contains('Commercial Office/Shop')) {
      scrollToSection(commercialPestControlKey);
    }
  }
}