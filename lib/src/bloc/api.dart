import 'dart:convert';
import 'dart:io';

import 'package:playground/src/models/animal.dart';
import 'package:playground/src/models/person.dart';
import 'package:playground/src/models/thing.dart';

typedef SearchTerm = String;
// String baseUrl =  'http://10.0.2.2:8000';
String baseUrl =  'http://10.0.2.2:5500';
// String baseUrl =  'http://127.0.0.1:5500';

class Api {
  List<Animal>? _animals;
  List<Person>? _persons;
  Api();

  Future<List<Thing>> search(SearchTerm SearchTerm) async {
    final term = SearchTerm.trim().toLowerCase();

    // check for cached data
    final cachedResult = _extraxtThingsUsinfSearchTerms(term);
    if(cachedResult != null) {
      return cachedResult;
    }

    // call api for new data
    final persons = await _getJson('$baseUrl/apis/persons.json')
    .then((json) => json.map((value) => Person.fromJson(value)));
    _persons = persons.toList();

    final animals = await _getJson('$baseUrl/apis/animals.json')
    .then((json) => json.map((value) => Animal.fromJson(value)));
    _animals = animals.toList();

    return _extraxtThingsUsinfSearchTerms(term) ?? [];
  }

  List<Thing>? _extraxtThingsUsinfSearchTerms(SearchTerm term) {
    final cachedAnimals = _animals;
    final cachedPersons = _persons;

    if (cachedAnimals != null && cachedPersons != null) {
      List<Thing> result = [];

      for(final animal in cachedAnimals) {
        if(animal.name.trimmedContain(term) || animal.type.trimmedContain(term)){
          result.add(animal);
        }
      }
      for(final person in cachedPersons) {
        if(person.name.trimmedContain(term) || person.age.toString().trimmedContain(term)){
          result.add(person);
        }
      }
      return result;
    } else {
      return null;
    }
  }

  Future<List<dynamic>> _getJson(String url) => HttpClient()
  .getUrl(Uri.parse(url))
  .then((req) => req.close())
  .then((resp) => resp.transform(utf8.decoder).join()
  .then((jsonString) => jsonDecode(jsonString) as List<dynamic>));

}

extension TrimmedCaseInsensitiveContainer on String {
  bool trimmedContain(String other) =>
    trim().toLowerCase().contains(
      other.trim().toLowerCase());
}