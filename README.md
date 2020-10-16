# Shake for Flutter

Flutter plugin for [Shake](https://www.shakebugs.com).

## How to use

### Install Shake

Add Shake to your `pubspec.yaml` file.
```yaml
dependencies:
      shake_flutter: ^10.0.0
```

Install package by running command in terminal.
```bash
flutter packages get
```

## Add Client ID and Secret
Client ID and Secret are visible in [your workspace settings](https://app.shakebugs.com/settings/workspace#general).

Add Client ID and Secret to the `AndroidManifest.xml` file.
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <application
            android:allowBackup="true"
            android:icon="@mipmap/ic_launcher"
            android:label="@string/app_name"
            android:theme="@style/AppTheme" >
        ...
        <meta-data
                android:name="com.shakebugs.APIClientID"
                android:value="your-api-client-id" />
        <meta-data
                android:name="com.shakebugs.APIClientSecret"
                android:value="your-api-client-secret" />
    </application>
</manifest>
```

Add Client ID and Secret to the `Info.plist` file.
```xml
<?xml version="1.0" encoding="utf-8" ?>
<plist version="1.0">
<dict>
    ...
    <key>Shake</key>
    <dict>
        <key>APIClientID</key>
        <string>your-api-client-id</string>
        <key>APIClientSecret</key>
        <string>your-api-client-secret</string>
    </dict>
</dict>
</plist>
```

## Start Shake

Add Shake import.
```dart
import 'package:shake_flutter/shake_flutter.dart';
```

Call `Shake.start()` method.
```dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Shake.setInvokeShakeOnShakeDeviceEvent(true);
  Shake.setShowFloatingReportButton(false);
  Shake.setInvokeShakeOnScreenshot(false);

  Shake.start();

  runApp(MyApp());
}
```

## Documentation

Visit [documentation](https://www.shakebugs.com/docs) for more details.