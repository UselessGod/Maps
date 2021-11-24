//
//  AppDelegate.swift
//  MyMaps
//
//  Created by Дмитрий Емельянов on 03.11.2021.
//

import UIKit
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GMSServices.provideAPIKey("AIzaSyCijzKtgFutUMsyrERvO0QEYjcGz9CRzKg")
        
//        NotificationService.shared.request()
        
        NotificationService.shared.checkForAuth {
            switch $0 {
            case .authorized:
                NotificationService.shared.sendNotificatioRequest()
            default: break
            }
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }
    
    func  applicationWillResignActive(_ application: UIApplication) {

        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = window!.frame

        self.window?.addSubview(blurEffectView)

    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        self.window?.removeFromSuperview()
    }

}

