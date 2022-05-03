import 'package:bloc11hours/steps/steps_1_2_3/bloc_step_2_3/bloc_actions.dart';
import 'package:bloc11hours/steps/steps_1_2_3/bloc_step_2_3/person.dart';
import 'package:bloc11hours/steps/steps_1_2_3/bloc_step_2_3/persons_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

const mockedPersons_1 = [
  Person(
    name: 'Foo',
    age: 20,
  ),
  Person(
    name: 'Bar',
    age: 30,
  ),
];
const mockedPersons_2 = [
  Person(
    name: 'Foo',
    age: 20,
  ),
  Person(
    name: 'Bar',
    age: 30,
  ),
];

Future<Iterable<Person>> mockGetPerson_1(String _) =>
    Future.value(mockedPersons_1);

Future<Iterable<Person>> mockGetPerson_2(String _) =>
    Future.value(mockedPersons_2);
void main() {
  group('Testing Bloc', () {
//  write our tests

    late PersonsBloc bloc;

    setUp(() {
      bloc = PersonsBloc();
    });

    blocTest<PersonsBloc, FetchResult?>(
      'Test Initial State',
      build: () => bloc,
      verify: (bloc) => expect(bloc.state, null),
    );

    //fetch mock data (persons_1) and compare it with FetchResult
    blocTest<PersonsBloc, FetchResult?>(
      'Mock retriving persons from first iterable',
      build: () => bloc,
      act: (bloc) {
        bloc.add(
          const LoadPersonsAction(
            url: 'summy_url_1',
            loader: mockGetPerson_1,
          ),
        );

        bloc.add(
          const LoadPersonsAction(
            url: 'summy_url_1',
            loader: mockGetPerson_1,
          ),
        );
      },
      expect: () => [
        const FetchResult(
            persons: mockedPersons_1, isRetrievedFromCache: false),
        const FetchResult(persons: mockedPersons_1, isRetrievedFromCache: true),
      ],
    );
    //fetch mock data (persons_2) and compare it with FetchResult
    blocTest<PersonsBloc, FetchResult?>(
      'Mock retriving persons from second iterable',
      build: () => bloc,
      act: (bloc) {
        bloc.add(
          const LoadPersonsAction(
            url: 'summy_url_2',
            loader: mockGetPerson_2,
          ),
        );

        bloc.add(
          const LoadPersonsAction(
            url: 'summy_url_2',
            loader: mockGetPerson_2,
          ),
        );
      },
      expect: () => [
        const FetchResult(
            persons: mockedPersons_2, isRetrievedFromCache: false),
        const FetchResult(persons: mockedPersons_2, isRetrievedFromCache: true),
      ],
    );
  });
}
