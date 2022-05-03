import 'package:bloc11hours/models.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class NotesApiProticol {
  const NotesApiProticol();

  Future<Iterable<Note>?> getNotes({
    required LoginHandle loginHandle,
  });
}

class NotesApi implements NotesApiProticol {
  @override
  Future<Iterable<Note>?> getNotes({
    required LoginHandle loginHandle,
  }) =>
      Future.delayed(
        Duration(seconds: 2),()=>loginHandle == const LoginHandle.fooBar()? mockNotes: null,
      );
}
