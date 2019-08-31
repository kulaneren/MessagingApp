//
//  APIClientTests.swift
//  MessagingAppTests
//
//  Created by eren on 31.08.2019.
//  Copyright © 2019 Eren Kulan. All rights reserved.
//

import XCTest
import OHHTTPStubs

@testable import MessagingApp

class APIClientTests: XCTestCase {

    let apiClient = APIClient()

    func testGetMessagesFails() {
        stub(condition: isMethodGET()) { _ in
            let notConnectedError = NSError(domain: NSURLErrorDomain, code: Int(CFNetworkErrors.cfurlErrorNotConnectedToInternet.rawValue), userInfo: nil)
            return OHHTTPStubsResponse(error: notConnectedError)
        }

        let expectation = self.expectation(description: "GetMessages")

        apiClient.getMessages { messages, error in
            XCTAssertNil(messages)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testGetMessagesSuccess() {
        stub(condition: isMethodGET()) { _ in
            let stubPath = OHPathForFile("messages.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type": "application/json"])
        }

        let expectation = self.expectation(description: "GetMessages")

        apiClient.getMessages { messages, error in
            XCTAssertNotNil(messages)
            XCTAssertEqual(messages?.count, 5)
            XCTAssertNil(error)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

}
