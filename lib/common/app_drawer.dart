import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zencare/core/api_config.dart';
import 'package:zencare/features/auth/login_page.dart';
import 'package:zencare/features/auth/register_page.dart';
import 'package:zencare/features/controller.dart';
import 'package:zencare/services/auth_service.dart';

/// Android-style navigation drawer (slides from left). Used only on Android.
class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool isLoggedIn = false;
  String userName = "";
  String? userPhotoUrl;

  @override
  void initState() {
    super.initState();
    _fetchAuth();
  }

  Future<void> _fetchAuth() async {
    final token = await AuthService.getToken();
    if (token != null && token.isNotEmpty) {
      final session = await AuthService.checkSession();
      if (session != null && mounted) {
        final profile = session['user'] as Map<String, dynamic>? ?? await AuthService.getProfile();
        String? photo = profile?['photo']?.toString();
        if (photo != null && photo.isNotEmpty && !photo.startsWith('http')) {
          photo = '${ApiConfig.baseUrlForFiles}/${photo.replaceFirst(RegExp(r'^/'), '')}';
        }
        setState(() {
          isLoggedIn = true;
          userName = session['userName']?.toString() ?? 'Guest';
          userPhotoUrl = photo;
        });
        return;
      }
      await AuthService.logout();
    }
    if (mounted) {
      setState(() {
        isLoggedIn = false;
        userName = 'Guest';
        userPhotoUrl = null;
      });
    }
  }

  void _closeAndNavigate(String routeName, {bool replace = false}) {
    Navigator.pop(context);
    if (replace) {
      Navigator.pushReplacementNamed(context, routeName);
    } else {
      Navigator.pushNamed(context, routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.only(top: 24),
        children: [
          if (isLoggedIn)
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue.shade50),
              child: Row(
                children: [
                  userPhotoUrl != null && userPhotoUrl!.isNotEmpty
                      ? CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(userPhotoUrl!),
                          onBackgroundImageError: (_, __) {},
                        )
                      : CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.blue.shade800,
                          child: Text(
                            userName.isNotEmpty ? userName[0].toUpperCase() : 'U',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Welcome Back!',
                          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          userName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => _closeAndNavigate('/home', replace: true),
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About Us'),
            onTap: () => _closeAndNavigate('/about-us', replace: true),
          ),
          ExpansionTile(
            leading: const Icon(Icons.build),
            title: const Text('Services'),
            children: [
              ListTile(title: const Text('AC Service'), onTap: () => _closeAndNavigate('/ac-services', replace: true)),
              ListTile(title: const Text('Carpenter Service'), onTap: () => _closeAndNavigate('/carpenter-service', replace: true)),
              ListTile(title: const Text('Refrigerator Repair'), onTap: () => _closeAndNavigate('/refrigerator-services', replace: true)),
              ListTile(title: const Text('Home Cleaning'), onTap: () => _closeAndNavigate('/cleaning', replace: true)),
              ListTile(title: const Text('Salon'), onTap: () => _closeAndNavigate('/salon', replace: true)),
              ListTile(title: const Text('Pest Control'), onTap: () => _closeAndNavigate('/pest-control', replace: true)),
              ListTile(title: const Text('Washing Machine Repair'), onTap: () => _closeAndNavigate('/washing-machine', replace: true)),
              ListTile(title: const Text('Chimney Repair'), onTap: () => _closeAndNavigate('/chimney-repair', replace: true)),
              ListTile(title: const Text('Water Purifier'), onTap: () => _closeAndNavigate('/water-purifier', replace: true)),
            ],
          ),
          ListTile(
            leading: const Icon(Icons.contact_mail),
            title: const Text('Contact Us'),
            onTap: () => _closeAndNavigate('/contact-us', replace: true),
          ),
          const Divider(),
          if (!isLoggedIn) ...[
            ListTile(
              leading: const Icon(Icons.login, color: Colors.blue),
              title: const Text('Sign In', style: TextStyle(fontWeight: FontWeight.w600)),
              onTap: () {
                Navigator.pop(context);
                showDialog(context: context, builder: (_) => LoginDialog());
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_add, color: Colors.blue),
              title: const Text('Sign Up', style: TextStyle(fontWeight: FontWeight.w600)),
              onTap: () {
                Navigator.pop(context);
                showDialog(context: context, builder: (_) => RegisterDialog());
              },
            ),
          ] else ...[
            ListTile(
              leading: Icon(Icons.person, color: Colors.blue.shade800),
              title: const Text('My Profile', style: TextStyle(fontWeight: FontWeight.w600)),
              onTap: () => _closeAndNavigate('/profile'),
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart_outlined, color: Colors.blue.shade800),
              title: const Text('Cart', style: TextStyle(fontWeight: FontWeight.w600)),
              onTap: () => _closeAndNavigate('/shopping-cart'),
            ),
            ListTile(
              leading: Icon(Icons.history, color: Colors.blue.shade800),
              title: const Text('Order History', style: TextStyle(fontWeight: FontWeight.w600)),
              onTap: () => _closeAndNavigate('/order-history'),
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red.shade700),
              title: Text('Logout', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.red.shade700)),
              onTap: () async {
                Navigator.pop(context);
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Confirm Logout'),
                    content: const Text('Are you sure you want to logout?'),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(ctx, true),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade700),
                        child: const Text('Logout', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                );
                if (confirm == true) {
                  await AuthService.logout();
                  if (context.mounted) Provider.of<CartData>(context, listen: false).clearCart();
                  if (mounted) setState(() { isLoggedIn = false; userName = 'Guest'; });
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Logged out successfully'), backgroundColor: Colors.green, behavior: SnackBarBehavior.floating),
                    );
                    Navigator.pushReplacementNamed(context, '/home');
                  }
                }
              },
            ),
          ],
        ],
      ),
    );
  }
}
