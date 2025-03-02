//
//  ThemeDocument.swift
//  EmojiMemoryGame
//
//  Created by 김도현 on 3/2/25.
//

import SwiftUI

class ThemeStore: ObservableObject {
    @Published var themes: [Theme]
    
    init() {
        themes = Theme.builtins
    }
}
