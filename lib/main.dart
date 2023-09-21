import 'package:app_rick_and_morty_flutter/src/config/theme.dart';
import 'package:app_rick_and_morty_flutter/src/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick & Morty',
      themeMode: ThemeMode.light,
      theme: CustomTheme.light,
      home: const HomePage(),
    );
  }
}
