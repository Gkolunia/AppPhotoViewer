//
//  AppDelegate.swift
//  AppPhotoViewer
//
//  Created by Hrybeniuk Mykola on 8/11/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    /// Main coordinator of the app.
    var appCoordinator : AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        if let rootWindow = window {
            appCoordinator = AppCoordinator(rootWindow)
            appCoordinator?.start()
        }
        return true
    }

}

