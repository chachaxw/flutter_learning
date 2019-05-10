import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  var imageView: UIImageView?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
//    NotificationCenter.default.addObserver(
//      forName: UIApplication.userDidTakeScreenshotNotification,
//      object: nil,
//      queue: .main) { notification in
//        //executes after screenshot
//        print("Notification center测试", notification)
//    }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

//  override func applicationWillResignActive(_ application: UIApplication) {
//    // Sent when the application is about to move from active to inactive state.
//    // This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message)
//    // or when the user quits the application and it begins the transition to the background state.
//    // Use this method to pause ongoing tasks, disable timers,
//    // and invalidate graphics rendering callbacks. Games should use this method to pause the game.
//    imageView = UIImageView.init(image: UIImage.init(named: "LaunchImage"))
//    self.window?.addSubview(imageView!)
//  }
//
//  override func applicationDidBecomeActive(_ application: UIApplication) {
//    if imageView != nil {
//      imageView?.removeFromSuperview()
//      imageView = nil
//    }
//  }

}
