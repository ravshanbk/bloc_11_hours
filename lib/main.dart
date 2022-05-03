import 'package:bloc11hours/models.dart';
import 'package:bloc11hours/steps/step_4_5/apis/login_api.dart';
import 'package:bloc11hours/steps/step_4_5/apis/notes_api.dart';
import 'package:bloc11hours/steps/step_4_5/bloc/actions.dart';
import 'package:bloc11hours/steps/step_4_5/bloc/app_bloc.dart';
import 'package:bloc11hours/steps/step_4_5/bloc/app_state.dart';
import 'package:bloc11hours/steps/step_4_5/dialogs/generic_dialog.dart';
import 'package:bloc11hours/steps/step_4_5/dialogs/loading_screen.dart';
import 'package:bloc11hours/steps/step_4_5/views/iterable_list_view.dart';
import 'package:bloc11hours/steps/step_4_5/views/login_view.dart';
import 'package:bloc11hours/steps/step_6/views/home_page_6.dart';
import 'package:bloc11hours/strings.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:HomePage6()
      
      //  _body_4_5()

      //###############################################################
      // // STEP_2 && STEP-1 && STEP-3
      // BlocProvider(
      //     create: (_) => PersonsBloc(),
      //     child:const
      //     // MyHomePage(),
      //      Step2Page(),
      //   ),
      ));
}

BlocProvider<AppBloc> _body_4_5() {
  return BlocProvider(
      create: (context) => AppBloc(
        loginApi: LoginApi(),
        notesApi: NotesApi(),
        acceptedLoginHandle: const LoginHandle.fooBar()
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(homePage),
        ),
        body: BlocConsumer<AppBloc, AppState>(
          listener: (context, state) {
            // loading screen
            if (state.isLoading) {
              LoadingScreen.instance().show(
                context: context,
                text: pleaseWait,
              );
            } else {
              LoadingScreen.instance().hide();
            }
            //  display possible errors
            final loginError = state.loginError;
            if (loginError != null) {
              showGenericDialog(
                context: context,
                title: loginErrordDialogTitle,
                content: loginErrorDialogContent,
                optionsBuilder: () => {ok: true},
              );
            }
            // if we are logged in, but we ghave no fetched notes, fetch them now
            if (state.isLoading == false &&
                state.loginError == null &&
                state.loginHandle == const LoginHandle.fooBar() &&
                state.fetchedNotes == null) {
              context.read<AppBloc>().add(
                    const LoadNotesAction(),
                  );
            }
          },
          builder: (context, appState) {
            final notes = appState.fetchedNotes;
            if (notes == null) {
              return LoginView(
                onLoginTapped: (email, password) {
                  context.read<AppBloc>().add(
                        LoginAction(
                          email: email,
                          password: password,
                        ),
                      );
                },
              );
            } else {
              return notes.toListView();
            }
          },
        ),
      ),
    );
}
