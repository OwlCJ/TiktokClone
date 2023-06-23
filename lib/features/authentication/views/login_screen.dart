import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/view_models/social_auth_view_model.dart';
import 'package:tiktok_clone/features/authentication/views/login_form_screen.dart';
import 'package:tiktok_clone/features/authentication/views/widgets/auth_button.dart';

class LoginScreen extends ConsumerWidget {
  static String routeName = 'login';
  static String routeURL = '/login';
  const LoginScreen({super.key});

  void _onSignUpTap(BuildContext context) {
    context.pop();
  }

  void _onEmailLoginTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginFormScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
            child: Column(
              children: [
                Gaps.v80,
                const Text(
                  'Log in to TikTok',
                  style: TextStyle(
                    fontSize: Sizes.size24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Gaps.v20,
                const Opacity(
                  opacity: 0.7,
                  child: Text(
                    'Manage your account, check notifications, comment on videos, and more.',
                    style: TextStyle(
                      fontSize: Sizes.size16,
                    ),
                  ),
                ),
                Gaps.v40,
                AuthButton(
                  onTapGesture: _onEmailLoginTap,
                  icon: const FaIcon(FontAwesomeIcons.user),
                  text: 'Use email & password',
                ),
                Gaps.v16,
                AuthButton(
                    onTapGesture: (context) => ref
                        .read(socialAuthProvider.notifier)
                        .githubSignIn(context),
                    icon: const FaIcon(FontAwesomeIcons.github),
                    text: 'Continue with Github'),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: Sizes.size24),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text("Don't have an account?"),
              Gaps.h5,
              GestureDetector(
                onTap: () => _onSignUpTap(context),
                child: Text(
                  'Sign up',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
