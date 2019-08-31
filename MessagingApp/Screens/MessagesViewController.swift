//
//  MessagesViewController.swift
//  MessagingApp
//
//  Created by eren on 31.08.2019.
//  Copyright © 2019 Eren Kulan. All rights reserved.
//

import UIKit

class MessagesViewController: UIViewController {

    @IBOutlet weak var tblMessages: UITableView!
    @IBOutlet weak var txtMessage: UITextField!
    var nickName: String = ""
    private var messages = [Message]()
    private var apiClient = APIClient()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.topItem?.title = nickName

        tblMessages.register(UINib(nibName: "MessageBubble", bundle: nil), forCellReuseIdentifier: "MessageBubble")
        tblMessages.estimatedRowHeight = 85.0
        tblMessages.rowHeight = UITableView.automaticDimension

        getMessages(withAPIClient: apiClient)
    }

    internal func getMessages(withAPIClient apiClient: APIClient) {
        apiClient.getMessages(withCompletion: { messages, error in
            if let error = error as NSError? {
                let alertAction = UIAlertAction(title: "Ok",
                                                style: .default,
                                                handler: nil)
                self.showAlert(title: "Error", message: error.localizedDescription, actions: [alertAction])
                return
            }
            if let messages = messages {
                self.messages = messages
                self.tblMessages.reloadData()
            }
        })
    }

    @IBAction func btnSendTapped(_ sender: Any?) {
        let lastMessageID = messages.last?.messageId ?? 0
        let user = User(withUserId: nil, name: nickName, avatarUrl: nil)
        let message = Message(withMesageId: lastMessageID + 1, user: user, text: txtMessage.text, timestamp: Utils.getCurrentHourMinute())
        messages.append(message)
        tblMessages.reloadData()
        let lastRow = messages.isEmpty ? 0 : messages.count - 1
        let indexPath = IndexPath(row: lastRow, section: 0)
        tblMessages.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }

}

extension MessagesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

}

extension MessagesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        // swiftlint:disable:next force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageBubble") as! MessageBubble
        cell.updateMessageBubble(message: message, username: nickName)
        return cell
    }

}
