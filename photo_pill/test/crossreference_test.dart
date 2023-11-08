import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:photo_pill/search.dart' as searchlib;
import 'package:photo_pill/drug.dart' as druglib;
import 'dart:developer' as developer;

void main() {
  test('cross reference test', () {
    expect(druglib.Drug.empty().size, 0);
  });
}