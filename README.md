# Easy Animated Indexed Stack

A drop-in replacement for Flutter's default `IndexedStack` that allows simple animations to transition between widgets/screens/pages.

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
    return EasyAnimatedIndexedStack(
        // `selectedIndex` is a state variable (int)
        index: selectedIndex,
        children: [
            PageA(onTap: () => setState(() => selectedIndex = 0)),
            PageB(onTap: () => setState(() => selectedIndex = 1)),
            PageC(onTap: () => setState(() => selectedIndex = 2)),
        ],
    );
}
```

## LICENSE
This package uses the [New BSD License](./LICENSE)
