import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/username_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';

class SignUpScreen extends StatelessWidget {
  static String routeURL = '/';
  static String routeName = 'signup';
  const SignUpScreen({super.key});

  void _onLoginTap(BuildContext context) {
    context.push(LoginScreen.routeName);
  }

  void _onEmailtap(BuildContext context) {
    // Navigator.of(context).push(
    //   PageRouteBuilder(
    //     transitionDuration: const Duration(seconds: 1),
    //     pageBuilder: (context, animation, secondaryAnimation) =>
    //         const UsernameScreen(),
    //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //       final offsetAnimation =
    //           Tween(begin: const Offset(0, -1), end: Offset.zero)
    //               .animate(animation);
    //       return SlideTransition(
    //         position: offsetAnimation,
    //         child: FadeTransition(
    //           opacity: animation,
    //           child: child,
    //         ),
    //       );
    //     },
    //   ),
    // );
    context.pushNamed(UsernameScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
              child: Column(
                children: [
                  Gaps.v80,
                  const Text(
                    'Sign up for TikTok',
                    style: TextStyle(
                      fontSize: Sizes.size24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Gaps.v20,
                  const Opacity(
                    opacity: 0.7,
                    child: Text(
                      'Create a profile, follow other accounts, make your own videos, and more',
                      style: TextStyle(
                        fontSize: Sizes.size16,
                      ),
                    ),
                  ),
                  Gaps.v40,
                  if (orientation == Orientation.portrait) ...[
                    AuthButton(
                      onTapGesture: _onEmailtap,
                      icon: const FaIcon(FontAwesomeIcons.user),
                      text: 'Use email & password',
                    ),
                    Gaps.v16,
                    const AuthButton(
                        icon: FaIcon(FontAwesomeIcons.apple),
                        text: 'Continue with Apple'),
                  ],
                  if (orientation == Orientation.landscape)
                    Row(
                      children: [
                        Expanded(
                          child: AuthButton(
                            onTapGesture: _onEmailtap,
                            icon: const FaIcon(FontAwesomeIcons.user),
                            text: 'Use email & password',
                          ),
                        ),
                        Gaps.h16,
                        const Expanded(
                          child: AuthButton(
                              icon: FaIcon(FontAwesomeIcons.apple),
                              text: 'Continue with Apple'),
                        ),
                      ],
                    )
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: Sizes.size24),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text('Already have an account?'),
                Gaps.h5,
                GestureDetector(
                  onTap: () => _onLoginTap(context),
                  child: Text(
                    'log in',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ]),
            ),
          ),
        );
      },
    );
  }
}
