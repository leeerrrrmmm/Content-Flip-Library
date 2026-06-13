import 'package:content_flipper/content_flipper.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PreviewScreen(),
    );
  }
}

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ContentFlipper(
          /// The axis around which the widget flips.
          /// Defaults to [Axis.horizontal].
          axis: Axis.horizontal,

          /// The side that should be visible when the widget is first built.
          /// Defaults to [FlipSide.front].
          initialSide: FlipSide.front,

          /// The widget to display on the front side.
          front: Container(
            width: 400,
            height: 400,
            color: Colors.red,
            child: Center(
              child: Text(
                'First side',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          /// The widget to display on the back side.
          back: Container(
            width: 400,
            height: 400,
            color: Colors.green,
            child: Center(
              child: Text(
                'Second side',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          onFrontTap: () => print('Front tapped'),
          onBackTap: () => print('Back tapped'),
        ),
      ),
    );
  }
}
