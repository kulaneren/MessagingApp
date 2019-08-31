//
//  AppDelegate.swift
//  MessagingApp
//
//  Created by eren on 31.08.2019.
//  Copyright © 2019 Eren Kulan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if let nickname = UserDefaults.standard.value(forKey: UserData.Nickname) as? String {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            // swiftlint:disable force_cast
            let messagesViewController = storyboard.instantiateViewController(withIdentifier: "MessagesViewController") as! MessagesViewController
            messagesViewController.nickName = nickname
            let navigationController = UINavigationController(rootViewController: messagesViewController)
            window!.rootViewController = navigationController
            window!.makeKeyAndVisible()
        }
        return true
    }

}
