import 'package:flutter/material.dart';

import '../../util/colors.dart';
import '../../util/glith_effect.dart';
import '../responsive/responsive.dart';
import '../widget/custom_button.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

class OnboardingScreen extends StatelessWidget {
  static const routeName = '/onboarding';
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const GlithEffect(
                child: Text(
                  'Welcome to Deepesh \nViedo Streaming App',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: white,
                    fontSize: 40,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: CustomButton(
                  onTap: () {
                    Navigator.pushNamed(context, LoginScreen.routeName);
                  },
                  text: 'Log in',
                ),
              ),
              CustomButton(
                onTap: () {
                  Navigator.pushNamed(context, SignupScreen.routeName);
                },
                text: 'Sign Up',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
