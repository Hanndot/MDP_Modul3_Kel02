import 'package:flutter/material.dart';
import 'package:mod3_kel02/screens/home.dart';
import 'package:mod3_kel02/screens/detail.dart';

void main() async {
  runApp(const AnimeApp());
}

class AnimeApp extends StatelessWidget {
  const AnimeApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weeb App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/detail': (context) => const DetailPage(item: 0, title: ''),
      },
    );
  }
}
