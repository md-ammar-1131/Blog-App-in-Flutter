import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/theme/app_pallette.dart';
import 'package:blog_app/core/utilities/show_snakbar.dart';
import 'package:blog_app/feautures/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/feautures/auth/presentation/pages/signup_page.dart';
import 'package:blog_app/feautures/auth/presentation/widgets/auth_field.dart';
import 'package:blog_app/feautures/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const LoginPage());
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  //it will validate the form field that is if user have written anything in his field of tetxt or not or just hitting the signup
  @override
  void dispose() {
    emailController.dispose();

    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        // now all children in this column will folow this padding so the diffrent colum child like txtfield wil follow the padding
        padding: const EdgeInsets.all(15.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return Loader();
            }
            return Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Log In.",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.cyan,
                      fontSize: 32,
                    ),
                  ),
                  const SizedBox(height: 30),
                  AuthField(hintText: "Email", controller: emailController),
                  const SizedBox(height: 15),
                  AuthField(
                    hintText: "Password",
                    controller: passwordController,
                    isObscureText: true,
                  ),

                  const SizedBox(height: 15),
                  AuthGradientButton(
                    button: "Log In",
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                          AuthLogin(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    /////////////////////////////////////////////////////////////////////////////////////////
                    onTap: () {
                      Navigator.push(context, SignupPage.route());
                    },
                    ///////////////////////////////////////////////////////////////////////////////////////////
                    child: RichText(
                      text: TextSpan(
                        text: 'Don\'t Have an Account? ',
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text: 'Sign Up',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  color: AppPallete.gradient2,
                                  fontWeight: FontWeight.bold,
                                ), //if it is null dont call the copywith this what the '?' do
                          ),
                        ],
                      ),
                    ),
                  ), //this allows rich type text that is two design text in single widget
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

//now we are using name route/ametral page rout teo fo signup in login page 

//