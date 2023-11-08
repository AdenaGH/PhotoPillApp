import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:photo_pill/search.dart' as searchlib;
import 'package:photo_pill/drug.dart' as druglib;
import 'dart:developer' as developer;

void main() {
  test('empty drug object creation test', () {
    druglib.Drug drug = druglib.Drug.empty();
    expect(drug.name, "DEFAULT");
    expect(drug.color, "DEFAULT");
    expect(drug.shape, "DEFAULT");
    expect(drug.size, "DEFAULT");
  });
  test('sample drug object creation test', () {
    druglib.Drug drug = druglib.Drug("", "BLUE", "barrel shaped", "11 mm");
    expect(drug.name, "DEFAULT");
    expect(drug.color, "BLUE");
    expect(drug.shape, "barrel shaped");
    expect(drug.size, "11 mm");
  });
  test('sample drug rank test', () {
    druglib.Drug drug = druglib.Drug("", "BLUE", "barrel shaped", "11 mm");
    druglib.Drug target = druglib.Drug("", "BLUE", "barrel shaped", "11 mm");
    drug.getRank(target);
    expect(drug.rank, 3);
  });
}