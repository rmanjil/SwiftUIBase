//
//  SettingScreen.swift
//  SwiftUIBase
//
//  Created by manjil on 21/08/2023.
//

import SwiftUI

struct SettingScreen: View {
    @AppStorage(CacheKey.mode.rawValue) private var isDarkMode: Bool = false
    @ObservedObject var viewmodel = SettingViewModel()
    var body: some View {
        List(viewmodel.settings, id: \.self) { value in
            switch value {
            case .mode:
                Toggle(value.title, isOn: $isDarkMode)
                                .padding()
                                .toggleStyle(SwitchToggleStyle(tint: .blue))
            case .language:
                Button(action: {
                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                        return
                    }
                    if UIApplication.shared.canOpenURL(settingsUrl) {
                        UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                            print("Settings opened: \(success)") // Prints true
                        })
                    }
                }) {
                    Text(value.title)
                }
            }
        }
    }
}

struct SettingScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingScreen()
    }
}
