//
//  SettingScreen.swift
//  SwiftUIBase
//
//  Created by manjil on 21/08/2023.
//

import SwiftUI

struct SettingScreen: View {
    @ObservedObject var viewmodel = SettingViewModel()
    var body: some View {
        List(viewmodel.settings, id: \.self) { value in
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

struct SettingScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingScreen()
    }
}
