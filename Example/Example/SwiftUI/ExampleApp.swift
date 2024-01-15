//
//  ExampleApp.swift
//  Example
//
//  Created by Adam Konečný on 20.10.2023.
//

import Smartsupp
import SwiftUI

@main
struct ExampleApp: App {
    init() {
        Smartsupp.setup(
            withOptions: .init(
                apiKey: "YOUR_API_KEY",
                accountKey: "YOUR_ACCOUNT_KEY"
            )
        )
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
