import UIKit
import Flutter
import Shake
import FirebaseCore

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        UNUserNotificationCenter.current().delegate = self

        UIApplication.shared.registerForRemoteNotifications()
        
        FirebaseApp.configure()

        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Shake.didRegisterForRemoteNotifications(withDeviceToken: deviceToken)
    }

    override func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if Shake.isShakeNotification(response.notification) {
            Shake.report(center, didReceive: response, withCompletionHandler: completionHandler)
            return;
        }

        completionHandler()
    }

    override func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        if Shake.isShakeNotification(notification) {
            Shake.report(center, willPresent: notification, withCompletionHandler: completionHandler)
            return;
        }

        completionHandler([.badge, .sound, .alert])
    }
}
