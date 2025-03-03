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
    var score: Int = 0
    
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
        
        if deck[chosenIndex].isFaceUp {
            deck[chosenIndex].isFaceUp = false
            return
        }
        
        let faceUpIndices = deck.indices.filter { deck[$0].isFaceUp }
        
        deck[chosenIndex].isFaceUp = true
        
        print("Face up cards: \(faceUpIndices)")
        
        if faceUpIndices.count == 1 {
            guard let firstFaceUpIndex = faceUpIndices.first else {
                return
            }
            
            if deck[firstFaceUpIndex].content == deck[chosenIndex].content {
                deck[firstFaceUpIndex].isMatched = true
                deck[chosenIndex].isMatched = true
                
                discard(firstFaceUpIndex)
                discard(chosenIndex)
                
                addScore()
            }
        }
    }

    mutating func flipDownUnmatchedCards() {
        for index in deck.indices where deck[index].isFaceUp && !deck[index].isMatched {
            deck[index].isFaceUp = false
        }
    }

    private mutating func discard(_ index: Int) {
        if deck.indices.contains(index) {
            let card = deck[index]
            discardedDeck.append(card)
            deck[index].isFaceUp = false
            deck = deck.map { $0 }
        }
    }

    mutating func shuffle() {
        deck.shuffle()
    }
    
    private mutating func addScore() {
        score += 2
    }
    
    struct Card: Identifiable, Hashable {
        var id: String
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
    }
}
