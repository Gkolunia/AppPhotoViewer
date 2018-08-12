//
//  AppCoordinator.swift
//  AppPhotoViewer
//
//  Created by Hrybeniuk Mykola on 8/12/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import UIKit

///Protocol defines common interface for all child cordinators
protocol CoordinatorProtocol {
    
    /// Method which starts navigation in current coordinator
    ///
    /// - Parameter navigationController: root navigation controller.
    func start(from navigationController: UINavigationController)
}

///The class provides root navigation for child coordinators.
class AppCoordinator {
    
    /// childCoordinator keeps reference on last coordinator
    var childCoordinator : CoordinatorProtocol?
    
    private let rootWindow : UIWindow
    private let rootNavigationController : UINavigationController = UINavigationController()
    
    init(_ defaultWindow: UIWindow) {
        rootWindow = defaultWindow
        rootWindow.rootViewController = rootNavigationController
        rootWindow.makeKeyAndVisible()
        rootNavigationController.view.backgroundColor = .white
    }
    
    func start() {
        // Start child controller.

    }
    
}
