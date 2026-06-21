import 'package:blog_app/core/theme/app_pallette.dart';
import 'package:flutter/material.dart';

class AuthGradientButton extends StatelessWidget {
  final String button;
final VoidCallback onPressed;

  const AuthGradientButton({super.key, required this.button,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      //this is done for gradient color
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppPallete.gradient1, AppPallete.gradient2],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(7),
      ),
      child: ElevatedButton(
        onPressed:onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              AppPallete.transparentColor, //for making the background color
          shadowColor:
              AppPallete.transparentColor, //for making the background color
          fixedSize: const Size(395, 55),
          // backgroundColor: AppPallete.gradient1, // THIS IS SIMPLE COLOR NOT THE GRADIENT COLOR SO WE WILL WRAP OUR BUTTON WITH CONATINER TO DO SO
        ),
        child: Text(
          button,

          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
