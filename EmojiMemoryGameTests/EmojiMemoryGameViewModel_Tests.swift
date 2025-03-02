//
//  EmojiMemoryGameViewModel_Tests.swift
//  EmojiMemoryGameTests
//
//  Created by 김도현 on 3/1/25.
//

import Testing
import SwiftUI
@testable import EmojiMemoryGame

struct EmojiMemoryGameViewModel_Tests {
    let viewmodel = EmojiMemoryGameViewModel()
    
    @Test func test_EmojiMemoryGameViewModel_init_shouldMakeANewGameWithPairsOfEmojis() {
        // Given
        // When
        let count = EmojiMemoryGameViewModel.emojis.count
        // Then
        #expect(viewmodel.model.deck.count == count * 2)
    }
    
    @Test func test_EmojiMemoryGameViewModel_choose_shouldChooseCard() {
        // Given
        let card = viewmodel.model.deck[0]
        
        // When
        viewmodel.choose(card)
        
        // Then
        #expect(viewmodel.model.deck[0].isFaceUp)
    }
    
    @Test func test_EmojiMemoryGameViewModel_choose_shouldUnchooseCardWhenTappedAgain() {
        // Given
        let card = viewmodel.model.deck[0]
        
        // When
        viewmodel.choose(card)
        #expect(viewmodel.model.deck[0].isFaceUp)
        
        viewmodel.choose(card)
        
        // Then
        #expect(!viewmodel.model.deck[0].isFaceUp)
    }
    
    @Test func test_EmojiMemoryGameViewModel_choose_shouldChooseCard_stress() {
        // Given
        let randomCount = Int.random(in: 0..<viewmodel.model.deck.count)
        let card = viewmodel.model.deck[randomCount]
        
        // When
        for _ in 0..<100 {
            viewmodel.choose(card)
            #expect(viewmodel.model.deck[randomCount].isFaceUp)
            
            viewmodel.choose(card)
            #expect(!viewmodel.model.deck[randomCount].isFaceUp)
        }
        
        
        // Then
        #expect(!viewmodel.model.deck[0].isFaceUp)
    }
    
    @Test func test_EmojiMemoryGameViewModel_choose_shouldFaceDownCardsWhenNotMatched() {
        // Given
        guard let firstCard = viewmodel.model.deck.first, let secondCard = viewmodel.model.deck.first(where: { $0.content != firstCard.content && $0.id != firstCard.id }) else {
            return
        }
        
        // When
        viewmodel.choose(firstCard)
        viewmodel.choose(secondCard)
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                #expect(!viewmodel.model.deck[0].isFaceUp)
                #expect(!viewmodel.model.deck[1].isFaceUp)
            }
        )
    }
    
    @Test func test_EmojiMemoryGameViewModel_choose_shouldDiscardCardsWhenMatched() {
        // Given
        guard let firstCard = viewmodel.model.deck.first, let secondCard = viewmodel.model.deck.first(where: { $0.content == firstCard.content && $0.id != firstCard.id }) else {
            return
        }
        
        #expect(viewmodel.model.discardedDeck.isEmpty)
        
        // When
        viewmodel.choose(firstCard)
        viewmodel.choose(secondCard)
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                #expect(viewmodel.model.deck[0].isFaceUp)
                #expect(viewmodel.model.deck[1].isFaceUp)
                #expect(viewmodel.model.discardedDeck.count == 2)
            }
        )
    }
}
