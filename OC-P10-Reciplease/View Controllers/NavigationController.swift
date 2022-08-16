//
//  ViewController.swift
//  OC-P10-Reciplease
//
//  Created by Walim Aloui on 13/08/2022.
//

import UIKit

class NavigationController : UINavigationController, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        QuickActionHandler.shared.configDynamicQuickActions()
        view.backgroundColor = .systemGray5
        UINavigationBar.appearance().barTintColor = .systemGray5
        
        guard let font = UIFont(name: "Chalkduster", size: 20) else {return}
        UINavigationBar.appearance().titleTextAttributes = [.font: font, .foregroundColor: UIColor.label]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        guard
            let appDelegate  = UIApplication.shared.delegate as? AppDelegate,
            let shortcutItem = appDelegate.launchedShortcutItem
        else {return}
        
        QuickActionHandler.shared.handleQuickAction(shortcutItem)
    }
}
