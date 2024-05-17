<p align="center">
    <img alt="injectzone" width="200px" src="https://github.com/leonus96/injectzone/assets/9968005/1b10d362-dc7e-4ed1-92eb-134020717860">
</p>

Injeczone is a simple and lightweight dependency injection library for Dart that allows you to override dependencies via
your type.

Internally Injectzone uses zones and the `zoneValues` attribute to create or return injected dependencies.

## Usage

To use this package, add injectzone as a dependency in your pubspec.yaml file.

1. Inject `T` dependency from `builder` function:

```dart

final deviceInfo = Injectzone().inject(() => DeviceInfoPlugin());

/// Note: [DeviceInfoPlugin] is a third party dependency
```

2. Override `T` dependency with mock by `ValueInjector` during `callback` execution:
```dart
await Injectzone().withInjected([
  ValueInjector.inject<DeviceInfoPlugin>(mockDeviceInfoPlugin),
], () {
  ///... my test code
});
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/leonus96/injectzone/issues
