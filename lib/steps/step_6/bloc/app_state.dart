import 'dart:typed_data' show Uint8List;

import 'package:flutter/foundation.dart' show immutable;

@immutable
class AppState6 {
  final bool isLoading;
  final Uint8List? data;
  final Object? error;

  const AppState6({
    required this.isLoading,
    required this.data,
    required this.error,
  });
  const AppState6.empty()
      : isLoading = false,
        data = null,
        error = null;

  @override
  String toString() => {
        'isLoading': isLoading,
        'hasData': data != null,
        'error': error,
      }.toString();
}
