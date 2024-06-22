import 'package:flutter/foundation.dart' show immutable;
import 'package:playground/src/models/thing.dart';

@immutable
class Animal extends Thing {
  final String type;

  const Animal({required super.name, required this.type});

  factory Animal.fromJson(Map<String, dynamic> json) {
    return Animal(name: json['name'], type: json['type']);
  }

  @override
  String toString() => 'Animal (name: $name, type: $type)';
}
