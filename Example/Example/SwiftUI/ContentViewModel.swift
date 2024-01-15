//
//  ContentViewModel.swift
//  Example
//
//  Created by Adam Konečný on 30.10.2023.
//

import Smartsupp
import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var isOnline: Bool
    @Published var unreadCount: Int
    
    init() {
        self.isOnline = false
        self.unreadCount = Smartsupp.shared.state.unreadMessages
        
        // Listen for changes in unread messages, account status and whether the use was blocked or unblocked
        Smartsupp.shared.state.delegate.add(self)
    }
    
    // Sets name, email, phone and custom variables for the current user
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
    
    // Open chat box
    func openChatBox() {
        Smartsupp.openChatBox() {
            switch $0 {
            case .success:
                print("Chatbox was opened")
            case .error(let error):
                print("Failed to open the Chatbox - \(error.localizedDescription)")
            }
        }
    }
}

extension ContentViewModel: SmartsuppStateDelegate {
    func smartsuppState(unreadMessages: Int) {
        self.unreadCount = unreadMessages
    }
    
    func smartsuppState(status: AccountStatus) {
        self.isOnline = status.isOnline
    }
    
    func smartsuppState(userIsBlocked: Bool) {
        if userIsBlocked {
            print("User was blocked")
        } else {
            print("User was unblocked")
        }
    }
}
