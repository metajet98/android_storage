import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:android_storage/android_storage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await AndroidStorage.platformVersion;
      print(await AndroidStorage.getExternalStoragePublicDirectory(AndroidStorage.DIRECTORY_DOWNLOADS));
      print(await AndroidStorage.getExternalStoragePublicDirectory(AndroidStorage.DIRECTORY_ALARMS));
      print(await AndroidStorage.getExternalStoragePublicDirectory(AndroidStorage.DIRECTORY_AUDIOBOOKS));
      print(await AndroidStorage.getExternalStoragePublicDirectory(AndroidStorage.DIRECTORY_DCIM));
      print(await AndroidStorage.getExternalStoragePublicDirectory(AndroidStorage.DIRECTORY_DOCUMENTS));
      print(await AndroidStorage.getExternalStoragePublicDirectory(AndroidStorage.DIRECTORY_MOVIES));
      print(await AndroidStorage.getExternalStoragePublicDirectory(AndroidStorage.DIRECTORY_MUSIC));
      print(await AndroidStorage.getExternalStoragePublicDirectory(AndroidStorage.DIRECTORY_NOTIFICATIONS));
      print(await AndroidStorage.getExternalStoragePublicDirectory(AndroidStorage.DIRECTORY_PICTURES));
      print(await AndroidStorage.getExternalStoragePublicDirectory(AndroidStorage.DIRECTORY_PODCASTS));
      print(await AndroidStorage.getExternalStoragePublicDirectory(AndroidStorage.DIRECTORY_RINGTONES));
      print(await AndroidStorage.getExternalStoragePublicDirectory(AndroidStorage.DIRECTORY_SCREENSHOTS));
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}
