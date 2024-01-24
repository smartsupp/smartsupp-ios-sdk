//
//  ContentView.swift
//  Example
//
//  Created by Adam Konečný on 20.10.2023.
//

import Smartsupp
import SwiftUI

struct ContentView: View {
    @ObservedObject private var viewModel = ContentViewModel()
    
    var body: some View {
        List {
            Section(content: {
                unreadMessages
                
                smartsuppStatus
            }, header: {
                Text("Status")
            })
            
            Section(content: {
                identifyButton
                
                chatBoxButton
            }, header: {
                Text("Actions")
            })
        }
    }
    
    private var unreadMessages: some View {
        HStack {
            Text("Unread messages")
            
            Spacer()
            
            Text("\(viewModel.unreadCount)")
                .foregroundColor(viewModel.unreadCount <= 0 ? Color.gray : Color.green)
        }
    }
    
    private var smartsuppStatus: some View {
        HStack {
            Text("Account status")
            
            Spacer()
            
            Text(viewModel.isOnline ? "Online" : "Offline")
                .foregroundColor(viewModel.isOnline ? .green : .red)
        }
    }
    
    private var identifyButton: some View {
        Button(action: {
            viewModel.identifyUser()
        }, label: {
            Text("Identify user")
        })
    }
    
    private var chatBoxButton: some View {
        Button(action: {
            viewModel.openChatBox()
        }, label: {
            Text("Open chat box")
        })
    }
}

#Preview {
    ContentView()
}
