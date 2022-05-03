import 'package:bloc11hours/steps/step_6/bloc/app_bloc_6.dart';

class TopBloc6 extends AppBloc6 {
  TopBloc6({
    Duration? waitBeforeLoading,
    required Iterable<String> urls,
  }) : super(
          waitBeforeLoading: waitBeforeLoading,
          urls: urls,
        );
}
