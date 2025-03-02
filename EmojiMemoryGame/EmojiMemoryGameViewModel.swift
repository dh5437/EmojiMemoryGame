//
//  EmojiMemoryGameViewModel.swift
//  EmojiMemoryGame
//
//  Created by 김도현 on 3/1/25.
//

import SwiftUI

class EmojiMemoryGameViewModel: ObservableObject {
    typealias Card = EmojiMemoryGameModel<String>.Card
    
    static let emojis: [String] = ["🦄", "🐇", "🐰", "🦎", "🐻", "🐼", "🦁", "🦉", "🐯"]
    
    private static func createGame() -> EmojiMemoryGameModel<String> {
        return EmojiMemoryGameModel(
            numberOfPairsOfShowingEmojis: emojis.count) { index in
                if emojis.indices.contains(index) {
                    return emojis[index]
                } else {
                    return "⁉️"
                }
            }
    }
    
    @Published var model = createGame()
    
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
