//
//  LoginViewControllerTests.swift
//  MessagingAppTests
//
//  Created by eren on 31.08.2019.
//  Copyright © 2019 Eren Kulan. All rights reserved.
//

import XCTest

@testable import MessagingApp

class LoginViewControllerTests: XCTestCase {

    var loginViewController: LoginViewController!
    var navigationController: UINavigationController!

    override func setUp() {
        UserDefaults.standard.set(nil, forKey: UserData.Nickname)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
        navigationController = UINavigationController(rootViewController: loginViewController)
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.rootViewController = navigationController
        _ = loginViewController.view
    }

    override func tearDown() {
        loginViewController = nil
        navigationController = nil
        UserDefaults.standard.set(nil, forKey: UserData.Nickname)
    }

    func testBtnLoginTapped_success() {
        loginViewController.txtNickname.text = "name"
        loginViewController.btnLoginTapped(nil)
        let username = UserDefaults.standard.value(forKey: UserData.Nickname) as? String
        XCTAssertEqual(username, "name")
    }

    func testBtnLoginTapped_fails() {
        loginViewController.txtNickname.text = "na"
        loginViewController.btnLoginTapped(nil)
        XCTAssertTrue(loginViewController.presentedViewController!.isKind(of: UIAlertController.self))
    }

}
