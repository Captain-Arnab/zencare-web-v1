import 'package:flutter/material.dart';
import 'package:zencare/common/appbar.dart';
import 'package:zencare/common/footer.dart';
import 'package:zencare/features/Services/widgets/Packages.dart';
import 'package:zencare/features/Services/widgets/MenSalonServicesGrid.dart';
import 'package:zencare/features/Services/widgets/WomenSalonServicesGrid.dart';
import 'package:zencare/features/controller.dart';
import 'package:provider/provider.dart';

class SalonService extends StatefulWidget {
  final bool isWomenSalon;

  const SalonService({super.key, this.isWomenSalon = true});

  @override
  State<SalonService> createState() => _SalonServiceState();
}

class _SalonServiceState extends State<SalonService> {
  late bool _isWomenSalon;
  final ScrollController _scrollController = ScrollController();

  // Global keys for each section
  final Map<String, GlobalKey> _sectionKeys = {
    // Men's sections
    'Haircut': GlobalKey(),
    'Shave & Beard': GlobalKey(),
    'Facial': GlobalKey(),
    'Detan': GlobalKey(),
    'Hair Color': GlobalKey(),
    'Beard Color': GlobalKey(),
    // Women's sections
    'Gold Facial': GlobalKey(),
    'Instant Glow Facial': GlobalKey(),
    'Threading': GlobalKey(),
    'Brightening Facial': GlobalKey(),
    'Anti-Tanning Facial': GlobalKey(),
    'O2 Stay Youthful': GlobalKey(),
  };

