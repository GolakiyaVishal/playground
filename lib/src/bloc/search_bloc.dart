import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart';
import 'package:playground/src/bloc/api.dart';
import 'package:rxdart/rxdart.dart';

import 'search_result.dart';

@immutable
class SearchBloc {
  final Sink<String> search;
  final Stream<SearchResult?> result;

  const SearchBloc._({required this.search, required this.result});

  void dispose() {
    search.close();
  }

  factory SearchBloc({required Api api}) {
    final textChanges = BehaviorSubject<String>();

    final result = textChanges
        .distinct()
        .debounceTime(const Duration(milliseconds: 300))
        .switchMap<SearchResult?>((String searchTerm) {
      // search is empty
      if (searchTerm.isEmpty) {
        return Stream<SearchResult?>.value(null);
      } else {
        return Rx.fromCallable(() => api.search(searchTerm))
            .delay(const Duration(seconds: 1))
            .map((result) => result.isEmpty
                ? SearchResultNoResult()
                : SearchResultSuccess(result))
            .startWith(SearchResultLoading())
            .onErrorReturnWith((err, _) {
          debugPrint('error :::: ${err.toString()}');
          return SearhcResulError(err);
        });
      }
    });

    return SearchBloc._(search: textChanges.sink, result: result);
  }
}
