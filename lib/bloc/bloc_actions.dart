import 'package:bloc11hours/bloc/person.dart';
import 'package:flutter/foundation.dart' show immutable;

// enum PersonUrl {
//   person1,
//   person2,
// }

// extension UrlString on PersonUrl {
//   String get urlString {
//     switch (this) {
//       case PersonUrl.person1:
//         return 'http://192.168.1.6:5500/api/person_1.json';
//       case PersonUrl.person2:
//         return 'http://192.168.1.6:5500/api/person_2.json';
//     }
//   }
// }

const person1Url = 'http://192.168.1.6:5500/api/person_1.json';
const person2Url = 'http://192.168.1.6:5500/api/person_2.json';

typedef PersonsLoader = Future<Iterable<Person>> Function(String url);

@immutable
abstract class LoadAction {
  const LoadAction();
}

@immutable
class LoadPersonsAction implements LoadAction {
  final String url;
  final PersonsLoader loader;

  const LoadPersonsAction({
    required this.url,
    required this.loader,
  }) : super();
}
