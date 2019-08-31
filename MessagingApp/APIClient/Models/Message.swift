//
//  Message.swift
//  MessagingApp
//
//  Created by eren on 31.08.2019.
//  Copyright © 2019 Eren Kulan. All rights reserved.
//

import Foundation

enum MessageCodingKeys: String, CodingKey {
    case messageId = "id", user, text, timestamp
}

struct Message: Decodable {

    var messageId: Int?
    var user: User?
    var text: String?
    var timestamp: String?

    init(withMesageId messageId: Int?,
         user: User?,
         text: String?,
         timestamp: String?) {
        self.messageId = messageId
        self.user = user
        self.text = text
        self.timestamp = timestamp
    }

}

extension Message {

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: MessageCodingKeys.self)
        let messageId = try values.decodeIfPresent(Int.self, forKey: .messageId)
        let user = try values.decodeIfPresent(User.self, forKey: .user)
        let text = try values.decodeIfPresent(String.self, forKey: .text)
        let unixTimestamp = try values.decodeIfPresent(Double.self, forKey: .timestamp) ?? 0.0
        let timestamp = Date(timeIntervalSince1970: unixTimestamp)
        let dateStr = Utils.hourMinFromDate(timestamp)

        self.init(withMesageId: messageId,
                  user: user,
                  text: text,
                  timestamp: dateStr)
    }

}
