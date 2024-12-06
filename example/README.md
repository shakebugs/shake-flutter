# Shake SDK Example

Demonstrates how to use the Shake plugin.

## Running the project

Example app can be run in two environments: **staging** and **production**

Use the following commands to run example app:

Staging:
`ANDROID_DEPENDENCY=com.shakebugs:shake-staging && flutter run android -t lib/main.dart --flavor staging`
`IOS_DEPENDENCY=Shake-Staging && flutter run ios -t lib/main.dart --flavor staging`

Production:
`ANDROID_DEPENDENCY=com.shakebugs:shake && flutter run android -t lib/main.dart --flavor production`
`IOS_DEPENDENCY=Shake && flutter run ios -t lib/main.dart --flavor production`

Or you can simply run app from Intellij run configurations.

## Push notifications

Example project contains Google Play services json and plist generated from Firebase in order
to test Push notifications.

## Shake SDK

Example app is connected to the local Shake SDK package through **pubspec.yaml** file.