import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      GMSServices.provideAPIKey("AIzaSyAYCCyc7K0mrVv893nGX1s2eLNJbyqgz0I");
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
