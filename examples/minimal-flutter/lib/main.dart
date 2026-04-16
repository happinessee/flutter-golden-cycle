import 'package:flutter/material.dart';

import 'widgets/primary_button.dart';

void main() => runApp(const ExampleApp());

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter-golden-cycle example',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4F46E5)),
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Example')),
        body: Center(
          child: PrimaryButton(label: 'Tap me', onPressed: () {}),
        ),
      ),
    );
  }
}
