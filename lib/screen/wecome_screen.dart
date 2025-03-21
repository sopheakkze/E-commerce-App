import 'package:app/screen/signin_screen.dart';
import 'package:app/screen/signup_screen.dart';
import 'package:app/widgets/custom_scaffold.dart';
import 'package:app/widgets/welcome_button.dart';
import 'package:flutter/material.dart';

class WecomeScreen extends StatelessWidget {
  const WecomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(children: [
        Flexible(
            flex: 8,
            child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 40,
                ),
                child: Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Welcome to PheakApparel\n',
                          style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: "\nPremium tech for premium lives.",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ))),
        const Flexible(
          flex: 1,
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.end, // Moves buttons to the right
            children: [
              Expanded(
                  child: WelcomeButton(
                buttonText: 'Sign in',
                onTap: SigninScreen(),
                color: Colors.transparent,
                textColors: Colors.white,
              )),
              Expanded(
                  child: WelcomeButton(
                buttonText: 'Sign up',
                onTap: SignupScreen(),
                color: Colors.white,
                textColors: Colors.black,
              )),
            ],
          ),
        ),
      ]),
    );
  }
}
