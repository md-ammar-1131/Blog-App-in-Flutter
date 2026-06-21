import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/theme/app_pallette.dart';
import 'package:blog_app/core/utilities/show_snakbar.dart';
import 'package:blog_app/feautures/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/feautures/auth/presentation/pages/login_page.dart';
import 'package:blog_app/feautures/auth/presentation/widgets/auth_field.dart';
import 'package:blog_app/feautures/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const SignupPage());
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  //it will validate the form field that is if user have written anything in his field of tetxt or not or just hitting the signup
  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(), //for getting the return button we will do this

      body: Padding(
        // now all children in this column will folow this padding so the diffrent colum child like txtfield wil follow the padding
        padding: const EdgeInsets.all(15.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showSnackBar(context, state.message);
            }

            if (state is AuthSuccess) {
              showSnackBar(context, 'Account Created Successfully');

              Navigator.pushAndRemoveUntil(
                context,
                LoginPage.route(),
                (route) => false,
              );
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              //we will make a general lading indiactor so we will this sam laoding  indiactore every wher so  well iwll make it in core folder as it is share d across all differnt folders and places
              return const Loader(); //now this loader is reusable widget
            }
            return Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sign Up.",
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
                  AuthField(hintText: "Name", controller: nameController),
                  const SizedBox(height: 15),
                  AuthGradientButton(
                    button: "Sign Up",

                    /////////////////////////////////////////////////////////////////////////////////////
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                          AuthSignUp(
                            name: nameController.text.trim(),
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          ),
                        );
                      }
                    },
                  ),
                  ////////////////////////////////////////////////////////////////////////
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, LoginPage.route());
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Already Have an Account! ',
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text: 'Sign In',
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

//only the hint text of the tectfield chsnges else all three textfiedl are same
//so we are gonna make then common textfield for all the auth files so that we can use them by just changing the hint text else the box size and color bordersixe shape all will remian same
//WE ARE GOING TO MAKE THE BUTTON coomon widget  IN NEW WIDGET LIKE THE AUTHFIELD SO THAT MY app will LOOK LIKE CONSISTENT 27-5-26,01:24
//WE WILL MAKE THE TEXT EDITING CONTROLLER FOR ACCESSIGN THE STRING WRITTEN IN THE TEXTFIELDS : 01:47 27-5-26---01-06-26
//now our paswwrd is ***** this is to be done 

//wrapping with gesture detecttor
// back_button for screen pop to prev window
//when  THE BLOC OF AUTHBLOC EVENT IS ADDED THEN AUTHBLOC ISTRIGGERED THEN AUTHSIGNUP IS CALLED AND USERSINGUP USECASE RUN THEN AUTHREPOSITORY THEN INJECTED DEPNDENCY THIS IMPLEMENTAION REMOTE DATA SOURCE IMPLN IS CALLED 

// after setting get it repo model user entity we came  TO D OLOADING INDICATOR IN SIGNUP IF IT IS USCCES THEN GO TO HOME SCREEN ELSE GOT TO FAILURE MESSAGE
