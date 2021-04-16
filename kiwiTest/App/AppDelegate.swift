//
//  AppDelegate.swift
//  kiwiTest
//
//  Created by Pavle Mijatovic on 15.4.21..
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var coordinator: MainCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setRootVC()
        return true
    }
    
    func setRootVC() {
        let navController = UINavigationController()
        navController.navigationBar.tintColor = UIColor.red
        
        
        coordinator = MainCoordinator(navigationController: navController)
        coordinator?.start()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
}

