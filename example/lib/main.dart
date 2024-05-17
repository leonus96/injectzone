import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:injectzone/injectzone.dart';

/// In this example we inject a third-party dependency  (DeviceInfoPlugin)
/// with Injectzone and replace the dependency with a mock class in the tests.
/// Note: check widget_test.dart file.
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String infoString = '-';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Injectzone'),
        ),
        body: Center(
          child: Text(infoString),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final info = await _getInfoPlus();
            setState(() {
              infoString = info;
            });
          },
          child: const Icon(Icons.search),
        ),
      ),
    );
  }

  Future<String> _getInfoPlus() async {
    /// DeviceInfoPlugin injection
    final deviceInfo = Injectzone().inject(() => DeviceInfoPlugin());

    return (await deviceInfo.iosInfo).name;
    // return (await deviceInfo.androidInfo).model;
  }
}
