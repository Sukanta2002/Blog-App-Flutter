import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?> imagePicker() async {
  try {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) {
      return File(img.path);
    }
    return null;
  } catch (e) {
    return null;
  }
}
