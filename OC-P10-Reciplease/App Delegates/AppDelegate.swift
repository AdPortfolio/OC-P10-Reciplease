//
//  AppDelegate.swift
//  OC-P10-Reciplease
//
//  Created by Walim Aloui on 13/08/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: - Properties
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ViewController()
        //   window?.windowScene?.statusBarManager?.statusBarStyle = .lightContent
        window?.makeKeyAndVisible()
        return true
    }
}