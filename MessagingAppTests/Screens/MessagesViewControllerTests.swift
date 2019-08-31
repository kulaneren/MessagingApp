//
//  MessagesViewControllerTests.swift
//  MessagingAppTests
//
//  Created by eren on 31.08.2019.
//  Copyright © 2019 Eren Kulan. All rights reserved.
//

import XCTest

@testable import MessagingApp

class MessagesViewControllerTests: XCTestCase {

    var messagesViewController: MessagesViewController!
    var navigationController: UINavigationController!
    var apiClientFake = APIClientFake()

    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        messagesViewController = storyboard.instantiateViewController(withIdentifier: "MessagesViewController") as? MessagesViewController
        messagesViewController.nickName = "name"
        navigationController = UINavigationController(rootViewController: messagesViewController)
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.rootViewController = navigationController
        _ = messagesViewController.view
    }

    override func tearDown() {
        messagesViewController = nil
        navigationController = nil
        apiClientFake.returnError = false
    }

    func testViewDidLoad() {
        XCTAssertFalse(navigationController.isNavigationBarHidden)
        XCTAssertEqual(navigationController.navigationBar.topItem?.title, "name")
    }

    func testGetMessages_success() {
        messagesViewController.getMessages(withAPIClient: apiClientFake)
        let rowsCount = messagesViewController.tblMessages.numberOfRows(inSection: 0)
        XCTAssertEqual(rowsCount, 5)
    }

    func testGetMessages_fail() {
        apiClientFake.returnError = true
        messagesViewController.getMessages(withAPIClient: apiClientFake)
        XCTAssertTrue(messagesViewController.presentedViewController!.isKind(of: UIAlertController.self))
    }

    func testBtnSendTapped() {
        messagesViewController.getMessages(withAPIClient: apiClientFake)
        messagesViewController.btnSendTapped(nil)
        let rowsCount = messagesViewController.tblMessages.numberOfRows(inSection: 0)
        XCTAssertEqual(rowsCount, 6)
    }

}
