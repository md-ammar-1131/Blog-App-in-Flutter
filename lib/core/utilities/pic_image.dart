import 'dart:io';

import 'package:image_picker/image_picker.dart';

// Returns the selected image or null if the user cancels.
Future<File?> pickImage() async {
  try {
    final XFile? image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      return File(image.path);
    }

    return null;
  } catch (e) {
    return null;
  }
}