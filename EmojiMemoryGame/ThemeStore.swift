//
//  ThemeDocument.swift
//  EmojiMemoryGame
//
//  Created by 김도현 on 3/2/25.
//

import SwiftUI

class ThemeStore: ObservableObject {
    @Published var themes: [Theme]
    @Published var selectedThemeIndex: Int = 0
    
    init() {
        themes = Theme.builtins
    }
    
    private func boundsCheckedThemeIndex(_ index: Int) -> Int {
        var index = index % themes.count
        if index < 0 {
            index += themes.count
        }
        return index
    }
    
    func insert(_ theme: Theme, at insertionIndex: Int? = nil) { // "at" default is cursorIndex
        let insertionIndex = boundsCheckedThemeIndex(insertionIndex ?? selectedThemeIndex)
        if let index = themes.firstIndex(where: { $0.id == theme.id }) {
            themes.move(fromOffsets: IndexSet([index]), toOffset: insertionIndex)
            themes.replaceSubrange(insertionIndex...insertionIndex, with: [theme])
        } else {
            themes.insert(theme, at: insertionIndex)
        }
    }
}
