import 'package:bloc11hours/steps/step_6/bloc/bottom_bloc_6.dart';
import 'package:bloc11hours/steps/step_6/bloc/top_bloc_6.dart';
import 'package:bloc11hours/steps/step_6/models/constants6.dart';
import 'package:bloc11hours/steps/step_6/views/app_bloc_6_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage6 extends StatelessWidget {
  const HomePage6({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: MultiBlocProvider(
          providers: [
            BlocProvider<TopBloc6>(
              create: (_) => TopBloc6(
                waitBeforeLoading: const Duration(seconds: 3),
                urls: images,
              ),
            ),
            BlocProvider<BottomBloc6>(
              create: (_) => BottomBloc6(
                waitBeforeLoading: const Duration(seconds: 3),
                urls: images,
              ),
            ),
          ],
          child: Column(
            children: [
              AppBlocView6<TopBloc6>(),
              AppBlocView6<BottomBloc6>(),
            ],
          ),
        ),
      ),
    );
  }
}
