//
//  QuickActionHandler.swift
//  OC-P10-Reciplease
//
//  Created by Walim Aloui on 15/08/2022.
//

import UIKit

enum ApplicationShortcutItemType:String {
    case favorites     = "UIApplicationShortcutIconTypeFavorite"
    case scan = "camera.metering.none"
}

enum ApplicationShortcutItemTitle:String {
    case favorites     = "Favorites"
    case scan = "Scan Ingredients"
}

final class QuickActionHandler {
    
    //MARK: - Shared Instance
    static let shared = QuickActionHandler()
    private init() {}
    
    //MARK: - Config/Add
    func configDynamicQuickActions() {
        QuickActionHandler.shared.clearQuickActions()
        addFavoritesQuickAction()
        addSavedItemsAction()
    }
    
    private func addFavoritesQuickAction() {
        removeFavoritesQuickAction()
        let favoritesItem = UIApplicationShortcutItem(type: ApplicationShortcutItemType.favorites.rawValue,
                                                      localizedTitle: ApplicationShortcutItemTitle.favorites.rawValue,
                                                      localizedSubtitle: "",
                                                      icon: UIApplicationShortcutIcon(type: .favorite),
                                                      
                                                      userInfo: nil)
        var shortcutItems = UIApplication.shared.shortcutItems ?? []
        shortcutItems.append(favoritesItem)
        UIApplication.shared.shortcutItems = shortcutItems
    }
    
    private func addSavedItemsAction() {
        removeScanQuickAction()
        let scanItem = UIApplicationShortcutItem(type: ApplicationShortcutItemType.scan.rawValue,
                                                 localizedTitle: ApplicationShortcutItemTitle.scan.rawValue,
                                                 localizedSubtitle: "",
                                                 icon: UIApplicationShortcutIcon(systemImageName: "camera.metering.none"),
                                                 userInfo: nil)
      
        var shortcutItems = UIApplication.shared.shortcutItems ?? []
        shortcutItems.append(scanItem)
        UIApplication.shared.shortcutItems = shortcutItems
    }
    
    //MARK: - Remove/ClearAll
    
    private func removeFavoritesQuickAction() {
        var shortcutItems = UIApplication.shared.shortcutItems ?? []
        for (index, item) in shortcutItems.enumerated() {
            if item.type == ApplicationShortcutItemType.favorites.rawValue {
                shortcutItems.remove(at: index)
            }
        }
        UIApplication.shared.shortcutItems = shortcutItems
    }
    
    private func removeScanQuickAction() {
        var shortcutItems = UIApplication.shared.shortcutItems ?? []
        for (index, item) in shortcutItems.enumerated() {
            if item.type == ApplicationShortcutItemType.scan.rawValue {
                shortcutItems.remove(at: index)
            }
        }
        UIApplication.shared.shortcutItems = shortcutItems
    }
    
    private func clearQuickActions() {
        UIApplication.shared.shortcutItems = []
    }
    
    //MARK: - Handle the Action
    func handleQuickAction(_ shortcutItem:UIApplicationShortcutItem) {
        guard let actionType = ApplicationShortcutItemType(rawValue: shortcutItem.type) else { return }
        
        switch actionType {
        case .favorites:
         //   print("Handle Favorites1 action")
            NotificationCenter.default.post(name: Notification.Name("FavoritesQA"), object: nil, userInfo: nil)
        case .scan:
        //    print("Handle Scan1 action")
            NotificationCenter.default.post(name: Notification.Name("ScanQA"), object: nil, userInfo: nil)
        }
    }
}
