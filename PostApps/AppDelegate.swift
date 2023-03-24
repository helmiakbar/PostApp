//
//  AppDelegate.swift
//  PostApps
//
//  Created by tamu on 24/03/23.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        makeViewAndSetupAppearance()
        return true
    }
    
    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "PostApps")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {

                fatalError("Unresolved error, \((error as NSError).userInfo)")
            }
        })
        return container
    }()
}

extension AppDelegate {
    func makeViewAndSetupAppearance() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let homeVC = HomeViewController(nibName:"HomeViewController", bundle:nil)
        let navVC = UINavigationController(rootViewController: homeVC)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }
}

