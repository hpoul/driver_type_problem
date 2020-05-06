// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Test App', () {
    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('Enter value', () async {
      final testValue = 'Loerm Ipsum';
      await Future.delayed(const Duration(seconds: 2));
      await driver.tap(find.text('Click Me'));
      await Future.delayed(const Duration(seconds: 2));
      await driver.enterText(testValue);
      await driver.tap(find.text('Ok'));
      final result = await driver.getText(find.byValueKey('result'));
      expect(result, testValue);
    });
  });
}
