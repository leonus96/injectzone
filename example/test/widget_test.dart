import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:example/main.dart';
import 'package:injectzone/injectzone.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('Inject zone example tests', () {
    testWidgets('No info', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      expect(find.text('-'), findsOneWidget);
    });

    testWidgets('Get info', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      expect(find.text('-'), findsOneWidget);

      final deviceInfoPlugin = MockDeviceInfoPlugin();
      when(() => deviceInfoPlugin.iosInfo)
          .thenAnswer((_) => Future.value(IosDeviceInfo.fromMap({
                'name': 'iPhone de Joseph',
                'systemName': 'iOS',
                'systemVersion': '39',
                'model': 'iPhone 21',
                'localizedModel': 'iPhone 21',
                'isPhysicalDevice': true,
                'utsname': {
                  'sysname': 'iOS',
                  'nodename': 'iOS',
                  'release': '38.9.2',
                  'version': 'v39',
                  'machine': 'main',
                }
              })));

      await Injectzone().withInjected([
        ValueInjector.inject<DeviceInfoPlugin>(deviceInfoPlugin),
      ], () async {
        await tester.tap(find.byIcon(Icons.search));
        await tester.pumpAndSettle();
      });

      expect(find.text('iPhone de Joseph'), findsOne);
    });
  });
}

class MockDeviceInfoPlugin extends Mock implements DeviceInfoPlugin {}
