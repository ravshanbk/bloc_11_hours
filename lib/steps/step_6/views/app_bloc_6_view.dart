import 'package:bloc11hours/steps/step_6/bloc/app_bloc_6.dart';
import 'package:bloc11hours/steps/step_6/bloc/app_state.dart';
import 'package:bloc11hours/steps/step_6/bloc/bloc_events_6.dart';
import 'package:bloc11hours/steps/step_6/extensions/stream/start_with.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocView6<T extends AppBloc6> extends StatelessWidget {
  const AppBlocView6({Key? key}) : super(key: key);

  void startUpdatingBloc(BuildContext context) {
    Stream.periodic(
      const Duration(seconds: 10),
      (_) => const LoadNextUrlEvent6(),
    ).startWith(const LoadNextUrlEvent6()).forEach((event) {
      context.read<T>().add(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    startUpdatingBloc(context);
    return Expanded(
      child: BlocBuilder<T, AppState6>(
        builder: (context, appState) {
          // we have an error
          if (appState.error != null) {
            return const Text('An error occured');
          } else if (appState.data != null) {
            // we have data
            return Image.memory(
              appState.data!,
              fit: BoxFit.fitHeight,
            );
          } else {
            // loading
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
        },
      ),
    );
  }
}
