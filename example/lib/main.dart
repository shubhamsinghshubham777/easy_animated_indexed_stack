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
        body: EasyAnimatedIndexedStack(
          index: selectedIndex,
          curve: Curves.easeIn,
          duration: Durations.medium4,
          animationBuilder: (context, animation, child) {
            return Transform.translate(
              offset: Offset(0, (1 - animation.value) * 40),
              child: child,
            );
          },
          skipStart: true,
          children: [
            _Screen(
              title: "Screen A",
              backgroundColor: Colors.green,
              onTap: () => setState(() => selectedIndex = 1),
            ),
            _Screen(
              title: "Screen B",
              backgroundColor: Colors.blue,
              onTap: () => setState(() => selectedIndex = 2),
            ),
            _Screen(
              title: "Screen C",
              backgroundColor: Colors.yellow,
              onTap: () => setState(() => selectedIndex = 0),
            ),
          ],
        ),
      ),
    );
  }
}

class _Screen extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final VoidCallback onTap;

  const _Screen({
    required this.title,
    required this.backgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ColoredBox(
        color: backgroundColor,
        child: Center(child: Text(title)),
      ),
    );
  }
}
