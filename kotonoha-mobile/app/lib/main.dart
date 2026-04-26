import 'package:flutter/material.dart';

void main() {
  runApp(const KotonohaApp());
}

class KotonohaApp extends StatelessWidget {
  const KotonohaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'kotonoha',
      home: Scaffold(
        body: Center(
          child: Text(
            'kotonoha',
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
      ),
    );
  }
}
