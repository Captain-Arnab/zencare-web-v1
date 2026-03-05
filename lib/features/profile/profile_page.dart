import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zencare/common/appbar.dart';
import 'package:zencare/common/footer.dart';
import 'package:zencare/core/api_config.dart';
import 'package:zencare/services/auth_service.dart';

/// Profile page: shows full user profile (from login cache or fetch_user), allows refresh and update (including password).
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? _profile;
  bool _loading = true;
  bool _refreshing = false;
  bool _saving = false;
  String? _error;

  bool get _isMobile => MediaQuery.of(context).size.width < 768;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    var profile = await AuthService.getProfile();
    if (profile == null) {
      profile = await AuthService.fetchUser();
    }
    if (mounted) {
      setState(() {
        _profile = profile;
        _loading = false;
        if (profile == null) _error = 'Could not load profile.';
      });
    }
  }

  Future<void> _refreshProfile() async {
    setState(() => _refreshing = true);
    final profile = await AuthService.fetchUser();
    if (mounted) {
      setState(() {
        _profile = profile;
        _refreshing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, size: 64, color: Colors.grey.shade400),
                        const SizedBox(height: 16),
                        Text(
                          _error!,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey.shade700),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: _loadProfile,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade800,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SafeArea(
                        bottom: false,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: _isMobile ? 16 : 50,
                            vertical: _isMobile ? 20 : 28,
                          ),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 720),
                            child: _profile == null
                                ? const Center(child: Text('No profile data.'))
                                : Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'My Profile',
                                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          if (_profile != null)
                                            IconButton(
                                              onPressed: _refreshing ? null : _refreshProfile,
                                              icon: _refreshing
                                                  ? SizedBox(
                                                      width: 22,
                                                      height: 22,
                                                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.blue.shade800),
                                                    )
                                                  : Icon(Icons.refresh, color: Colors.blue.shade800),
                                              tooltip: 'Refresh profile',
                                            ),
                                        ],
                                      ),
                                      const SizedBox(height: 24),
                                      _ProfileView(profile: _profile!),
                                      const SizedBox(height: 28),
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          onPressed: _saving ? null : () => _showEditDialog(context),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blue.shade800,
                                            foregroundColor: Colors.white,
                                            padding: const EdgeInsets.symmetric(vertical: 14),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                            elevation: 0,
                                          ),
                                          child: _saving
                                              ? const SizedBox(
                                                  height: 22,
                                                  width: 22,
                                                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                                )
                                              : const Text('Edit Profile'),
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                      Footer(),
                    ],
                  ),
                ),
    );
  }

  Future<void> _showEditDialog(BuildContext context) async {
    final first = TextEditingController(text: _profile!['first_name']?.toString() ?? '');
    final last = TextEditingController(text: _profile!['last_name']?.toString() ?? '');
    final email = TextEditingController(text: _profile!['email']?.toString() ?? '');
    final phone = TextEditingController(text: _profile!['phone']?.toString() ?? '');
    final address = TextEditingController(text: _profile!['address']?.toString() ?? '');
    final currentPassword = TextEditingController();
    final newPassword = TextEditingController();

    final updated = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Edit Profile', style: Theme.of(ctx).textTheme.titleLarge),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: first,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: last,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: phone,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: address,
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
              ),
              const SizedBox(height: 20),
              Divider(color: Colors.grey.shade300),
              const SizedBox(height: 8),
              Text('Change password (optional)', style: Theme.of(ctx).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600, color: Colors.grey.shade700)),
              const SizedBox(height: 12),
              TextField(
                controller: currentPassword,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Current Password',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: newPassword,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text('Cancel', style: TextStyle(color: Colors.grey.shade700)),
          ),
          FilledButton(
            onPressed: () async {
              setState(() => _saving = true);
              final body = <String, dynamic>{
                'first_name': first.text.trim(),
                'last_name': last.text.trim(),
                'email': email.text.trim(),
                'phone': phone.text.trim(),
                'address': address.text.trim(),
              };
              if (newPassword.text.isNotEmpty) {
                body['current_password'] = currentPassword.text;
                body['password'] = newPassword.text;
              }
              try {
                final headers = await AuthService.authHeaders();
                final res = await http.post(
                  Uri.parse(ApiConfig.updateProfile),
                  headers: headers,
                  body: json.encode(body),
                );
                final data = json.decode(res.body) as Map<String, dynamic>? ?? {};
                if (!ctx.mounted) return;
                if (res.statusCode >= 200 && res.statusCode < 300 && data['user'] != null) {
                  await AuthService.setProfile(Map<String, dynamic>.from(data['user'] as Map));
                  Navigator.pop(ctx, true);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile updated.'), backgroundColor: Colors.green));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data['message']?.toString() ?? 'Update failed.'), backgroundColor: Colors.red));
                }
              } catch (e) {
                if (ctx.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red));
                }
              } finally {
                if (mounted) setState(() => _saving = false);
              }
            },
            style: FilledButton.styleFrom(backgroundColor: Colors.blue.shade800),
            child: const Text('Save'),
          ),
        ],
      ),
    );

    if (updated == true && mounted) {
      setState(() {
        _profile = null;
        _loading = true;
      });
      await _loadProfile();
    }
  }
}

class _ProfileView extends StatelessWidget {
  final Map<String, dynamic> profile;

  const _ProfileView({required this.profile});

  String get _photoUrl {
    final photo = profile['photo']?.toString();
    if (photo == null || photo.isEmpty) return '';
    if (photo.startsWith('http')) return photo;
    return '${ApiConfig.baseUrlForFiles}/${photo.replaceFirst(RegExp(r'^/'), '')}';
  }

  @override
  Widget build(BuildContext context) {
    final first = profile['first_name']?.toString() ?? '';
    final last = profile['last_name']?.toString() ?? '';
    final name = '$first $last'.trim();
    final hasPhoto = _photoUrl.isNotEmpty;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.grey.shade200)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: hasPhoto
                  ? CircleAvatar(
                      radius: 52,
                      backgroundColor: Colors.grey.shade100,
                      backgroundImage: NetworkImage(_photoUrl),
                      onBackgroundImageError: (_, __) {},
                    )
                  : CircleAvatar(
                      radius: 52,
                      backgroundColor: Colors.blue.shade50,
                      child: Text(
                        (name.isNotEmpty ? name[0] : '?').toUpperCase(),
                        style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600, color: Colors.blue.shade800),
                      ),
                    ),
            ),
            const SizedBox(height: 24),
            Divider(height: 1, color: Colors.grey.shade200),
            const SizedBox(height: 20),
            _buildRow(context, 'Name', name.isEmpty ? '—' : name, Icons.person_outline),
            _buildRow(context, 'Email', profile['email']?.toString() ?? '—', Icons.email_outlined),
            _buildRow(context, 'Phone', profile['phone']?.toString() ?? '—', Icons.phone_outlined),
            _buildRow(context, 'Address', profile['address']?.toString() ?? '—', Icons.location_on_outlined),
            _buildRow(context, 'Status', profile['status']?.toString() ?? '—', Icons.info_outline),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context, String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.blue.shade800),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade600,
                        letterSpacing: 0.3,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
