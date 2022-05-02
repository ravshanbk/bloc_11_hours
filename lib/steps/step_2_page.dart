import 'dart:convert';
import 'dart:io';

import 'package:bloc11hours/bloc/bloc_actions.dart';
import 'package:bloc11hours/bloc/person.dart';
import 'package:bloc11hours/bloc/persons_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}



Future<Iterable<Person>> getPersons(String url) => HttpClient()
    .getUrl(Uri.parse(url))
    .then((req) => req.close())
    .then((resp) => resp.transform(utf8.decoder).join())
    .then((str) => json.decode(str) as List<dynamic>)
    .then((list) => list.map((e) => Person.fromJson(e)));




extension Subscript<T> on Iterable<T> {
  T? operator [](int index) => length > index ? elementAt(index) : null;
}

class Step2Page extends StatelessWidget {
  const Step2Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // late final Bloc myBloc;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      context.read<PersonsBloc>().add(
                            const LoadPersonsAction(
                              url: person1Url,loader: getPersons
                            ),
                          );
                    },
                    child: const Text('Load json 1')),
                ElevatedButton(
                    onPressed: () {
                      context.read<PersonsBloc>().add(
                            const LoadPersonsAction(
                              url: person2Url,loader: getPersons
                            ),
                          );
                    },
                    child: const Text('Load json 2')),
              ],
            ),
            BlocBuilder<PersonsBloc, FetchResult?>(
              buildWhen: (previousResult, currentResult) {
                return previousResult?.persons != currentResult?.persons;
              },
              builder: ((context, fetchResult) {
                fetchResult?.log();
                final persons = fetchResult?.persons;
                if (persons == null) {
                  return const SizedBox();
                }
                return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: persons.length,
                    itemBuilder: (_, __) {
                      return ExpansionTile(title: Text(persons[__]!.name));
                    });
              }),
            ),
          ],
        ),
      ),
    );
  }
}
