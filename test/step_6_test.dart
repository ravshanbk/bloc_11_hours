import 'dart:typed_data' show Uint8List;

import 'package:bloc11hours/steps/step_6/bloc/app_bloc_6.dart';
import 'package:bloc11hours/steps/step_6/bloc/app_state.dart';
import 'package:bloc11hours/steps/step_6/bloc/bloc_events_6.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

extension ToList on String {
  Uint8List toUint8List() => Uint8List.fromList(codeUnits);
}

final text1Data = 'Foo'.toUint8List();
final text2Data = 'Bar'.toUint8List();

enum Errors { dummy }

void main() {
  blocTest<AppBloc6, AppState6>(
    'Initial state of the bloc should be emty',
    build: () => AppBloc6(
      urls: [],
    ),
    verify: (appBloc) => expect(
      appBloc.state,
      const AppState6.empty(),
    ),
  );
  // load valid data and compare stats
  blocTest<AppBloc6, AppState6>(
    'Test the ability to load a URL',
    build: () => AppBloc6(
      urls: [],
      urlPicker6: (_) => '',
      urlLoader: (_) => Future.value(text1Data),
    ),
    act: (appBloc) => appBloc.add(
      const LoadNextUrlEvent6(),
    ),
    expect: () => [
      const AppState6(
        isLoading: true,
        data: null,
        error: null,
      ),
      AppState6(
        isLoading: false,
        data: text1Data,
        error: null,
      ),
    ],
  );
  // test throwing an error from url loader
  blocTest<AppBloc6, AppState6>(
    'Throw an error in url loader and catch it',
    build: () => AppBloc6(
      urls: [],
      urlPicker6: (_) => '',
      urlLoader: (_) => Future.error(Errors.dummy),
    ),
    act: (appBloc) => appBloc.add(
      const LoadNextUrlEvent6(),
    ),
    expect: () => [
      const AppState6(
        isLoading: true,
        data: null,
        error: null,
      ),
      const AppState6(
        isLoading: false,
        data: null,
        error: Errors.dummy,
      ),
    ],
  );

  blocTest<AppBloc6, AppState6>(
    'Test the ability to load more than one URL',
    build: () => AppBloc6(
      urls: [],
      urlPicker6: (_) => '',
      urlLoader: (_) => Future.value(text2Data),
    ),
    act: (appBloc) {
      appBloc.add(
        const LoadNextUrlEvent6(),
      );
      appBloc.add(
        const LoadNextUrlEvent6(),
      );
    },
    expect: () => [
      const AppState6(
        isLoading: true,
        data: null,
        error: null,
      ),
      AppState6(
        isLoading: false,
        data: text2Data,
        error: null,
      ),
       const AppState6(
        isLoading: true,
        data: null,
        error: null,
      ),
      AppState6(
        isLoading: false,
        data: text2Data,
        error: null,
      ),
    ],
  );
}
