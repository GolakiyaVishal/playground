import 'package:flutter/material.dart';
import 'package:playground/src/bloc/api.dart';
import 'package:playground/src/bloc/search_bloc.dart';
import 'package:playground/src/views/search_result_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SearchBloc _searchBloc;

  @override
  void initState() {
    super.initState();
    _searchBloc = SearchBloc(api: Api());
  }

  @override
  void dispose() {
    _searchBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search'),),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _searchBloc.search.add,
              decoration: const InputDecoration(
                hintText: 'Enter search term here...'
              ),
            ),
          ),
          const SizedBox(height: 12),
          SearchResultView(searchResult: _searchBloc.result)
        ],
      ),
    );
  }
}