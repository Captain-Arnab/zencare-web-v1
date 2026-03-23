import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:zencare/common/footer.dart';
import 'package:zencare/common/zen_care_scaffold.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ---------------------- CONTACT US ----------------------
class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  late double screenWidth;
  late double screenHeight;

  bool _isMobile(BuildContext context) =>
      defaultTargetPlatform == TargetPlatform.android ||
      MediaQuery.of(context).size.width < 768;

  bool _isTablet(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) return false;
    double width = MediaQuery.of(context).size.width;
    return width >= 768 && width < 1024;
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return ZenCareScaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SafeArea(child: header(context)),
            SafeArea(child: whyChooseUs(context)),
            Footer(),
          ],
        ),
      ),
    );
  }

  Widget whyChooseUs(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('assets/img/banner.png'),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
        vertical:
            _isMobile(context) ? screenHeight * 0.03 : screenHeight * 0.05,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal:
                  _isMobile(context) ? screenWidth * 0.02 : screenWidth * 0.07,
              vertical: _isMobile(context)
                  ? screenHeight * 0.03
                  : screenHeight * 0.05,
            ),
            child: _isMobile(context)
                ? Column(
                    children: [
                      contactInfoBox(
                        Icons.location_on_rounded,
                        'Address',
                        'No 4,Near by RTO Office, YSR Nagar,\nDhone, Andhra Pradesh, India - 518222',
                        width: screenWidth * 0.9,
                      ),
                      const SizedBox(height: 20),
                      contactInfoBox(
                        Icons.email_outlined,
                        'Mail',
                        'Zencareservices@gmail.com',
                        link: 'mailto:zencareservices@gmail.com',
                        width: screenWidth * 0.9,
                      ),
                      const SizedBox(height: 20),
                      contactInfoBox(
                        Icons.phone_in_talk_rounded,
                        'Phone Number',
                        '8179550262',
                        link: 'tel:8179550262',
                        isLink: true,
                        width: screenWidth * 0.9,
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: contactInfoBox(
                          Icons.location_on_rounded,
                          'Address',
                          'No 4,Near by RTO Office, YSR Nagar,\nDhone, Andhra Pradesh, India - 518222',
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: contactInfoBox(
                          Icons.email_outlined,
                          'Mail',
                          'Zencareservices@gmail.com',
                          link: 'mailto:zencareservices@gmail.com',
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: contactInfoBox(
                          Icons.phone_in_talk_rounded,
                          'Phone Number',
                          '8179550262',
                          link: 'tel:8179550262',
                          isLink: true,
                        ),
                      ),
                    ],
                  ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: _isMobile(context)
                    ? screenWidth * 0.02
                    : screenWidth * 0.07,
                vertical: screenHeight * 0.02,
              ),
              child: SizedBox(
                height: _isMobile(context) ? 250 : 300,
                child: IframeWidget(
                  url:
                      "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d96873.74833064685!2d-74.02739776241977!3d40.64521471554788!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x89c25c7b17750973%3A0xc8c5384fddf19cc0!2sWeeksville%20Heritage%20Center!5e0!3m2!1sen!2sbd!4v1694533886005!5m2!1sen!2sbd",
                ),
              ),
            ),
          ),
          SizedBox(height: _isMobile(context) ? 30 : 50),
        ],
      ),
    );
  }

  Widget header(BuildContext context) {
    return Container(
      width: screenWidth,
      color: Colors.grey[200],
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical:
              _isMobile(context) ? screenHeight * 0.03 : screenHeight * 0.05,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: _isMobile(context) ? 10.0 : 20.0,
              ),
              child: Column(
                children: [
                  Text(
                    'Contact Us',
                    style: _isMobile(context)
                        ? Theme.of(context).textTheme.headlineLarge
                        : Theme.of(context).textTheme.displayLarge,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Home > Contact Us',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------- IFRAME / MAP WIDGET ----------------------
class IframeWidget extends StatefulWidget {
  final String url;
  const IframeWidget({super.key, required this.url});

  @override
  State<IframeWidget> createState() => _IframeWidgetState();
}

class _IframeWidgetState extends State<IframeWidget> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      // Initialize WebViewController for mobile platforms
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadRequest(Uri.parse(widget.url));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      // ---------------------- WEB ----------------------
      return _buildWebView();
    } else {
      // ---------------------- ANDROID / iOS ----------------------
      return WebViewWidget(controller: _controller);
    }
  }

  Widget _buildWebView() {
    // This will only be called on web platform
    // ignore: undefined_prefixed_name
    return HtmlElementView(
      viewType: 'iframe-${widget.url.hashCode}',
      onPlatformViewCreated: (int id) {
        // Web-specific initialization if needed
      },
    );
  }
}

// ---------------------- CONTACT INFO BOX ----------------------
Widget contactInfoBox(
  IconData icon,
  String title,
  String subtitle, {
  bool isLink = false,
  String link = '',
  double? width,
  double? height,
}) {
  bool isMobileContext = width != null;

  return Container(
    width: width,
    height: height,
    padding: EdgeInsets.all(isMobileContext ? 16.0 : 8.0),
    decoration: isMobileContext
        ? BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          )
        : null,
    child: isMobileContext
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.green.shade700),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 14,
                  color: isLink ? Colors.blue : Colors.black87,
                ),
              ),
            ],
          )
        : Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(icon, size: 50, color: Colors.green.shade700),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 16,
                        color: isLink ? Colors.blue : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
  );
}
