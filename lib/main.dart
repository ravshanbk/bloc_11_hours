import 'package:bloc11hours/bloc/persons_bloc.dart';
import 'package:bloc11hours/steps/step_2_page.dart';
import 'package:flutter/material.dart';



import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: 
    // STEP_2 && STEP-1
    BlocProvider(
        create: (_) => PersonsBloc(),
        child:const
        // MyHomePage(),
         Step2Page(),
      ),
  ));
}




