import 'package:injectzone/injectzone.dart';
import 'package:test/test.dart';

void main() {
  group('$Injectzone tests', () {
    test('Uses builder when no inject', () {
      final result = Injectzone().inject(() => 'aoeu');

      expect(result, 'aoeu');
    });

    test('Injected within injected sync', () {
      Injectzone().withInjected([ValueInjector.inject('ueoa')], () {
        Injectzone().withInjected([ValueInjector.inject('snth')], () {
          expect(Injectzone().inject(() => 'aoeu'), 'snth');
        });
        expect(Injectzone().inject(() => 'aoeu'), 'ueoa');
      });
      expect(Injectzone().inject(() => 'aoeu'), 'aoeu');
    });

    test('Injected within injected async', () async {
      await Injectzone().withInjected([ValueInjector.inject('ueoa')], () async {
        await Injectzone().withInjected([ValueInjector.inject('snth')],
            () async {
          await Future.microtask(
              () => expect(Injectzone().inject(() => 'aoeu'), 'snth'));
        });
        await Future.microtask(
            () => expect(Injectzone().inject(() => 'aoeu'), 'ueoa'));
      });
      expect(Injectzone().inject(() => 'aoeu'), 'aoeu');
    });

    test('Mixed type injections', () {
      Injectzone().withInjected([ValueInjector.inject(2)], () {
        Injectzone().withInjected([ValueInjector.inject('snth')], () {
          // Inner zone mixes with outer zone.
          expect(Injectzone().inject(() => 1), 2);
          expect(Injectzone().inject(() => 'aoeu'), 'snth');
        });
      });
    });
  });
}
