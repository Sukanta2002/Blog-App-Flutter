import 'package:blog_app/core/router/router_constants.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_gradian_button.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  // A global key for form validation
  final _formKey = GlobalKey<FormState>();

  // Controllers for the Text field to get the data
  final TextEditingController _emaiController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emaiController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign In.',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              AuthTextField(
                hintText: 'Email',
                controller: _emaiController,
              ),
              const SizedBox(height: 15),
              AuthTextField(
                hintText: 'Password',
                controller: _passwordController,
                isPassword: true,
              ),
              const SizedBox(height: 20),
              const AuthGradiantButton(
                buttonName: 'Sign In',
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  context.push(RouterConstants.signUpPageRoutePath);
                },
                child: RichText(
                  text: const TextSpan(
                      text: 'Don\'n have an account? ',
                      children: [
                        TextSpan(
                          text: 'Sign Up',
                          style: TextStyle(
                            color: AppPallete.gradient2,
                          ),
                        ),
                      ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
