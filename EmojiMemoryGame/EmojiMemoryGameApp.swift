//
//  EmojiMemoryGameApp.swift
//  EmojiMemoryGame
//
//  Created by 김도현 on 2/28/25.
//

import SwiftUI

@main
struct EmojiMemoryGameApp: App {
    @StateObject var emojiViewModel = EmojiMemoryGameViewModel()
    @StateObject var themeStore = ThemeStore()
    
    
    var body: some Scene {
        WindowGroup {
//            EmojiMemoryGameView(emojiViewModel: emojiViewModel)
            ThemeChooser(themeStore: themeStore)
                .environmentObject(emojiViewModel)
        }
    }
}
