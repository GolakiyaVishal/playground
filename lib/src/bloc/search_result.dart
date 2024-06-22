import 'package:flutter/foundation.dart' show immutable;
import 'package:playground/src/models/thing.dart';

@immutable
abstract class SearchResult {}

@immutable
class SearchResultLoading extends SearchResult {}

@immutable
class SearchResultNoResult extends SearchResult {}

@immutable
class SearhcResulError extends SearchResult {
  final Object error;

  SearhcResulError(this.error);
}

@immutable
class SearchResultSuccess extends SearchResult {
  final List<Thing> results;

  SearchResultSuccess(this.results);
}
