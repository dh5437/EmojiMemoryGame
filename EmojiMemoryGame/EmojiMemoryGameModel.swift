//
//  EmojiMemoryGameModel.swift
//  EmojiMemoryGame
//
//  Created by 김도현 on 3/1/25.
//

import Foundation

struct EmojiMemoryGameModel<CardContent> where CardContent: Hashable {
    private(set) var deck: Array<Card>
    private(set) var discardedDeck: Array<Card> = []
    
    init(numberOfPairsOfShowingEmojis: Int, contentFactory: @escaping (Int) -> CardContent) {
        deck = []
        
        for pairIndex in 0..<numberOfPairsOfShowingEmojis {
            let content = contentFactory(pairIndex)
            
            deck.append(Card(id: "\(pairIndex)a", content: content))
            deck.append(Card(id: "\(pairIndex)b", content: content))
        }
        deck.shuffle()
    }
    
    mutating func choose(_ card: Card) {
        guard let chosenIndex = deck.firstIndex(where: { $0.id == card.id }) else { return }
        
        // ✅ 이미 FaceUp 상태라면 뒤집기 (선택 해제)
        if deck[chosenIndex].isFaceUp {
            deck[chosenIndex].isFaceUp = false
            return
        }
        
        // ✅ 현재 FaceUp 상태인 카드 찾기
        let faceUpIndices = deck.indices.filter { deck[$0].isFaceUp }
        
        if faceUpIndices.count == 1 {
            let firstFaceUpIndex = faceUpIndices.first!
            
            // ✅ 카드가 일치하는 경우
            if deck[firstFaceUpIndex].content == deck[chosenIndex].content {
                deck[firstFaceUpIndex].isMatched = true
                deck[chosenIndex].isMatched = true
                
                discard(firstFaceUpIndex)
                discard(chosenIndex)
            }
        }
        deck[chosenIndex].isFaceUp = true
    }

    mutating func flipDownUnmatchedCards() {
        for index in deck.indices where deck[index].isFaceUp && !deck[index].isMatched {
            deck[index].isFaceUp = false
        }
    }

    private mutating func discard(_ index: Int) {
        discardedDeck.append(deck[index])
    }
    
    mutating func shuffle() {
        deck.shuffle()
    }
    
    struct Card: Identifiable, Hashable {
        var id: String
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
    }
}
