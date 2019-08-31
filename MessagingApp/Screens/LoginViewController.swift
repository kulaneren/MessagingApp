//
//  LoginViewController.swift
//  MessagingApp
//
//  Created by eren on 31.08.2019.
//  Copyright © 2019 Eren Kulan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var txtNickname: UITextField!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }

    private func saveUserNickname(_ nickName: String) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(nickName, forKey: UserData.Nickname)
    }

    @IBAction func btnLoginTapped(_ sender: Any?) {
        let alertAction = UIAlertAction(title: "Ok",
                                        style: .default,
                                        handler: nil)
        if let nickname = txtNickname.text, nickname.count > 2 {
            saveUserNickname(nickname)
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            // swiftlint:disable force_cast
            let messagesViewController = mainStoryboard.instantiateViewController(withIdentifier: "MessagesViewController") as! MessagesViewController
            messagesViewController.nickName = nickname
            self.navigationController?.pushViewController(messagesViewController, animated: true)
        } else {
            showAlert(title: "Warning", message: "Please enter a nickname longer than 2 characters", actions: [alertAction])
        }
    }
}
