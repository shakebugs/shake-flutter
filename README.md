# Shake Flutter SDK

[![pub package](https://img.shields.io/pub/v/shake_flutter)](https://pub.dev/packages/shake_flutter)

Flutter plugin for [bug reporting](https://www.shakebugs.com).

## Features

|     Feature     | Available |
|:---------------:|:---------:|
|  Bug reporting  |     ✅     |
| Crash reporting |     ❌     |
|      Users      |     ✅     |

## Requirements

| Platform | Version |
|:----------:|:---------:|
| Flutter  |   1.12  |
| Android  |   7.0   |
| iOS      |   12.0  |

## How to use

### Install Shake

Add Shake to your `pubspec.yaml` file.
```yaml
dependencies:
      shake_flutter: ^17.0.0
```

Install package by running command in terminal.
```bash
flutter packages get
```

### Start Shake

Call `Shake.start()` method in the `main.dart` file.
```dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shake_flutter/shake_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  String apiKey = Platform.isIOS ? 'ios-app-api-key' : 'android-app-api-key';
  Shake.start(apiKey);

  runApp(MyApp());
}
```

Replace `ios-app-api-key` and `android-app-api-key` with the actual values you have in your app settings.

## Resources

- [Official docs](https://www.shakebugs.com/docs/)