# Content Flipper

A professional-grade, highly customizable Flutter widget for seamless 3D content flipping.

Whether you're building interactive flashcards, 3D toggles, product previews, or dynamic UI elements, **Content Flipper** provides smooth, hardware-accelerated animations with a clean and declarative API.

---

## ✨ Features

* ⚡ **Smooth 3D Flip Animations** — Hardware-accelerated transitions with realistic depth perception.
* 🎯 **Horizontal & Vertical Flipping** — Supports both `Axis.horizontal` and `Axis.vertical`.
* 👆 **Built-in Gesture Handling** — Tap-to-flip behavior with dedicated callbacks for each side.
* 🎨 **Fully Customizable Content** — Use any Flutter widget as the front or back face.
* ⚙️ **Flexible Animation Logic** — Use the default flip behavior or provide your own transformation logic.
* 🔄 **Reverse Flip Support** — Easily invert rotation direction.
* 🛡️ **Production Ready** — Includes safety checks and protection against animation conflicts.

---

## Example
![Content Flipper Demo](gif/demo.gif)

---

## 📦 Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  content_flipper: ^1.0.0
```

Then run:

```bash
flutter pub get
```

Import the package:

```dart
import 'package:content_flipper/content_flipper.dart';
```

---

## 🚀 Quick Start

### Basic Flip Card

```dart
ContentFlipper(
  axis: Axis.horizontal,
  front: ElevatedButton(
    onPressed: null,
    child: const Text('Show Back'),
  ),
  back: ElevatedButton(
    onPressed: null,
    child: const Text('Show Front'),
  ),
  onFrontTap: () {
    debugPrint('Flipping to back...');
  },
)
```

---

## 🎨 Custom Content

Any widget can be used as a face of the flipper.

```dart
ContentFlipper(
  axis: Axis.vertical,
  initialSide: FlipSide.back,
  front: Container(
    color: Colors.red,
    alignment: Alignment.center,
    child: const Text('Front'),
  ),
  back: Container(
    color: Colors.blue,
    alignment: Alignment.center,
    child: const Text('Back'),
  ),
)
```

---

## 🎯 Flashcard Example

```dart
ContentFlipper(
  front: Card(
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Text('What is Flutter?'),
    ),
  ),
  back: Card(
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Text('Flutter is Google’s UI toolkit.'),
    ),
  ),
)
```

---

## ⚙️ API Reference

| Parameter             | Type            | Default           | Description                        |
| --------------------- | --------------- | ----------------- | ---------------------------------- |
| `front`               | `Widget`        | Required          | Widget displayed on the front side |
| `back`                | `Widget`        | Required          | Widget displayed on the back side  |
| `axis`                | `Axis`          | `Axis.horizontal` | Flip direction                     |
| `initialSide`         | `FlipSide`      | `FlipSide.front`  | Initial visible side               |
| `duration`            | `Duration`      | `700ms`           | Animation duration                 |
| `isReverseFlip`       | `bool`          | `false`           | Reverses rotation direction        |
| `useDefaultFlipLogic` | `bool`          | `true`            | Enables built-in flip behavior     |
| `onFrontTap`          | `VoidCallback?` | `null`            | Called when front side is tapped   |
| `onBackTap`           | `VoidCallback?` | `null`            | Called when back side is tapped    |

---

## 📱 Use Cases

Content Flipper is ideal for:

* Flashcards
* Quiz applications
* Product previews
* Authentication forms
* Settings toggles
* Educational apps
* Interactive dashboards
* Game interfaces

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome.

If you find a bug or have an idea for improvement, feel free to open an issue or submit a pull request.

---

## 📄 License

This project is licensed under the MIT License.

See the `LICENSE` file for details.
