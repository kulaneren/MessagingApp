//
//  APIClientFake.swift
//  MessagingApp
//
//  Created by eren on 31.08.2019.
//  Copyright © 2019 Eren Kulan. All rights reserved.
//

import Foundation

@testable import MessagingApp

class APIClientFake: APIClient {

    var returnError = false

    override func getMessages(withCompletion completion: @escaping ([Message]?, Error?) -> Void) {
        if returnError {
            completion(nil, NSError(domain: "Error", code: 400, userInfo: nil))
        } else {
            let bundle = Bundle.init(for: APIClientFake.self)
            let fileURL = URL(string: bundle.path(forResource: "messages", ofType: "json", inDirectory: nil)!)!
            // swiftlint:disable:next force_try
            let chatTexts = try! String(contentsOf: fileURL, encoding: .utf8)
            let data = chatTexts.data(using: .utf8)!
            let jsonDecoder = JSONDecoder()
            // swiftlint:disable:next force_try
            let messages = try! jsonDecoder.decode([Message].self, from: data)
            completion(messages, nil)
        }
    }

}
