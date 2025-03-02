//
//  EmojiMemoryGameViewModel_Tests.swift
//  EmojiMemoryGameTests
//
//  Created by 김도현 on 3/1/25.
//

import Testing
@testable import EmojiMemoryGame

struct EmojiMemoryGameViewModel_Tests {
    let viewmodel = EmojiMemoryGameViewModel()
    
    @Test func test_EmojiMemoryGameViewModel_init_shouldMakeANewGameWith8PairsOfEmojis() {
        #expect(viewmodel.model.showingCards.count == 16)
    }
    
}
