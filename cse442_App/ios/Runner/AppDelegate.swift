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

    // Google API Key
    GMSServices.provideAPIKey("AIzaSyAE7YNpOSkVQVqNL__3TKSjRCfI7a0DJpM")
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
