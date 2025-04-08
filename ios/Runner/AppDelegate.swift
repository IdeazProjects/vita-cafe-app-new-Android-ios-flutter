import UIKit
import Flutter
import GoogleMaps
import Firebase
import FirebaseMessaging



@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      if #available(iOS 12.0, *) {
            UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
          }
    //Add your Google Maps API Key here
    GMSServices.provideAPIKey("AIzaSyAabz1rIThfaX5MdXELFjP61MB7L47D6yI")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    override func application(_ application: UIApplication,
     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

      Messaging.messaging().apnsToken = deviceToken
      print("Token: \(deviceToken)")
      super.application(application,
      didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }
}




// // import UIKit
// // import Flutter

// // @UIApplicationMain
// // @objc class AppDelegate: FlutterAppDelegate {
// //   override func application(
// //     _ application: UIApplication,
// //     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
// //   ) -> Bool {
// //     GeneratedPluginRegistrant.register(with: self)
// //     return super.application(application, didFinishLaunchingWithOptions: launchOptions)
// //   }
// // }

// import UIKit
// import Flutter
// import GoogleMaps

// @UIApplicationMain
// @objc class AppDelegate: FlutterAppDelegate {
//   override func application(
//     _ application: UIApplication,
//     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//   ) -> Bool {
//      GMSServices.provideAPIKey("AIzaSyAabz1rIThfaX5MdXELFjP61MB7L47D6yI")
//     GeneratedPluginRegistrant.register(with: self)
//     return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//   }
// }