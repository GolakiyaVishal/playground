import 'package:flutter/material.dart';
import 'package:playground/src/bloc/search_result.dart';
import 'package:playground/src/models/animal.dart';
import 'package:playground/src/models/person.dart';

class SearchResultView extends StatelessWidget {
  const SearchResultView({super.key, required this.searchResult});

  final Stream<SearchResult?> searchResult;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: searchResult,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final result = snapshot.data;

            if (result is SearchResultLoading) {
              return const CircularProgressIndicator();
            } else if (result is SearchResultNoResult) {
              return const Text('No result found');
            } else if (result is SearhcResulError) {
              return const Text('Got error');
            } else if (result is SearchResultSuccess) {
              final results = result.results;

              return Expanded(
                  child: ListView.builder(
                      itemCount: results.length,
                      itemBuilder: (context, index) {
                        final item = results[index];
                        String title = item is Person
                            ? 'Person'
                            : item is Animal
                                ? 'Animal'
                                : 'Unknown';

                        return ListTile(
                          title: Text(title),
                          subtitle: Text(item.toString()),
                        );
                      }));
            }
          }
          return const Text('Awaiting');
        });
  }
}
