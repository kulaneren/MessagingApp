//
//  UIViewController+AlertTests.swift
//  MessagingAppTests
//
//  Created by eren on 31.08.2019.
//  Copyright © 2019 Eren Kulan. All rights reserved.
//

import XCTest

@testable import MessagingApp

class UIViewControllerAlertTests: XCTestCase {

    func testShowAlert() {
        let viewController = UIViewController()
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.rootViewController = viewController
        let alertAction = UIAlertAction(title: "alertTitle",
                                        style: .default,
                                        handler: nil)
        viewController.showAlert(title: "title",
                                 message: "message",
                                 actions: [alertAction])
        XCTAssertTrue(viewController.presentedViewController!.isKind(of: UIAlertController.self))
    }

}
