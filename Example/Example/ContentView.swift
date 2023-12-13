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
        VStack(spacing: 16.0) {
            widgetButton
            
            smartsuppStatus
            
            unreadMessages
            
            identifyButton
        }
    }
    
    private var widgetButton: some View {
        Button(action: {
            Smartsupp.openChatBox() {
                switch $0 {
                case .success:
                    print("Chatbox was opened")
                case .error(let error):
                    print("Failed to open the Chatbox - \(error.localizedDescription)")
                }
            }
        }, label: {
            widgetButtonLabel
        })
        .smartsupp()
    }
    
    private var widgetButtonLabel: some View {
        Text("Smartsupp Widget")
            .padding()
            .background(Color.blue)
            .foregroundStyle(.white)
            .cornerRadius(.infinity)
            .shadow(radius: 2.0, y: 1.5)
    }
    
    private var smartsuppStatus: some View {
        HStack {
            if viewModel.isOnline {
                Text("Agent is available")
            } else {
                Text("No agent is available")
            }
            
            Circle()
                .fill(viewModel.isOnline ? Color.green : Color.red)
                .frame(width: 16.0, height: 16.0)
        }
    }
    
    private var unreadMessages: some View {
        HStack {
            Text("Unread messages")
            
            Text("\(viewModel.unreadCount)")
                .padding(8.0)
                .foregroundColor(.white)
                .background(
                    Circle()
                        .fill(viewModel.unreadCount <= 0 ? Color.green : Color.red)
                )
        }
    }
    
    private var identifyButton: some View {
        Button(action: {
            viewModel.identifyUser()
        }, label: {
            Text("Identify user")
        })
    }
}

#Preview {
    ContentView()
}
