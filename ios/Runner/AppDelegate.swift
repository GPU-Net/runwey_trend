import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
     if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
    }
    
     GeneratedPluginRegistrant.register(with: self)
     return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

// import UIKit
// import Flutter
// // This is required for calling FlutterLocalNotificationsPlugin.setPluginRegistrantCallback method.
// import flutter_local_notifications

// @UIApplicationMain
// override func application(
//   _ application: UIApplication,
//   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//   ) -> Bool {
//   // This is required to make any communication available in the action isolate.
//   FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
//     GeneratedPluginRegistrant.register(with: registry)
//   }

//   ...
//   return super.application(application, didFinishLaunchingWithOptions: launchOptions)
// }