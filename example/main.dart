import 'package:easy_animated_indexed_stack/easy_animated_indexed_stack.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // Simply replaced `IndexedStack` with `EasyAnimatedIndexedStack`
        body: EasyAnimatedIndexedStack(
          index: selectedIndex,
          children: [
            ScreenA(onTap: () => setState(() => selectedIndex = 1)),
            ScreenB(onTap: () => setState(() => selectedIndex = 2)),
            ScreenC(onTap: () => setState(() => selectedIndex = 0)),
          ],
        ),
      ),
    );
  }
}

class ScreenA extends StatelessWidget {
  const ScreenA({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: onTap,
          child: const Text('Screen A (Tap to change)'),
        ),
      ),
    );
  }
}

class ScreenB extends StatelessWidget {
  const ScreenB({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: onTap,
          child: const Text('Screen B (Tap to change)'),
        ),
      ),
    );
  }
}

class ScreenC extends StatelessWidget {
  const ScreenC({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: onTap,
          child: const Text('Screen C (Tap to change)'),
        ),
      ),
    );
  }
}
