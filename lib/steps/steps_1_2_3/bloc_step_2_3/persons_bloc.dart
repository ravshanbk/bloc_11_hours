import 'package:bloc11hours/steps/steps_1_2_3/bloc_step_2_3/bloc_actions.dart';
import 'package:bloc11hours/steps/steps_1_2_3/bloc_step_2_3/person.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';

extension IsEqualToIgnoringOrdering<T> on Iterable<T> {
  bool isEqualToIgnoringOrdering(Iterable<T> other) =>
      length == other.length &&
      {...this}.intersection({...other}).length == length;
}

@immutable
class FetchResult {
  final Iterable<Person> persons;
  final bool isRetrievedFromCache;

  const FetchResult({
    required this.persons,
    required this.isRetrievedFromCache,
  });
  @override
  String toString() =>
      'FetchResult (isRetrivedFromCache = $isRetrievedFromCache, persons = $persons)';
  @override
  bool operator ==(covariant FetchResult other) =>
      persons.isEqualToIgnoringOrdering(other.persons) &&
      isRetrievedFromCache == other.isRetrievedFromCache;

  @override
  int get hashCode => Object.hash(
        persons,
        isRetrievedFromCache,
      );
}

class PersonsBloc extends Bloc<LoadAction, FetchResult?> {
  final Map<String, Iterable<Person>> _cache = {};
  PersonsBloc() : super(null) {
    on<LoadPersonsAction>(
      (event, emit) async {
        final url = event.url;
        if (_cache.containsKey(url)) {
          //we have the value in the cache

          final cachedPerson = _cache[url]!;
          final result = FetchResult(
            persons: cachedPerson,
            isRetrievedFromCache: true,
          );
          emit(result);
        } else {
          final loader = event.loader;
          final person = await loader(url);
          _cache[url] = person;
          final result = FetchResult(
            persons: person,
            isRetrievedFromCache: false,
          );
          emit(result);
        }
      },
    );
  }
}
