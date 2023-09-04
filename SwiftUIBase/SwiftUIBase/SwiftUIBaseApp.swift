//
//  SwiftUIBaseApp.swift
//  SwiftUIBase
//
//  Created by manjil on 16/08/2023.
//

import SwiftUI

@main
struct SwiftUIBaseApp: App {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.locale) var local
    @AppStorage(CacheKey.mode.rawValue) private var isDarkMode: Bool?
    @AppStorage(CacheKey.isLogin.rawValue) private var isLogin = false
    @AppStorage(CacheKey.language.rawValue) private var language = "ne_NP"
    var body: some Scene {
        WindowGroup {
            NavigationView {
                if isLogin {
                    ContentView()
                } else {
                    LoginScreen()
                }
            }.onAppear {
                print(local)
                print(local.currency ?? "")
                print(Locale.current)
                print(local.identifier)
                print(local.language)
                print(local.language.languageCode?.identifier ?? "")
                Networking.initialize(with: EnvironmentApp.networkConfig())
            }
            .environment(\.colorScheme, isDarkMode == nil ?  colorScheme : isDarkMode == true ? .dark : .light)
            .environment(\.locale, .init(identifier: language))
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
        return NetworkingConfiguration(baseURL: baseURL, clientId: clientId, clientSecret: clientSecret, tokenManageable: TokenManager())
    }
}
