//
//  MessagingBubbleTests.swift
//  MessagingAppTests
//
//  Created by eren on 31.08.2019.
//  Copyright © 2019 Eren Kulan. All rights reserved.
//

import XCTest

@testable import MessagingApp

class MessageBubbleTests: XCTestCase {

    var messageBubble: MessageBubble!

    override func setUp() {
        super.setUp()
        messageBubble = Bundle.main.loadNibNamed("MessageBubble", owner: nil, options: nil)?.first as? MessageBubble
    }

    override func tearDown() {
        messageBubble = nil
        super.tearDown()
    }

    func testUpdateMessageBubble_withMyOwnMessage() {
        let user = User(withUserId: 1, name: "me", avatarUrl: nil)
        let message = Message(withMesageId: 1, user: user, text: "text", timestamp: nil)
        messageBubble.updateMessageBubble(message: message, username: "me")
        XCTAssertEqual(messageBubble.background.backgroundColor, UIColor.darkGray)
        XCTAssertEqual(messageBubble.bubbleContent.textColor, UIColor.white)
        XCTAssertTrue(messageBubble.userImage.isHidden)
        XCTAssertEqual(messageBubble.userName.textAlignment, .right)
        XCTAssertEqual(messageBubble.userName.text, "me")
        XCTAssertEqual(messageBubble.backgroundLeadingConstraint.constant, messageBubble.backgroundLeadingConstraintConstant + 60)
    }

    func testUpdateMessageBubble_withFriendsMessage() {
        let user = User(withUserId: 2, name: "he", avatarUrl: nil)
        let message = Message(withMesageId: 1, user: user, text: "text", timestamp: nil)
        messageBubble.updateMessageBubble(message: message, username: "me")
        XCTAssertEqual(messageBubble.userName.text, message.user?.name)
        XCTAssertEqual(messageBubble.backgroundTrailingConstant.constant, messageBubble.backgroundTrailingConstraintConstant + 60)
    }

}
