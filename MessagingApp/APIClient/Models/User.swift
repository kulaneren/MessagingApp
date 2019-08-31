//
//  User.swift
//  MessagingApp
//
//  Created by eren on 31.08.2019.
//  Copyright © 2019 Eren Kulan. All rights reserved.
//

enum UserCodingKeys: String, CodingKey {
    case userId = "id", name, avatarUrl
}

struct User: Decodable {

    var userId: Int?
    var name: String?
    var avatarUrl: String?

    init(withUserId userId: Int?,
         name: String?,
         avatarUrl: String?) {
        self.userId = userId
        self.name = name
        self.avatarUrl = avatarUrl
    }

}

extension User {

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: UserCodingKeys.self)
        let userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        let name = try values.decodeIfPresent(String.self, forKey: .name)
        let avatarUrl = try values.decodeIfPresent(String.self, forKey: .avatarUrl)

        self.init(withUserId: userId,
                  name: name,
                  avatarUrl: avatarUrl)
    }

}
