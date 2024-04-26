//
//  AppDelegate.swift
//  FusionSolar
//
//  Created by Maxim Zavzin on 20/07/23.
//

import UIKit
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var restrictRotation:UIInterfaceOrientationMask = .portrait
    let googleKey = "AIzaSyB66_T58kU51Ss_7-Mln0ou5el3dHtLwAU"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        GMSServices.provideAPIKey(googleKey)
        
        if #available(iOS 13.0, *) {
            self.window?.overrideUserInterfaceStyle = .light
        }

        let splashController = SplashController()
        window?.rootViewController = UINavigationController(rootViewController: splashController)
        
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return .portrait
    }
}

