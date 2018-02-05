//
//  AppDelegate.swift
//  News
//
//  Created by Danil Mironov on 03.02.18.
//  Copyright © 2018 Danil Mironov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        showMainScreen(false)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
}

extension AppDelegate {
    
    func showMainScreen(_ animated: Bool = true) {
        if window == nil {
            window = UIWindow(frame: UIScreen.main.bounds)
        }

        var mainScreen: UIViewController?
        mainScreen = AppFlowCoordinator().launchViewController()
        
        makeRoot(viewController: mainScreen, animated: animated)
    }
    
    func makeRoot(viewController: UIViewController?, animated: Bool = true) {
        guard let viewController = viewController else { return }
        if let strongWindow = window {
            if animated {
                UIView.transition(
                    with: strongWindow,
                    duration: 0.3,
                    options: [.curveEaseInOut, .transitionCrossDissolve, .preferredFramesPerSecond60],
                    animations: { [weak strongWindow] in
                        strongWindow?.rootViewController = viewController
                    },
                    completion: nil
                )
            } else {
                strongWindow.rootViewController = viewController
                strongWindow.makeKeyAndVisible()
            }
        }
    }

}
