import 'package:content_flipper/content_flipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ContentFlipper', () {
    expect(
      ContentFlipper(
        front: Container(width: 100, height: 100, color: Colors.red),
        back: Container(width: 100, height: 100, color: Colors.blue),
      ),
      isA<ContentFlipper>(),
    );
  });
}
