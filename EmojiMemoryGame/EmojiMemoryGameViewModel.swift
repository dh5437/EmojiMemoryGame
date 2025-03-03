//
//  EmojiMemoryGameViewModel.swift
//  EmojiMemoryGame
//
//  Created by 김도현 on 3/1/25.
//

import SwiftUI

class EmojiMemoryGameViewModel: ObservableObject {
    typealias Card = EmojiMemoryGameModel<String>.Card
    
    @Published var model: EmojiMemoryGameModel<String>
    @Published var currentTheme: Theme
    
    private static func createGame(with theme: Theme) -> EmojiMemoryGameModel<String> {
        let emojis = theme.emojis.map { String($0) }
        return EmojiMemoryGameModel(
            numberOfPairsOfShowingEmojis: min(emojis.count, 8)) { index in
                if emojis.indices.contains(index) {
                    return emojis[index]
                } else {
                    return "⁉️"
                }
            }
    }
    
    func createNewGame(with theme: Theme) {
        let emojis = theme.emojis.map { String($0) }
        self.model = EmojiMemoryGameModel(
            numberOfPairsOfShowingEmojis: min(emojis.count, 8)) { index in
                if emojis.indices.contains(index) {
                    return emojis[index]
                } else {
                    return "⁉️"
                }
            }
    }
    
    init(theme: Theme) {
        self.currentTheme = theme
        self.model = Self.createGame(with: theme)
    }
    
    var score: Int {
        return model.score
    }
    
    func changeTheme(to newTheme: Theme) {
        self.currentTheme = newTheme
        self.model = Self.createGame(with: newTheme)
    }
    
    func choose(_ card: Card) {
        model.choose(card)
        
        // 일정 시간이 지나면 다시 뒤집기
        let faceUpIndices = model.deck.indices.filter { model.deck[$0].isFaceUp && !model.deck[$0].isMatched }
        if faceUpIndices.count == 2 {
            Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { _ in
                DispatchQueue.main.async {
                    self.model.flipDownUnmatchedCards()
                }
            }
        }
    }
    
    func shuffle() {
        model.shuffle()
    }
}
