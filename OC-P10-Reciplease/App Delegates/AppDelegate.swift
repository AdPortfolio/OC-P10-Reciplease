//
//  AppDelegate.swift
//  OC-P10-Reciplease
//
//  Created by Walim Aloui on 13/08/2022.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: - Properties
    var window: UIWindow?
    
    // MARK: -
    private let appCoordinator = AppCoordinator()
    var launchedShortcutItem: UIApplicationShortcutItem?
    
    // MARK: Data Properties
    lazy var coreDataStack = PersistenceController.shared
    
    // MARK: - Application Life Cycle
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = appCoordinator.rootViewController
        window?.makeKeyAndVisible()
        appCoordinator.start()
        
        // Quick Actions
        if let shortcutItem = launchOptions?[UIApplication.LaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem {
            if shortcutItem.type == "adpiscinam.OC-P10-Reciplease.FavoritesSC" {
                launchedShortcutItem = shortcutItem
                return false
            }
        }
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        do {
            try coreDataStack.container.viewContext.save()
        } catch {}
    }
    
    var orientationLock = UIInterfaceOrientationMask.portrait
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return self.orientationLock
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
    }
}
