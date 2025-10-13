//
//  NewslyApp.swift
//  Newsly
//
//  Created by wyrlook on 10.09.2025.
//

import SwiftUI

@main
struct NewslyApp: App {
    
    let logger: LoggerProtocol = LoggerService.logger
    let networkService: NetworkProtocol = NetworkService.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.logger, logger)
                .environment(\.networkService, networkService)
        }
    }
}
