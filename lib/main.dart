import 'package:flutter/material.dart';
import 'components/home_page_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          title: const Text('Yol Yardım Aktivasyon'),
        ),
        body: const RoadsideAssistance()
      ),
    );
  }
}