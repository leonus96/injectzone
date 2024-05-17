/// Contains an [value] and the [type] to override a dependency
class ValueInjector<T> {
  final Type type;
  final T value;

  /// Injects the [value] to be overwritten
  static inject<T>(T value) {
    return ValueInjector._(T, value);
  }

  const ValueInjector._(this.type, this.value);
}