  @override
  void initState() {
    super.initState();
    _isWomenSalon = widget.isWomenSalon;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(String sectionTitle) {
    final key = _sectionKeys[sectionTitle];
    if (key?.currentContext != null) {
      final RenderBox renderBox = key!.currentContext!.findRenderObject() as RenderBox;
      final position = renderBox.localToGlobal(Offset.zero, ancestor: context.findRenderObject());
      final screenWidth = MediaQuery.of(context).size.width;

      double offset = position.dy + _scrollController.offset;

      if (screenWidth < 768) {
        offset -= 100;
      } else if (screenWidth < 1024) {
        offset -= 120;
      } else {
        offset -= 140;
      }

      _scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final isDesktop = screenWidth >= 1024;
    final isMobile = screenWidth < 768;

    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16.0 : isTablet ? 32.0 : 100.0,
                vertical: 20.0,
              ),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.all(4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildToggleButton(
                        'Women\'s Salon',
                        _isWomenSalon,
                            () {
                          setState(() {
                            _isWomenSalon = true;
                          });
                        },
                        isMobile,
                      ),
                      _buildToggleButton(
                        'Men\'s Salon',
                        !_isWomenSalon,
                            () {
                          setState(() {
                            _isWomenSalon = false;
                          });
                        },
                        isMobile,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16.0 : isTablet ? 32.0 : 100.0,
                vertical: 16.0,
              ),
              child: _isWomenSalon
                  ? _buildWomenSalonContent(isMobile, isTablet)
                  : _buildMenSalonContent(isMobile, isTablet),
            ),
            Footer()
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton(
      String text,
      bool isSelected,
      VoidCallback onTap,
      bool isMobile,
      ) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : 40,
          vertical: isMobile ? 10 : 12,
        ),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF1765AE) : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            fontSize: isMobile ? 14 : 16,
          ),
        ),
      ),
    );
  }

  Widget _buildWomenSalonContent(bool isMobile, bool isTablet) {
    // All expansion tile data for women's services
    List<ExpansionTileData> goldFacialData = [
      ExpansionTileData(
          title: 'Procedure',
          content:
          '1. Cleansing Gel: Cleansing the face with ODR face cleanser.\n'
              '2. Lactic Peel: Apply and remove after 5-7 minutes, followed by blackhead & whitehead extraction.\n'
              '3. Massage Gel: Face massage for 7-10 minutes using a massage gel.\n'
              '4. Massage Cream: Face, neck, and back massage for 7-10 minutes (skipped for oily skin).\n'
              '5. Cream & Eye Mask: Application to relieve tension.\n'
              '6. Serum: Absorbed into the skin.\n'
              '7. Gold Powder Peel-Off Mask: Applied and peeled off after drying.\n'
              '8. Sunscreen: To protect from UV rays and blue light.\n'),
      ExpansionTileData(
          title: 'Benefits',
          content: '1. Reduces wrinkles and fine lines.\n'
              '2. Improves skin elasticity.\n'
              '3. Helps treat sun damage by reducing melanin levels.\n'
              '4. Soothes and nourishes the skin with almond oil.\n'),
      ExpansionTileData(
        title: 'Products Used',
        content:
        'Includes cleanser, lactic peel, massage gel, cream mask, eye mask, face serum, sunscreen, and a giveaway sheet mask.\n',
      ),
      ExpansionTileData(
          title: 'Aftercare Tips',
          content: '1. Always apply sunscreen (SPF 25+) after the facial.\n'
              '2. Avoid harsh scrubs or chemical peel-offs for at least 20 days.\n'
              '3. Avoid hot showers for 24 hours.\n'
              '4. Apply a sheet mask twice a week for better results.\n'),
      ExpansionTileData(
        title: 'Precautions',
        content: '1. Avoid bleach with the peel.\n'
            '2. Apply peel 30 days after using bleach.\n'
            '3. Avoid the facial for at least 15 days after laser hair removal or chemical peels.\n',
      ),
      ExpansionTileData(
        title: 'Recommended For',
        content:
        'All skin types, especially premature, mature, dry, dull, and excessively dry skin.',
      ),
    ];

    List<ExpansionTileData> instantGlowFacialData = [
      ExpansionTileData(
          title: 'Procedure',
          content:
          '1. Setup: Partner secures tools & products for uninterrupted service.\n'
              '2. Cleansing: Cleanser is massaged into the skin using an ultrasonic spatula to balance oil production.\n'
              '3. Exfoliation: Skin is exfoliated with gel to remove dead cells and excess oil.\n'
              '4. Extraction: Steam is applied to open pores, followed by blackhead extraction.\n'
              '5. Toner: Applied to tighten pores post-extraction.\n'
              '6. Serum: Skin serum is massaged into the skin with an ultrasonic spatula.\n'
              '7. Cream: Nourishing cream is massaged on the face, neck, and lower neckline.\n'
              '8. Mask Application: A mask is applied. While drying, a shoulder and leg massage is given.\n'
              '9. SPF Application: SPF 30 is applied to seal in the benefits of the treatment.'),
      ExpansionTileData(
          title: 'Benefits',
          content: '1. Illuminates and unveils a vibrant complexion.\n'
              '2. Boosts collagen production, soothes the skin, and tightens pores.\n'
              '3. Improves overall texture and skin tone with vitamins A, C, and E.\n'),
      ExpansionTileData(
        title: 'Products Used',
        content: '1. Cleanser: Balances oil and regulates production.\n'
            '2. Exfoliating Gel: Removes dead skin cells.\n'
            '3. Serum: Tightens skin and reduces pore size (Elderflower).\n'
            '4. Cream: Boosts collagen production (Vitamins A, C & E).\n'
            '5. Face Pack: Improves skin tone and texture.\n'
            '6. Gel: Soothes and reduces inflammation.\n'
            '7. Sunscreen: Minimizes damage caused by UV radiation.\n',
      ),
      ExpansionTileData(
          title: 'Aftercare Tips',
          content: '1. Apply moisturizer and sunscreen regularly.\n'
              '2. Avoid makeup and harsh scrubs for 24 hours post-service.\n'
              '3. Do not shower immediately with warm or hot water.\n'),
      ExpansionTileData(
        title: 'Recommended For',
        content: 'Normal to oily skin types.',
      ),
    ];

    List<ExpansionTileData> threadingData = [
      ExpansionTileData(
          title: 'Overview',
          content:
          '1. Desired Shape: Achieve perfectly shaped eyebrows or facial threading with precision.\n'
              '2. Low Pain: Gentle and careful threading for minimal discomfort.\n'
              '3. Sanitized Tools: All tools are thoroughly cleaned and sanitized.\n'
              '4. Good Quality Thread: Organica threads are used for a smooth experience.\n'
              '5. Mess-Free: Neat and tidy process without leaving a mess.\n'
              '6. Experienced Professionals: Skilled and trained professionals ensure the best results.\n'),
      ExpansionTileData(
          title: 'Procedure',
          content:
          '1. Preparation: The skin is cleansed, followed by talcum powder application to the area for smooth threading.\n'
              '2. Threading: Precise and gentle threading using high-quality thread for defined results.\n'
              '3. Post-Service Massage: A soothing massage with cream/toner is applied to relax the newly threaded skin.\n'),
      ExpansionTileData(
          title: 'Aftercare Tips',
          content: '1. Wash the area with cold water to soothe the skin.\n'
              '2. Apply a light moisturizer if needed to keep the skin hydrated.\n'
              '3. Avoid touching the freshly threaded area immediately after the service.\n'
              '4. Avoid using harsh products like scrubs or peels for 1-2 days after threading.\n'),
    ];

    List<ExpansionTileData> brighteningFacialData = [
      ExpansionTileData(
          title: 'Procedure',
          content:
          '1. Cleansing: Face is cleansed using Cleanser.\n'
              '2. Peel Application: Vitamin-C Peel Powder mixed with Brightening Peel Lotion, left on for 2 minutes.\n'
              '3. Peel Removal: Removed using a spatula, followed by blackhead & whitehead extraction.\n'
              '4. Massage: Rejuvenating Massage Cream applied to the face, back, and neck for 10-15 minutes.\n'
              '5. Pack: Lightening Pack applied and removed after 15 minutes.\n'
              '6. Serum: Absorbed into the skin.\n'),
      ExpansionTileData(
          title: 'Benefits',
          content:
          '1. Nourishes, brightens, and rejuvenates the skin.\n'
              '2. Reduces dark spots, blemishes, and signs of aging.\n'
              '3. Provides a balanced, even-toned, and radiant complexion.\n'),
      ExpansionTileData(
        title: 'Products Used',
        content:
        'Contains mono-use cleanser, peel powder, peel lotion, massage cream, face pack, and serum.',
      ),
      ExpansionTileData(
          title: 'Aftercare Tips',
          content: '1. Stay hydrated and apply SPF regularly.\n'
              '2. Avoid harsh scrubs or chemical peels for 20 days.\n'
              '3. Avoid hot showers for 24 hours.\n'
              '4. Apply a sheet mask twice a week for best results.\n'),
      ExpansionTileData(
        title: 'Precautions',
        content:
        '1. Avoid using Bleach or De-Tan with this facial.\n'
            '2. Avoid for at least 15 days after laser hair removal or chemical peels.\n',
      ),
      ExpansionTileData(
        title: 'Recommended For',
        content:
        'Normal, dry, and combination skin types. Ideal for those with pigmentation, suntan, patchy skin, uneven skin tone, or acne scars.',
      ),
    ];

    List<ExpansionTileData> antiTanningData = [
      ExpansionTileData(
          title: 'Procedure',
          content:
          '1. Cleansing: Face is cleansed using Cleanser.\n'
              '2. Scrub: Mild exfoliation with Scrub, followed by blackhead & whitehead extraction.\n'
              '3. Massage Gel: Face massage for 5 minutes using Gel.\n'
              '4. Massage Cream: Cream is massaged onto the face, back, and neck for 10-15 minutes to relax the muscles.\n'
              '5. Face Pack: Face Pack application.\n'),
      ExpansionTileData(
          title: 'Benefits',
          content:
          '1. Lightens tanned skin.\n'
              '2. Brightens and evens out dull, patchy, and damaged skin.\n'
              '3. Turmeric oil brightens the skin.\n'
              '4. Tomato seed oil evens out skin tone and delays signs of aging.\n'),
      ExpansionTileData(
        title: 'Products Used',
        content:
        'Includes mono-use cleanser, scrub, massage gel, massage cream, and face pack.',
      ),
      ExpansionTileData(
          title: 'Aftercare Tips',
          content: '1. Keep hydrated and apply SPF regularly.\n'
              '2. Avoid harsh scrubs or chemical peels for 20 days.\n'
              '3. Avoid hot showers for 24 hours.\n'
              '4. Apply a sheet mask twice a week for best results.\n'),
      ExpansionTileData(
        title: 'Precautions',
        content:
        '1. Avoid for 15 days after laser hair removal.\n'
            '2. Avoid if you\'ve undergone chemical peel treatments.\n',
      ),
      ExpansionTileData(
        title: 'Recommended For',
        content: 'All skin types.',
      ),
    ];

    List<ExpansionTileData> o2StayYouthfulData = [
      ExpansionTileData(
          title: 'Procedure',
          content:
          '1. Cleansing: The face is cleansed with O2 face cleansing foam.\n'
              '2. Exfoliation: Gentle exfoliation using O2 Skin Buff, followed by blackhead and whitehead extraction.\n'
              '3. Toner: Applied to minimize pores and hydrate the skin.\n'
              '4. Massage: Dermo Melan Massage cream is applied to the face, neck, and back for 10-15 minutes to relax muscles.\n'
              '5. Face Pack: Derma Melan Mask applied, left for 2 minutes, then wiped off with wet hands and tissue.\n'
              '6. Peel-Off Gel Mask: Marine Algae Peel-Off Mask applied.\n'),
      ExpansionTileData(
          title: 'Benefits',
          content:
          '1. Promotes an even skin tone and luminous glow.\n'
              '2. Stimulates collagen production.\n'
              '3. Hydrates and fights signs of aging.\n'
              '4. Jojoba oil prevents flaky skin and enhances elasticity.\n'),
      ExpansionTileData(
        title: 'Products Used',
        content:
        'Includes face cleanser, exfoliator, toner, massage cream, face pack, and algae gel peel-off mask.',
      ),
      ExpansionTileData(
          title: 'Aftercare Tips',
          content: '1. Stay hydrated and apply SPF regularly.\n'
              '2. Avoid harsh scrubs or chemical peels for 20 days.\n'
              '3. Avoid hot showers for 24 hours.\n'),
      ExpansionTileData(
        title: 'Precautions',
        content:
        '1. Avoid bleach with this facial if you have dry, dull, or sensitive skin.\n'
            '2. Avoid for 15 days if you\'ve had laser hair removal or chemical peels.\n',
      ),
      ExpansionTileData(
        title: 'Recommended For',
        content:
        'Normal and dry skin types. Suitable for mature, dull, or dry skin, especially those over 30 years old.',
      ),
    ];

    List<Widget> packageCards = [
      Container(
        key: _sectionKeys['Gold Facial'],
        child: PackageCard(
          onAdd: () {
            Provider.of<CartData>(context, listen: false)
                .addPackage(context, 'Gold Facial', '279');
          },
          expansionData: goldFacialData,
          packageTitle: 'Gold Facial',
          packageDescription:
          'Cleanse, lactic peel, extractions, massage, serum, gold peel-off mask, and sunscreen for smooth, radiant skin.',
          packageHighlight:
          'Experience the luxurious Gold Facial, designed to reduce wrinkles, fine lines, and improve skin elasticity.',
          packagePrice: '₹279/-',
        ),
      ),
      SizedBox(height: 16),
      Container(
        key: _sectionKeys['Instant Glow Facial'],
        child: PackageCard(
          onAdd: () {
            Provider.of<CartData>(context, listen: false)
                .addPackage(context, 'Instant Glow Facial', '249');
          },
          expansionData: instantGlowFacialData,
          packageTitle: 'Instant Glow Facial',
          packageDescription:
          'Cleanse, exfoliate, extract, mask, and SPF for radiant skin. Finished with massage for relaxation.',
          packageHighlight:
          'The Instant Glow Facial is perfect for illuminating and unveiling a vibrant complexion.',
          packagePrice: '₹249/-',
        ),
      ),
      SizedBox(height: 16),
      Container(
        key: _sectionKeys['Threading'],
        child: PackageCard(
          onAdd: () {
            Provider.of<CartData>(context, listen: false)
                .addPackage(context, 'Threading', '199');
          },
          expansionData: threadingData,
          packageTitle: 'Threading',
          packageDescription:
          'Cleansing and applying talcum powder, gentle threading, and finish with a soothing post-service massage',
          packageHighlight: '',
          packagePrice: '₹199/-',
        ),
      ),
      SizedBox(height: 16),
      Container(
        key: _sectionKeys['Brightening Facial'],
        child: PackageCard(
          onAdd: () {
            Provider.of<CartData>(context, listen: false)
                .addPackage(context, 'Brightening Facial', '259');
          },
          expansionData: brighteningFacialData,
          packageTitle: 'Brightening Facial',
          packageDescription:
          'Cleanse, vitamin-C peel, extract, massage, lightening pack, and serum for radiant, even-toned skin.',
          packageHighlight:
          'The Brightening Facial nourishes, rejuvenates, and brightens the skin while reducing dark spots.',
          packagePrice: '₹259/-',
        ),
      ),
      SizedBox(height: 16),
      Container(
        key: _sectionKeys['Anti-Tanning Facial'],
        child: PackageCard(
          onAdd: () {
            Provider.of<CartData>(context, listen: false)
                .addPackage(context, 'Anti-Tanning Facial', '259');
          },
          expansionData: antiTanningData,
          packageTitle: 'Anti-Tanning Facial',
          packageDescription:
          'Cleanse, scrub, massage gel, cream, and face pack to lighten tanned skin and brighten dull patches.',
          packageHighlight:
          'The Anti-Tanning Facial lightens tanned skin and evens out skin tone.',
          packagePrice: '₹259/-',
        ),
      ),
      SizedBox(height: 16),
      Container(
        key: _sectionKeys['O2 Stay Youthful'],
        child: PackageCard(
          onAdd: () {
            Provider.of<CartData>(context, listen: false)
                .addPackage(context, 'O2 Stay Youthful', '259');
          },
          expansionData: o2StayYouthfulData,
          packageTitle: 'O2 Stay Youthful',
          packageDescription:
          'Cleanse, exfoliate, massage, and apply masks to boost collagen, hydrate, and even skin tone.',
          packageHighlight:
          'The O2 Stay Youthful offers an even skin tone and luminous glow while stimulating collagen production.',
          packagePrice: '₹259/-',
        ),
      ),
    ];

    if (isMobile) {
      return Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: WomenSalonServiceGrid(onServiceTap: _scrollToSection),
          ),
          Column(children: packageCards),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: isTablet ? 2 : 1,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: isTablet ? 400 : 350,
              ),
              child: WomenSalonServiceGrid(onServiceTap: _scrollToSection),
            ),
          ),
          SizedBox(width: isTablet ? 16 : 24),
          Expanded(
            flex: isTablet ? 3 : 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(children: packageCards),
            ),
          ),
        ],
      );
    }
  }

  Widget _buildMenSalonContent(bool isMobile, bool isTablet) {
    // Men's Salon expansion data
    List<ExpansionTileData> haircutMenData = [
      ExpansionTileData(
          title: 'What\'s Included',
          content:
          '1. Hair consultation for style preferences\n'
              '2. Precision haircut (classic, fade, buzz, or custom style)\n'
              '3. Tapering, trimming, and shaping\n'
              '4. Clean neckline and edges\n'
              '5. Complimentary wash and blow-dry\n'),
      ExpansionTileData(
          title: 'Equipment Used',
          content:
          '1. Professional-grade clippers, scissors, and trimmers\n'
              '2. Neck brush and combs for detailing\n'),
    ];

    List<ExpansionTileData> beardTrimmingData = [
      ExpansionTileData(
          title: 'Service Details',
          content:
          '1. Precision Trimming: Skilled barbers use precise techniques to shape your beard perfectly\n'
              '2. Personalized Styling: Choose from various styles including fades, sharp lines, and natural looks\n'
              '3. Quality Products: High-quality grooming products for great look and feel\n'
              '4. Relaxing Environment: Comfortable and welcoming atmosphere\n'),
      ExpansionTileData(
          title: 'Benefits',
          content:
          '1. Achieve a polished and well-groomed appearance\n'
              '2. Maintain your beard\'s health and style\n'
              '3. Boost your confidence with a fresh, tailored look\n'),
      ExpansionTileData(
        title: 'Duration',
        content: '30-45 minutes, depending on the complexity of the style.\n',
      ),
    ];

    List<ExpansionTileData> facialMenData = [
      ExpansionTileData(
          title: 'Benefits',
          content:
          '1. Brightens dull skin\n'
              '2. Reduces pigmentation\n'
              '3. Improves overall skin texture\n'),
      ExpansionTileData(
        title: 'What to Expect',
        content:
        'Experience a soothing and refreshing treatment that combines cleansing, exfoliation, and nourishing masks to unveil a brighter complexion.',
      ),
      ExpansionTileData(
        title: 'Duration',
        content: '60 minutes',
      ),
      ExpansionTileData(
        title: 'Aftercare',
        content:
        'Hydrate and protect your skin with sunscreen to maintain results and prevent further pigmentation.',
      ),
      ExpansionTileData(
        title: 'Ideal For',
        content: 'All skin types looking for a radiant glow and improved skin tone.',
      ),
    ];

    List<ExpansionTileData> detanMenData = [
      ExpansionTileData(
        title: 'Cleansing & Exfoliation',
        content:
        'Deep cleansing and gentle exfoliation to remove impurities, leaving your skin refreshed and revitalized.',
      ),
      ExpansionTileData(
        title: 'Mask & Treatment',
        content:
        'Nourishing mask and specialized treatments tailored for smooth and radiant skin on your face and neck.',
      ),
      ExpansionTileData(
        title: 'Benefits',
        content:
        '1. Deep Cleansing: Removes impurities and unclogs pores for a fresh, clean feel.\n'
            '2. Exfoliation: Gently removes dead skin cells, promoting cell regeneration for smooth, radiant skin.\n',
      ),
    ];

    List<ExpansionTileData> hairColorData = [
      ExpansionTileData(
          title: 'Service Details',
          content:
          '1. Color Consultation: Personalized advice from experienced stylists\n'
              '2. Professional Application: Flawless hair color application\n'
              '3. Hair Care Products: Premium products to maintain your color\n'
              '4. Post-Service Tips: Expert recommendations for home care\n'),
      ExpansionTileData(
          title: 'Why Choose Us?',
          content:
          'Experience a welcoming atmosphere and skilled professionals dedicated to achieving the best results for your hair color transformation!'),
    ];

    List<ExpansionTileData> beardColorData = [
      ExpansionTileData(
          title: 'Benefits',
          content:
          '1. Custom Color Selection: Choose from a wide range of shades to find the perfect match\n'
              '2. Long-Lasting Results: Premium products ensure vibrant color that lasts\n'
              '3. Expert Application: Skilled technicians apply color with precision\n'
              '4. Skin-Friendly Products: High-quality, hypoallergenic products that are gentle on the skin\n'
              '5. Consultation Available: Personalized advice on color selection and maintenance\n'),
      ExpansionTileData(
        title: 'What to Expect',
        content:
        '1. A relaxing environment where you can unwind while we transform your beard\n'
            '2. Professional guidance throughout the process to ensure your satisfaction\n',
      ),
      ExpansionTileData(
        title: 'Duration',
        content: 'Approximately 30-45 minutes, depending on your color choice and beard length.',
      ),
    ];

    List<Widget> packageCards = [
      Container(
        key: _sectionKeys['Haircut'],
        child: PackageCard(
          onAdd: () {
            Provider.of<CartData>(context, listen: false)
                .addPackage(context, 'Haircut for Men', '199');
          },
          expansionData: haircutMenData,
          packageTitle: 'Haircut for Men',
          packageDescription:
          'Professional men\'s haircut services for a sharp, stylish look tailored to your preferences.',
          packageHighlight:
          'Personalized grooming experience with consultation to achieve your ideal style.',
          packagePrice: '₹199/-',
        ),
      ),
      SizedBox(height: 16),
      Container(
        key: _sectionKeys['Shave & Beard'],
        child: PackageCard(
          onAdd: () {
            Provider.of<CartData>(context, listen: false)
                .addPackage(context, 'Beard Trimming & Styling', '99');
          },
          expansionData: beardTrimmingData,
          packageTitle: 'Beard Trimming & Styling',
          packageDescription:
          'Experience precision trimming and shaping with premium products.',
          packageHighlight:
          'Transform your look with professional beard trimming service.',
          packagePrice: '₹99/-',
        ),
      ),
      SizedBox(height: 16),
      Container(
        key: _sectionKeys['Facial'],
        child: PackageCard(
          onAdd: () {
            Provider.of<CartData>(context, listen: false)
                .addPackage(context, 'Skin Brightening Facial', '299');
          },
          expansionData: facialMenData,
          packageTitle: 'Skin Brightening Facial',
          packageDescription:
          'Revitalize your skin with our skin-brightening facial, designed to enhance your natural glow and boost radiance.',
          packageHighlight:
          'Transform your skin with rejuvenating treatment for enhanced radiance and even skin tone.',
          packagePrice: '₹299/-',
        ),
      ),
      SizedBox(height: 16),
      Container(
        key: _sectionKeys['Detan'],
        child: PackageCard(
          onAdd: () {
            Provider.of<CartData>(context, listen: false)
                .addPackage(context, 'Face and Neck Detan', '249');
          },
          expansionData: detanMenData,
          packageTitle: 'Face and Neck Detan',
          packageDescription:
          'Rejuvenate your skin with our Coffee Skin Hydrating Cleanup, for a radiant, refreshed, and deeply nourished glow.',
          packageHighlight:
          'Deep cleansing and exfoliation with nourishing mask treatment.',
          packagePrice: '₹249/-',
        ),
      ),
      SizedBox(height: 16),
      Container(
        key: _sectionKeys['Hair Color'],
        child: PackageCard(
          onAdd: () {
            Provider.of<CartData>(context, listen: false)
                .addPackage(context, 'Hair Color', '499');
          },
          expansionData: hairColorData,
          packageTitle: 'Hair Color',
          packageDescription:
          'Get personalized color advice, premium products, skilled application, and aftercare tips for vibrant, healthy hair color.',
          packageHighlight:
          'Transform your look with professional hair color services.',
          packagePrice: '₹499/-',
        ),
      ),
      SizedBox(height: 16),
      Container(
        key: _sectionKeys['Beard Color'],
        child: PackageCard(
          onAdd: () {
            Provider.of<CartData>(context, listen: false)
                .addPackage(context, 'Beard Color', '349');
          },
          expansionData: beardColorData,
          packageTitle: 'Beard Color',
          packageDescription:
          'Enhance your look with our beard coloring services, offering vibrant, long-lasting shades that complement your style perfectly.',
          packageHighlight:
          'Transform your look with professional beard coloring service.',
          packagePrice: '₹349/-',
        ),
      ),
    ];

    if (isMobile) {
      return Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: MenSalonServiceGrid(onServiceTap: _scrollToSection),
          ),
          Column(children: packageCards),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: isTablet ? 2 : 1,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: isTablet ? 400 : 350,
              ),
              child: MenSalonServiceGrid(onServiceTap: _scrollToSection),
            ),
          ),
          SizedBox(width: isTablet ? 16 : 24),
          Expanded(
            flex: isTablet ? 3 : 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(children: packageCards),
            ),
          ),
        ],
      );
    }
  }
}