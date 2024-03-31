import 'package:blog_app/core/common/widgets/loading_screen.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/show_scanbar.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_gradian_button.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // A global key for form validation
  final _formKey = GlobalKey<FormState>();

  // Controllers for the Text field to get the data
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emaiController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emaiController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              snackBar(context, state.failure.message);
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Loader();
            }
            return Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sign Up.',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  AuthTextField(
                    hintText: 'Name',
                    controller: _nameController,
                  ),
                  const SizedBox(height: 15),
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
                  AuthGradiantButton(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                              AuthSignup(
                                email: _emaiController.text.trim(),
                                password: _passwordController.text,
                                name: _nameController.text.trim(),
                              ),
                            );
                      }
                    },
                    buttonName: 'Sign Up',
                  ),
                  const SizedBox(height: 30),
                  RichText(
                    text: const TextSpan(
                        text: 'Already have an account? ',
                        children: [
                          TextSpan(
                            text: 'Sign In',
                            style: TextStyle(
                              color: AppPallete.gradient2,
                            ),
                          ),
                        ]),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
