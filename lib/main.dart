import 'package:flutter/material.dart';
import 'currency_converter.dart';
import 'themes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = true;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Currency Converter',
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: lightTheme(),
      darkTheme: darkTheme(),
      home:
      CurrencyConverter(toggleTheme: _toggleTheme, isDarkMode: _isDarkMode),
    );
  }
}
