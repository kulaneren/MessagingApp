//
//  MessageBubble.swift
//  MessagingApp
//
//  Created by eren on 31.08.2019.
//  Copyright © 2019 Eren Kulan. All rights reserved.
//

import UIKit
import Kingfisher

class MessageBubble: UITableViewCell {

    @IBOutlet weak var bubbleContent: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var userImage: UIImageView!

    @IBOutlet weak var backgroundLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var backgroundTrailingConstant: NSLayoutConstraint!
    var backgroundLeadingConstraintConstant: CGFloat!
    var backgroundTrailingConstraintConstant: CGFloat!

    override func awakeFromNib() {
        self.userImage.layer.masksToBounds = true
        self.userImage.layer.borderWidth = 1
        self.userImage.layer.borderColor = UIColor.white.cgColor
        self.userImage.layer.cornerRadius = 15

        self.background.layer.cornerRadius = 8
        self.background.layer.masksToBounds = true

        self.backgroundLeadingConstraintConstant = backgroundLeadingConstraint.constant
        self.backgroundTrailingConstraintConstant = backgroundTrailingConstant.constant
    }

    func reset() {
        backgroundTrailingConstant.constant = backgroundTrailingConstraintConstant
        backgroundLeadingConstraint.constant = backgroundLeadingConstraintConstant
        background.backgroundColor = UIColor.lightGray
        bubbleContent.textColor = UIColor.black
        userImage.isHidden = false
        userName.textAlignment = .left
    }

    func updateMessageBubble(message: Message, username: String) {
        reset()
        bubbleContent.text = message.text
        if username == message.user?.name {
            background.backgroundColor = UIColor.darkGray
            bubbleContent.textColor = UIColor.white
            userImage.isHidden = true
            userName.textAlignment = .right
            userName.text = username
            backgroundLeadingConstraint.constant = backgroundLeadingConstraintConstant + 60
        } else {
            backgroundTrailingConstant.constant = backgroundTrailingConstraintConstant + 60
            userName.text = message.user?.name
            guard let url = URL(string: message.user?.avatarUrl ?? "") else {
                return
            }
            userImage.kf.setImage(with: url)
        }
    }

}
