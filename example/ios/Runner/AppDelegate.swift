import UIKit
import Flutter
import Shake

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      let center = UNUserNotificationCenter.current()
      center.delegate = self

      // Request notifications permission to enabled chat notifications
      center.requestAuthorization(options: [.sound,.alert,.badge]) { (granted, error) in
                      if granted {
                          print("Notification Enable Successfully")
                      }else{
                          print("Some Error Occure")
                      }
                  }
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
      if response.notification.request.content.categoryIdentifier.contains(SHKNotificationCategoryIdentifierDomain) {
          Shake.report(center, didReceive: response, withCompletionHandler: completionHandler)
          return;
      }

      completionHandler()
  }

  override func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
      if notification.request.content.categoryIdentifier.contains(SHKNotificationCategoryIdentifierDomain) {
          Shake.report(center, willPresent: notification, withCompletionHandler: completionHandler)
          return;
      }

      completionHandler([.badge, .sound, .alert])
  }
}
