import 'package:flutter/material.dart';
import 'package:flutter_app_gif/src/pages/gif_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gif Animated',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: GifPage(),
    );
  }
}