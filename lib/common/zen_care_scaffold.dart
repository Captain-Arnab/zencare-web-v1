import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zencare/common/appbar.dart';
import 'package:zencare/features/auth/login_page.dart';
import 'package:zencare/services/auth_service.dart';

/// Wraps [body] in a Scaffold with [CustomAppBar].
/// On Android: horizontal bottom nav (UrbanClap-style) with Home, Services, Contact Us, Profile/Login; no drawer.
/// On web/other: optional drawer + app bar (bottom sheet menu on small screens).
class ZenCareScaffold extends StatefulWidget {
  const ZenCareScaffold({super.key, required this.body, this.backgroundColor});

  final Widget body;
  final Color? backgroundColor;

  @override
  State<ZenCareScaffold> createState() => _ZenCareScaffoldState();
}

class _ZenCareScaffoldState extends State<ZenCareScaffold> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final token = await AuthService.getToken();
    if (mounted) setState(() => _isLoggedIn = token != null && token.isNotEmpty);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkAuth();
  }

  static int _selectedIndexFromRoute(String? name) {
    if (name == null) return 0;
    if (name == '/home') return 0;
    if (name == '/services') return 1;
    if (name == '/contact-us') return 2;
    if (name == '/profile') return 3;
    if (name.startsWith('/ac-services') ||
        name.startsWith('/carpenter-service') ||
        name.startsWith('/refrigerator-services') ||
        name.startsWith('/cleaning') ||
        name.startsWith('/salon') ||
        name.startsWith('/pest-control') ||
        name.startsWith('/washing-machine') ||
        name.startsWith('/chimney-repair') ||
        name.startsWith('/water-purifier')) return 1;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final isAndroid = defaultTargetPlatform == TargetPlatform.android;

    if (isAndroid) {
      final routeName = ModalRoute.of(context)?.settings.name;
      final currentIndex = _selectedIndexFromRoute(routeName);

      return Scaffold(
        backgroundColor: widget.backgroundColor,
        appBar: CustomAppBar(hasDrawer: false, hideMenuButton: true),
        body: widget.body,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex.clamp(0, 3),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blue.shade800,
          unselectedItemColor: Colors.grey.shade600,
          onTap: (index) {
            switch (index) {
              case 0:
                if (routeName != '/home') Navigator.pushReplacementNamed(context, '/home');
                break;
              case 1:
                if (routeName != '/services') Navigator.pushReplacementNamed(context, '/services');
                break;
              case 2:
                if (routeName != '/contact-us') Navigator.pushReplacementNamed(context, '/contact-us');
                break;
              case 3:
                if (_isLoggedIn) {
                  if (routeName != '/profile') Navigator.pushReplacementNamed(context, '/profile');
                } else {
                  showDialog(context: context, builder: (_) => LoginDialog()).then((_) => _checkAuth());
                }
                break;
            }
          },
          items: [
            const BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Home'),
            const BottomNavigationBarItem(icon: Icon(Icons.build_outlined), activeIcon: Icon(Icons.build), label: 'Services'),
            const BottomNavigationBarItem(icon: Icon(Icons.contact_mail_outlined), activeIcon: Icon(Icons.contact_mail), label: 'Contact Us'),
            BottomNavigationBarItem(
              icon: Icon(_isLoggedIn ? Icons.person_outline : Icons.login_outlined),
              activeIcon: Icon(_isLoggedIn ? Icons.person : Icons.login),
              label: _isLoggedIn ? 'Profile' : 'Login',
            ),
          ],
        ),
      );
    }

    // Web/other: no drawer; app bar has menu icon that opens bottom sheet
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      appBar: CustomAppBar(hasDrawer: false),
      body: widget.body,
    );
  }
}
