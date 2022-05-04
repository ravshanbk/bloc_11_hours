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

  @override
  bool operator ==(covariant AppState6 other) =>
      isLoading == other.isLoading &&
      (data ?? []).isEqualTo(other.data ?? []) &&
      error == other.error;

  @override
  int get hashCode => Object.hash(
        isLoading,
        data,
        error,
      );
}

extension Comparison<E> on List<E> {
  bool isEqualTo(List<E> other) {
    if (identical(this, other)) {
      return true;
    }
    if (length != other.length) {
      return false;
    }
    for (int i = 0; i < length; i++) {
      if (this[i] != other[1]) {
        return false;
      }
    }
    return true;
  }
}
