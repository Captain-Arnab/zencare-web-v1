import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zencare/features/auth/login_page.dart';
import 'package:zencare/core/api_config.dart';
import 'package:zencare/features/auth/register_page.dart';
import 'package:zencare/features/controller.dart';
import 'package:zencare/services/auth_service.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class _CustomAppBarState extends State<CustomAppBar> {
  String? selectedService;
  final GlobalKey _servicesKey = GlobalKey();
  bool isLoggedIn = false;
  String userName = "";
  String? userPhotoUrl;

  // Responsive breakpoints
  bool get isMobile => MediaQuery.of(context).size.width < 600;
  bool get isTablet =>
      MediaQuery.of(context).size.width >= 600 &&
      MediaQuery.of(context).size.width < 1024;
  bool get isDesktop => MediaQuery.of(context).size.width >= 1024;

  void _showMenu(GlobalKey key, List<PopupMenuEntry<String>> items) {
    final RenderBox renderBox =
        key.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);

    showMenu<String>(
      surfaceTintColor: Colors.white,
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy + renderBox.size.height,
        position.dx + renderBox.size.width,
        position.dy + renderBox.size.height,
      ),
      items: items,
    ).then((value) {
      if (value != null) {
        setState(() {
          selectedService = value;
        });
      }
    });
  }

  void _showMobileDrawer() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Expanded(
              child: ListView(
                controller: scrollController,
                padding: const EdgeInsets.all(16),
                children: [
                  // User Profile Section (if logged in)
                  if (isLoggedIn) ...[
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
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
                                    userName.isNotEmpty
                                        ? userName[0].toUpperCase()
                                        : 'U',
                                    style: TextStyle(
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
                              children: [
                                Text(
                                  'Welcome Back!',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  userName,
                                  style: TextStyle(
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
                    const SizedBox(height: 16),
                    const Divider(),
                  ],

                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Home'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.info),
                    title: const Text('About Us'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/about-us');
                    },
                  ),
                  ExpansionTile(
                    leading: const Icon(Icons.build),
                    title: const Text('Services'),
                    children: [
                      ListTile(
                        title: const Text('AC Service'),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(
                              context, '/ac-services');
                        },
                      ),
                      ListTile(
                        title: const Text('Carpenter Service'),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(
                              context, '/carpenter-service');
                        },
                      ),
                      ListTile(
                        title: const Text('Refrigerator Repair'),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(
                              context, '/refrigerator-services');
                        },
                      ),
                      ListTile(
                        title: const Text('Home Cleaning'),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(context, '/cleaning');
                        },
                      ),
                      ListTile(
                        title: const Text('Salon'),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(context, '/salon');
                        },
                      ),
                      ListTile(
                        title: const Text('Pest Control'),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(
                              context, '/pest-control');
                        },
                      ),
                      ListTile(
                        title: const Text('Washing Machine Repair'),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(
                              context, '/washing-machine');
                        },
                      ),
                      ListTile(
                        title: const Text('Chimney Repair'),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(
                              context, '/chimney-repair');
                        },
                      ),
                      ListTile(
                        title: const Text('Water Purifier'),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(
                              context, '/water-purifier');
                        },
                      ),
                    ],
                  ),
                  ListTile(
                    leading: const Icon(Icons.contact_mail),
                    title: const Text('Contact Us'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/contact-us');
                    },
                  ),
                  const Divider(),

                  // Authentication Section
                  if (!isLoggedIn) ...[
                    ListTile(
                      leading: const Icon(Icons.login, color: Colors.blue),
                      title: const Text('Sign In',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      onTap: () {
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return LoginDialog();
                          },
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.person_add, color: Colors.blue),
                      title: const Text('Sign Up',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      onTap: () {
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return RegisterDialog();
                          },
                        );
                      },
                    ),
                  ] else ...[
                    ListTile(
                      leading: Icon(Icons.person, color: Colors.blue.shade800),
                      title: const Text('My Profile',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/profile');
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.shopping_cart_outlined, color: Colors.blue.shade800),
                      title: const Text('Cart', style: TextStyle(fontWeight: FontWeight.w600)),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/shopping-cart');
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.history, color: Colors.blue.shade800),
                      title: const Text('Order History', style: TextStyle(fontWeight: FontWeight.w600)),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/order-history');
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.logout, color: Colors.red.shade700),
                      title: Text(
                        'Logout',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.red.shade700,
                        ),
                      ),
                      onTap: () async {
                        Navigator.pop(context); // Close drawer first

                        // Show confirmation dialog
                        bool? confirmLogout = await showDialog<bool>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              title: Row(
                                children: [
                                  Icon(Icons.logout,
                                      color: Colors.red.shade700, size: 24),
                                  const SizedBox(width: 10),
                                  Text('Confirm Logout',
                                      style: TextStyle(fontSize: 18)),
                                ],
                              ),
                              content: Text(
                                'Are you sure you want to logout?',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey.shade700),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 14),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red.shade700,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  child: Text(
                                    'Logout',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ),
                              ],
                            );
                          },
                        );

                        if (confirmLogout == true) {
                          await AuthService.logout();
                          if (context.mounted) {
                            Provider.of<CartData>(context, listen: false).clearCart();
                          }
                          if (mounted) {
                            setState(() {
                              isLoggedIn = false;
                              userName = 'Guest';
                            });
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Logged out successfully'),
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 2),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          );

                          Navigator.pushReplacementNamed(context, '/home');
                        }
                      },
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
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

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 0,
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: EdgeInsets.only(
          top: 10.0,
          left: isMobile ? 8.0 : 16.0,
          right: isMobile ? 8.0 : 16.0,
        ),
        child: _buildResponsiveAppBar(),
      ),
    );
  }

  Widget _buildResponsiveAppBar() {
    if (isMobile) {
      return _buildMobileAppBar();
    } else if (isTablet) {
      return _buildTabletAppBar();
    } else {
      return _buildDesktopAppBar();
    }
  }

  Widget _buildMobileAppBar() {
    return Row(
      children: [
        // Logo
        InkWell(
          hoverColor: Colors.transparent,
          onTap: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
          child: Image.asset(
            'assets/img/logos.jpg',
            height: 70,
          ),
        ),
        const Spacer(),

        // Cart Icon
        Consumer<CartData>(
          builder: (context, cartData, child) {
            return IconButton(
              icon: Badge(
                label: Text(cartData.cartCount.toString()),
                child: const Icon(Icons.shopping_cart, size: 20),
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/shopping-cart');
              },
            );
          },
        ),

        // Menu Button
        IconButton(
          icon: const Icon(Icons.menu, size: 24),
          onPressed: _showMobileDrawer,
        ),
      ],
    );
  }

  Widget _buildTabletAppBar() {
    return Row(
      children: [
        // Logo
        InkWell(
          hoverColor: Colors.transparent,
          onTap: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Image.asset(
              'assets/img/logos.jpg',
              height: 85,
            ),
          ),
        ),

        // Navigation Items
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildNavItem('Home',
                  () => Navigator.pushReplacementNamed(context, '/home')),
              const SizedBox(width: 20),
              _buildNavItem('About Us',
                  () => Navigator.pushReplacementNamed(context, '/about-us')),
              const SizedBox(width: 20),
              _buildServicesButton(),
              const SizedBox(width: 20),
              _buildNavItem('Contact Us',
                  () => Navigator.pushReplacementNamed(context, '/contact-us')),
            ],
          ),
        ),

        // Right Section
        _buildRightSection(compact: true),
      ],
    );
  }

  Widget _buildDesktopAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Logo
        InkWell(
          hoverColor: Colors.transparent,
          onTap: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Image.asset(
              'assets/img/logos.jpg',
              height: 100,
            ),
          ),
        ),

        // Center Section
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 25),
              _buildNavItem('Home',
                  () => Navigator.pushReplacementNamed(context, '/home')),
              const SizedBox(width: 35),
              _buildNavItem('About Us',
                  () => Navigator.pushReplacementNamed(context, '/about-us')),
              const SizedBox(width: 25),
              _buildServicesButton(),
              const SizedBox(width: 16),
              _buildNavItem('Contact Us',
                  () => Navigator.pushReplacementNamed(context, '/contact-us')),
            ],
          ),
        ),

        // Right Section
        _buildRightSection(compact: false),
      ],
    );
  }

  Widget _buildNavItem(String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      hoverColor: Colors.transparent,
      child: Text(
        title,
        style: isMobile
            ? Theme.of(context).textTheme.bodyMedium
            : Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }

  Widget _buildServicesButton() {
    // Use PopupMenuButton for all screen sizes - it handles clicks and dismissal properly
    if (isDesktop) {
      // For desktop, show on hover but allow proper dismissal
      return PopupMenuButton<String>(
        key: _servicesKey,
        offset: const Offset(0, 40),
        surfaceTintColor: Colors.white,
        tooltip: '',
        onSelected: (value) {
          // Navigation is already handled in onTap of PopupMenuItem
        },
        itemBuilder: (context) => [
          PopupMenuItem(
            onTap: () =>
                Navigator.pushReplacementNamed(context, '/ac-services'),
            value: 'ac_service',
            child: Text('AC Service',
                style: Theme.of(context).textTheme.bodyMedium),
          ),
          PopupMenuItem(
            onTap: () =>
                Navigator.pushReplacementNamed(context, '/carpenter-service'),
            value: 'carpenter_service',
            child: Text('Carpenter Service',
                style: Theme.of(context).textTheme.bodyMedium),
          ),
          PopupMenuItem(
            onTap: () => Navigator.pushReplacementNamed(
                context, '/refrigerator-services'),
            value: 'refrigerator',
            child: Text('Refrigerator Repair',
                style: Theme.of(context).textTheme.bodyMedium),
          ),
          PopupMenuItem(
            onTap: () => Navigator.pushReplacementNamed(context, '/cleaning'),
            value: 'home_cleaning',
            child: Text('Home Cleaning',
                style: Theme.of(context).textTheme.bodyMedium),
          ),
          PopupMenuItem(
            onTap: () => Navigator.pushReplacementNamed(context, '/salon'),
            value: 'salon',
            child: Text('Salon', style: Theme.of(context).textTheme.bodyMedium),
          ),
          PopupMenuItem(
            onTap: () =>
                Navigator.pushReplacementNamed(context, '/pest-control'),
            value: 'pest_control',
            child: Text('Pest Control',
                style: Theme.of(context).textTheme.bodyMedium),
          ),
          PopupMenuItem(
            onTap: () =>
                Navigator.pushReplacementNamed(context, '/washing-machine'),
            value: 'washing_machine',
            child: Text('Washing Machine Repair',
                style: Theme.of(context).textTheme.bodyMedium),
          ),
          PopupMenuItem(
            onTap: () =>
                Navigator.pushReplacementNamed(context, '/chimney-repair'),
            value: 'chimney_repair',
            child: Text('Chimney Repair',
                style: Theme.of(context).textTheme.bodyMedium),
          ),
          PopupMenuItem(
            onTap: () =>
                Navigator.pushReplacementNamed(context, '/water-purifier'),
            value: 'water_purifier',
            child: Text('Water Purifier',
                style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Services',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.keyboard_arrow_down_outlined,
              color: Colors.black,
              size: 20,
            ),
          ],
        ),
      );
    } else {
      // For tablet and mobile, use PopupMenuButton with proper styling
      return PopupMenuButton<String>(
        key: _servicesKey,
        offset: const Offset(0, 40),
        surfaceTintColor: Colors.white,
        tooltip: '',
        onSelected: (value) {
          // Navigation is already handled in onTap of PopupMenuItem
        },
        itemBuilder: (context) => [
          PopupMenuItem(
            onTap: () =>
                Navigator.pushReplacementNamed(context, '/ac-services'),
            value: 'ac_service',
            child: Text('AC Service',
                style: Theme.of(context).textTheme.bodyMedium),
          ),
          PopupMenuItem(
            onTap: () =>
                Navigator.pushReplacementNamed(context, '/carpenter-service'),
            value: 'carpenter_service',
            child: Text('Carpenter Service',
                style: Theme.of(context).textTheme.bodyMedium),
          ),
          PopupMenuItem(
            onTap: () => Navigator.pushReplacementNamed(
                context, '/refrigerator-services'),
            value: 'refrigerator',
            child: Text('Refrigerator Repair',
                style: Theme.of(context).textTheme.bodyMedium),
          ),
          PopupMenuItem(
            onTap: () => Navigator.pushReplacementNamed(context, '/cleaning'),
            value: 'home_cleaning',
            child: Text('Home Cleaning',
                style: Theme.of(context).textTheme.bodyMedium),
          ),
          PopupMenuItem(
            onTap: () => Navigator.pushReplacementNamed(context, '/salon'),
            value: 'salon',
            child: Text('Salon', style: Theme.of(context).textTheme.bodyMedium),
          ),
          PopupMenuItem(
            onTap: () =>
                Navigator.pushReplacementNamed(context, '/pest-control'),
            value: 'pest_control',
            child: Text('Pest Control',
                style: Theme.of(context).textTheme.bodyMedium),
          ),
          PopupMenuItem(
            onTap: () =>
                Navigator.pushReplacementNamed(context, '/washing-machine'),
            value: 'washing_machine',
            child: Text('Washing Machine Repair',
                style: Theme.of(context).textTheme.bodyMedium),
          ),
          PopupMenuItem(
            onTap: () =>
                Navigator.pushReplacementNamed(context, '/chimney-repair'),
            value: 'chimney_repair',
            child: Text('Chimney Repair',
                style: Theme.of(context).textTheme.bodyMedium),
          ),
          PopupMenuItem(
            onTap: () =>
                Navigator.pushReplacementNamed(context, '/water-purifier'),
            value: 'water_purifier',
            child: Text('Water Purifier',
                style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Services',
              style: isMobile
                  ? Theme.of(context).textTheme.bodyMedium
                  : Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down_outlined,
              color: Colors.black,
              size: isMobile ? 16 : 20,
            ),
          ],
        ),
      );
    }
  }

  Widget _buildProfileAvatar({required bool compact}) {
    final radius = compact ? 16.0 : 18.0;
    final fontSize = compact ? 14.0 : 16.0;
    if (userPhotoUrl != null && userPhotoUrl!.isNotEmpty) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: NetworkImage(userPhotoUrl!),
        onBackgroundImageError: (_, __) {},
        child: userName.isEmpty ? Text('?', style: TextStyle(color: Colors.white, fontSize: fontSize, fontWeight: FontWeight.w600)) : null,
      );
    }
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.blue.shade800,
      child: Text(
        userName.isNotEmpty ? userName[0].toUpperCase() : 'U',
        style: TextStyle(color: Colors.white, fontSize: fontSize, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildRightSection({required bool compact}) {
    return Padding(
      padding: EdgeInsets.only(right: compact ? 16.0 : 50.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Consumer<CartData>(
            builder: (context, cartData, child) {
              return IconButton(
                icon: Badge(
                  label: Text(cartData.cartCount.toString()),
                  child: Icon(Icons.shopping_cart, size: compact ? 20 : 24),
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/shopping-cart');
                },
              );
            },
          ),
          if (!compact) const SizedBox(width: 10),
          if (!isLoggedIn) ...[
            if (!compact) ...[
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return LoginDialog();
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  padding: EdgeInsets.symmetric(horizontal: compact ? 8 : 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.lock_outline,
                        color: Colors.black, size: compact ? 12 : 15),
                    const SizedBox(width: 5),
                    Text(
                      'Sign In',
                      style: compact
                          ? Theme.of(context).textTheme.bodySmall
                          : Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return RegisterDialog();
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade800,
                  padding: EdgeInsets.symmetric(horizontal: compact ? 8 : 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.person,
                        color: Colors.white, size: compact ? 12 : 15),
                    const SizedBox(width: 5),
                    Text(
                      'Sign Up',
                      style: (compact
                              ? Theme.of(context).textTheme.bodySmall
                              : Theme.of(context).textTheme.bodyMedium)!
                          .copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ] else ...[
              // Tablet - show icons only
              IconButton(
                icon: const Icon(Icons.login, size: 20),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return LoginDialog();
                    },
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.person_add, size: 20),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return RegisterDialog();
                    },
                  );
                },
              ),
            ],
          ] else ...[
            // User is logged in - clean and simple dropdown
            PopupMenuButton<String>(
              offset: const Offset(0, 55),
              surfaceTintColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 3,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: compact ? 10 : 12,
                  vertical: compact ? 8 : 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildProfileAvatar(compact: compact),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Howdy!",
                          style: TextStyle(
                            fontSize: compact ? 10 : 11,
                            color: Colors.grey.shade600,
                            height: 1.2,
                          ),
                        ),
                        Text(
                          userName.length > 12
                              ? '${userName.substring(0, 12)}...'
                              : userName,
                          style: TextStyle(
                            fontSize: compact ? 13 : 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.keyboard_arrow_down,
                      size: compact ? 18 : 20,
                      color: Colors.grey.shade600,
                    ),
                  ],
                ),
              ),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'profile',
                  height: 48,
                  child: Row(
                    children: [
                      Icon(Icons.person_outline,
                          size: 20, color: Colors.blue.shade800),
                      const SizedBox(width: 12),
                      Text(
                        'My Profile',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'cart',
                  height: 48,
                  child: Row(
                    children: [
                      Icon(Icons.shopping_cart_outlined,
                          size: 20, color: Colors.blue.shade800),
                      const SizedBox(width: 12),
                      Text(
                        'Cart',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'order_history',
                  height: 48,
                  child: Row(
                    children: [
                      Icon(Icons.history,
                          size: 20, color: Colors.blue.shade800),
                      const SizedBox(width: 12),
                      Text(
                        'Order History',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const PopupMenuDivider(height: 1),
                PopupMenuItem(
                  value: 'logout',
                  height: 48,
                  child: Row(
                    children: [
                      Icon(Icons.logout, size: 20, color: Colors.red.shade700),
                      const SizedBox(width: 12),
                      Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.red.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              onSelected: (value) async {
                if (value == 'logout') {
                  // Simple confirmation dialog
                  bool? confirmLogout = await showDialog<bool>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        title: Row(
                          children: [
                            Icon(Icons.logout,
                                color: Colors.red.shade700, size: 24),
                            const SizedBox(width: 10),
                            Text('Confirm Logout',
                                style: TextStyle(fontSize: 18)),
                          ],
                        ),
                        content: Text(
                          'Are you sure you want to logout?',
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade700),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                  color: Colors.grey.shade600, fontSize: 14),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.shade700,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            child: Text(
                              'Logout',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                        ],
                      );
                    },
                  );

                  if (confirmLogout == true) {
                    await AuthService.logout();
                    if (context.mounted) {
                      Provider.of<CartData>(context, listen: false).clearCart();
                    }
                    if (mounted) {
                      setState(() {
                        isLoggedIn = false;
                        userName = 'Guest';
                      });
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Logged out successfully'),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 2),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    );

                    Navigator.pushReplacementNamed(context, '/home');
                  }
                } else if (value == 'profile') {
                  Navigator.pushNamed(context, '/profile');
                } else if (value == 'cart') {
                  Navigator.pushNamed(context, '/shopping-cart');
                } else if (value == 'order_history') {
                  Navigator.pushNamed(context, '/order-history');
                }
              },
            ),
          ],
        ],
      ),
    );
  }

  void _showLoginPrompt() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width: 300,
          child: AlertDialog(
            title: Text('Login Required',
                style: Theme.of(context).textTheme.displayMedium),
            content: Text('Please log in to place your order.',
                style: Theme.of(context).textTheme.displayMedium),
            actions: [
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return LoginDialog();
                    },
                  );
                },
                child: Text('Login',
                    style: Theme.of(context).textTheme.displayMedium),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.pink,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel',
                    style: Theme.of(context).textTheme.displayMedium),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchData(); // Refresh user data when returning to page
  }
}
