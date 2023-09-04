//
//  LanguageScreen.swift
//  SwiftUIBase
//
//  Created by manjil on 23/08/2023.
//

import SwiftUI

struct LanguageScreen: View {
    @AppStorage(CacheKey.language.rawValue) private var language = ""
    var body: some View {
        List(Language.allCases, id: \.self) { item in
            Button(item.rawValue) {
                language = item.identifier
            }
        }.navigationTitle("Language")
    }
}

struct LanguageScreen_Previews: PreviewProvider {
    static var previews: some View {
        LanguageScreen()
    }
}
