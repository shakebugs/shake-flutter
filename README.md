# Shake for Flutter

Flutter plugin for [Shake](https://www.shakebugs.com).

## How to use

### Install Shake

Add Shake to your `pubspec.yaml` file.
```yaml
dependencies:
      shake_flutter: ^15.0.0
```

Install package by running command in terminal.
```bash
flutter packages get
```

## Start Shake

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

## Documentation

Visit [documentation](https://www.shakebugs.com/docs) for more details.