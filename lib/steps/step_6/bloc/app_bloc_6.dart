import 'package:bloc11hours/steps/step_6/bloc/app_state.dart';
import 'package:bloc11hours/steps/step_6/bloc/bloc_events_6.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;

typedef AppBlocRandomUrlPicker6 = String Function(Iterable<String> allUrls);

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(
        math.Random().nextInt(length),
      );
}

class AppBloc6 extends Bloc<AppEvent6, AppState6> {
  String _pickRandomUrl(Iterable<String> allUrls) => allUrls.getRandomElement();

  AppBloc6({
    required Iterable<String> urls,
    Duration? waitBeforeLoading,
    AppBlocRandomUrlPicker6? urlPicker6,
  }) : super(
          const AppState6.empty(),
        ) {
    on<LoadNextUrlEvent6>((event, emit) async {
      emit(
        const AppState6(
          isLoading: true,
          data: null,
          error: null,
        ),
      );
      final url = (urlPicker6 ?? _pickRandomUrl)(urls);
      try {
        if (waitBeforeLoading != null) {
          await Future.delayed(waitBeforeLoading);
        }
        final bundle = NetworkAssetBundle(Uri.parse(url));
        final data = (await bundle.load(url)).buffer.asUint8List();
        emit(
          AppState6(
            isLoading: false,
            data: data,
            error: null,
          ),
        );
      } catch (e) {
        emit(
          AppState6(
            isLoading: false,
            data: null,
            error: e,
          ),
        );
      }
    });
  }
}
