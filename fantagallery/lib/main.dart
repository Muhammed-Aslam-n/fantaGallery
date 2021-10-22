import 'package:fantagallery/imagepicker/galleryviewer.dart';
import 'package:fantagallery/imagepicker/imagepicker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => PickImage(),
        '/gallery': (context) => GalleryViewer(),
      },
    );
  }
}
