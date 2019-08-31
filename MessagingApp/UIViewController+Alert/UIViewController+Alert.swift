//
//  UIViewController+Alert.swift
//  MessagingApp
//
//  Created by eren on 31.08.2019.
//  Copyright © 2019 Eren Kulan. All rights reserved.
//

import UIKit

extension UIViewController {

    func showAlert(title: String?,
                   message: String?,
                   actions: [UIAlertAction]) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        for alertAction in actions {
            alertController.addAction(alertAction)
        }
        present(alertController, animated: true, completion: nil)
    }

}
