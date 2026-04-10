# Shake SDK Example

Demonstrates how to use the Shake plugin.

## Running the project

Example app can be run in two environments: **staging** and **production**

Environment variables are used to configure native Shake dependency. On CI those dependencies are replaced directly.
Version of native Shake is hardcoded.

Run project through Run configurations from example directory or use the following commands to run example app:

## Staging:
```
 ANDROID_DEPENDENCY=com.shakebugs:shake-staging
 IOS_SHAKE_COCOAPOD_PACKAGE=Shake-Staging
 IOS_SHAKE_SPM_URL=git@github.com:shakebugs/shake-ios-staging.git
 IOS_SHAKE_SPM_PACKAGE=shake-ios-staging
```

Then run
```
flutter run -t lib/main.dart --flavor staging
```

## Production
```
 ANDROID_DEPENDENCY=com.shakebugs:shake
 IOS_SHAKE_COCOAPOD_PACKAGE=Shake
 IOS_SHAKE_SPM_URL=https://github.com/shakebugs/shake-ios.git
 IOS_SHAKE_SPM_PACKAGE=shake-ios
```

Then run: 
```
flutter run -t lib/main.dart --flavor production
```


Note: The project is currently configured to use Cocoapods for iOS dependencies. In the future this will be removed from Flutter so will need to be removed from example also.
It is still available in the project for testing purposes.

## Push notifications

Example project contains Google Play services json and plist generated from Firebase in order
to test Push notifications.

## Shake SDK

Example app is connected to the local Shake SDK package through **pubspec.yaml** file.