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
        
        Smartsupp.shared.state.delegate.add(self)
    }
    
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
