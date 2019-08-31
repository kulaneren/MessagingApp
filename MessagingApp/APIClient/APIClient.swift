//
//  APIClient.swift
//  MessagingApp
//
//  Created by eren on 31.08.2019.
//  Copyright © 2019 Eren Kulan. All rights reserved.
//

import Foundation

class APIClient {

    fileprivate let jsonDecoder = JSONDecoder()
    fileprivate let defaultSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = Timeout.IntervalForRequest
        configuration.timeoutIntervalForResource = Timeout.IntervalForResource
        return URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
    }()

    var dataTask: URLSessionDataTask?

    func getMessages(withCompletion completion: @escaping ([Message]?, Error?) -> Void) {
        let url = URL(string: API.ServerURL)!
        dataTask?.cancel()
        dataTask = defaultSession.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            } else if let data = data,
                let response = response as? HTTPURLResponse, response.statusCode == 200 {
                do {
                    let messages = try self.jsonDecoder.decode([Message].self, from: data)
                    DispatchQueue.main.async {
                        completion(messages, nil)
                    }
                } catch {
                    print("Error on decoding messages : ", error)
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        dataTask?.resume()
    }

}
