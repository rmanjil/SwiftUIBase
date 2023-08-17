//
//  SwiftUIBaseApp.swift
//  SwiftUIBase
//
//  Created by manjil on 16/08/2023.
//

import SwiftUI

@main
struct SwiftUIBaseApp: App {
    @AppStorage(CacheKey.isLogin.rawValue) private var isLogin = false
    var body: some Scene {
        WindowGroup {
            NavigationView {
                if isLogin {
                    ContentView()
                } else {
                    LoginScreen()
                }
            }.onAppear{
                Networking.initialize(with: EnvironmentApp.networkConfig())
            }
        }
    }
}


enum EnvironmentApp {
    static func networkConfig() -> NetworkingConfiguration {
        guard let baseURL = Bundle.main.infoDictionary?["APP_API_BASE_URL"] as? String,
              let clientId = Bundle.main.infoDictionary?["APP_CLIENT_ID"] as? String,
              let clientSecret = Bundle.main.infoDictionary?["APP_CLIENT_SECRET"] as? String else {
            assertionFailure("check for APP_API_BASE_URL, APP_CLIENT_ID and APP_CLIENT_SECRET in Info.plist and Target's Build Setting")
            return NetworkingConfiguration(baseURL: "", clientId: "", clientSecret: "", tokenManageable: TokenManager())
        }
        return NetworkingConfiguration(baseURL: baseURL, clientId: "1", clientSecret: clientSecret, tokenManageable: TokenManager())
    }
}
