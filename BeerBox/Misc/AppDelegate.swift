//
//  AppDelegate.swift
//  BeerBox
//
//  Created by Кузяев Максим on 14.02.16.
//  Copyright © 2016 zefender. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)

        window!.rootViewController = ShadowNavigationController(rootViewController:  PopularViewController())
        window!.makeKeyAndVisible()

        return true
    }
}

