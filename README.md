# Easy Animated Indexed Stack

A drop-in replacement for Flutter's default `IndexedStack` that allows simple animations to transition between widgets/screens/pages.

## Demo

<img src="https://github.com/user-attachments/assets/12f05c41-a865-4f83-84af-753f4aae090a" height=600 />

## Getting Started

Add the dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  # Add this  
  easy_animated_indexed_stack:
```

## Usage

As mentioned above, this package provides a drop-in replacement for Flutter's default `IndexedStack` widget, meaning you can simply replace your `IndexedStack` usages with `EasyAnimatedIndexedStack` instances. For example:

```dart
@override
Widget build(BuildContext context) {
  return MaterialApp(
    home: Scaffold(
      // Simply replaced `IndexedStack` with `EasyAnimatedIndexedStack`
      body: EasyAnimatedIndexedStack(
        // `selectedIndex` is a state variable (int)
        index: selectedIndex,
        // Customise the animation to your liking
        animationBuilder: (context, animation, child) {
          return RotationTransition(
            turns: Tween<double>(begin: 1, end: 0).animate(animation),
            child: child,
          );
        },
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 700),
        children: [
          ScreenA(onTap: () => setState(() => selectedIndex = 1)),
          ScreenB(onTap: () => setState(() => selectedIndex = 2)),
          ScreenC(onTap: () => setState(() => selectedIndex = 0)),
        ],
      ),
    ),
  );
}
```

## Resources

A medium article talking about the inspiration behind this library can be found [here](https://medium.com/@shubhamsinghshubham777/animate-screen-switches-for-indexedstack-in-flutter-a66fe488006b)

## License
This package uses the [New BSD License](./LICENSE)
