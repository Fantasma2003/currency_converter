import 'package:currency_converter/screen/converter.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
        brightness: Brightness.light,
        useMaterial3: false,
      ),
      home: const ConverterApp(),
    );
  }
}
