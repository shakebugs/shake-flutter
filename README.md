# Shake for Flutter

This package is a wrapper for [Shake](https://www.shakebugs.com) bug reporting tool.

## How to use

### Install Shake

Add a Shake to your project.
```yaml
dependencies:
      shake_flutter:
```

Install package by running command.
```bash
flutter packages get
```

## Add API Client and Secret keys

Add keys to the *AndroidManifest.xml* file.
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

Add keys to the *Info.plist* file.
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

Call *Shake.start()* method.
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

Visit [documentation](https://www.shakebugs.com/docs) web page for more details.