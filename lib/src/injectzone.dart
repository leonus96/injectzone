import 'dart:async';

import 'package:injectzone/src/value_injector.dart';

/// Provides dependency injection and overriding using zones.
class Injectzone {
  /// Create Injectzone const instance.
  factory Injectzone() => const Injectzone._();

  const Injectzone._();

  /// Inject [T] dependency from [builder] function
  /// For example:
  ///   final deviceInfo = Injectzone().inject(() => DeviceInfoPlugin());
  T inject<T>(T Function() builder) => _injectObject(() => builder());

  T _injectObject<T>(T Function() builder) => Zone.current[T] ?? builder();

  /// Override [T] dependency with iterable [ValueInjector]s  during
  /// callback execution
  /// For example:
  ///   await Injectzone().withInjected([
  ///     ValueInjector.inject<DeviceInfoPlugin>(deviceInfoPlugin),
  ///   ], () async {
  ///     ... my test code
  ///   });
  dynamic withInjected(
    Iterable<ValueInjector> values,
    dynamic Function() callback,
  ) {
    return runZoned(
      callback,
      zoneValues: {for (var v in values) v.type: v.value},
    );
  }
}
