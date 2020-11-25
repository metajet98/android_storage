import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:android_storage/android_storage.dart';

void main() {
  const MethodChannel channel = MethodChannel('android_storage');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await AndroidStorage.platformVersion, '42');
  });
}
