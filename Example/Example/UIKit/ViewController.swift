//
//  ViewController.swift
//  Test
//
//  Created by Adam Konečný on 15.01.2024.
//

import Smartsupp
import UIKit

class ViewController: UIViewController {
    private var appView: AppView!
    
    override func loadView() {
        appView = AppView(
            unreadMessagesCount: Smartsupp.shared.state.unreadMessages,
            isOnline: Smartsupp.shared.state.status.isOnline
        )
        
        self.view = appView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appView.delegate = self
        
        Smartsupp.shared.state.delegate.add(self)
    }
}

extension ViewController: AppViewDelegate {
    func identifyUser() {
        Smartsupp.identifyUser(
            name: "John Appleseed",
            email: "john.appleseed@apple.com",
            phone: "+420123456789",
            variables: [
                "custom_id": "2343233",
                "age": "29"
            ]
        )
    }
    
    func openChatBox() {
        Smartsupp.openChatBox(from: self) {
            switch $0 {
            case .success:
                break
            case .error:
                break
            }
        }
    }
}

extension ViewController: SmartsuppStateDelegate {
    func smartsuppState(unreadMessages: Int) {
        appView.updateUnreadMessages(unreadMessages)
    }
    
    func smartsuppState(status: AccountStatus) {
        appView.updateAccountStatus(status.isOnline)
    }
    
    func smartsuppState(userIsBlocked: Bool) {
        if userIsBlocked {
            print("User was blocked")
        } else {
            print("User was unblocked")
        }
    }
}
