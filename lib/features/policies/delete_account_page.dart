import 'package:flutter/material.dart';

import 'package:zencare/common/appbar.dart';
import 'package:zencare/common/footer.dart';

class DeleteAccountPage extends StatelessWidget {
  const DeleteAccountPage({super.key});

  bool _isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 768;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: _isMobile(context) ? 20 : 50,
                vertical: _isMobile(context) ? 15 : 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'DELETE ACCOUNT',
                      style: _isMobile(context)
                          ? Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(fontWeight: FontWeight.bold)
                          : Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  SizedBox(height: _isMobile(context) ? 12 : 16),
                  Text(
                    'To delete your account, please write to us at the email address below. '
                    'We will process your request after verifying your details.',
                    style: _isMobile(context)
                        ? Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(height: 1.5)
                        : Theme.of(context).textTheme.displayMedium,
                  ),
                  SizedBox(height: _isMobile(context) ? 16 : 20),
                  SelectableText(
                    'zencareservies@gmail.com',
                    style: _isMobile(context)
                        ? Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(
                              height: 1.5,
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w500,
                            )
                        : Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w500,
                            ),
                  ),
                ],
              ),
            ),
            Footer(),
          ],
        ),
      ),
    );
  }
}
