import 'package:flutter/material.dart';

void showSnackBar(BuildContext context,String content) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()//hide curernt one to show recent one
      
      ..showSnackBar(
        SnackBar(
          content: Text(content),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
        ),
      );
  }
