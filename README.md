# Shake Flutter SDK

[![pub package](https://img.shields.io/pub/v/shake_flutter)](https://pub.dev/packages/shake_flutter)

Flutter plugin for [bug reporting](https://www.shakebugs.com).

## Features

|     Feature     | Avaliable |
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
      shake_flutter: ^15.1.0
```

Install package by running command in terminal.
```bash
flutter packages get
```

### Start Shake

Add Shake import.
```dart
import 'package:shake_flutter/shake_flutter.dart';
```

Call `Shake.start()` method in the `main.dart` file.
```dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Shake.setInvokeShakeOnShakeDeviceEvent(true);
  Shake.setShowFloatingReportButton(false);
  Shake.setInvokeShakeOnScreenshot(false);

  Shake.start('client-id', 'client-secret');

  runApp(MyApp());
}
```

Replace `client-id` and `client-secret` with the actual values you have in [your workspace settings](https://app.shakebugs.com/settings/workspace#general).

## Resources

- [Official docs](https://www.shakebugs.com/docs/)