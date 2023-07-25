//
//  AppDelegate.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 20/07/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var restrictRotation:UIInterfaceOrientationMask = .portrait

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        if #available(iOS 13.0, *) {
            self.window?.overrideUserInterfaceStyle = .light
        }
//
//        if #available(iOS 13.0, *) {
//            UIApplication.shared.statusBarStyle = .darkContent
//        } else {
//            UIApplication.shared.statusBarStyle = .default
//        }
        
        let splashController = SplashController()
        window?.rootViewController = UINavigationController(rootViewController: splashController)
        
        return true
    }
}

