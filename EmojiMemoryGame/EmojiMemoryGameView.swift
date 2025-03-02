//
//  ContentView.swift
//  EmojiMemoryGame
//
//  Created by 김도현 on 2/28/25.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var emojiViewModel: EmojiMemoryGameViewModel
    
    var body: some View {
        VStack {
            Text("Emoji Memory Game")
                .font(.largeTitle)
            cards
            Spacer()
            bottomContents
        }
        .padding()
    }
    
    var cards: some View {
        AspectVGrid(emojiViewModel.model.deck, aspectRatio: 2/3, content: { card in
            CardView(card: card)
                .aspectRatio(2/3, contentMode: .fit)
                .onTapGesture {
                    emojiViewModel.choose(card)
                }
            }
        )
        .frame(maxWidth: .infinity, maxHeight: 350)
    }
    
    var bottomContents: some View {
        HStack {
            Button {
                withAnimation {
                    emojiViewModel.shuffle()
                }
            } label: {
                Text("Shuffle")
            }

            Spacer()
            ZStack {
                ForEach(emojiViewModel.model.discardedDeck) { card in
                    ZStack {
                        Text(card.content)
                            .font(.system(size: 48))
                            .background(Color.white)
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(Color.green)
                    }
                        .aspectRatio(2/3, contentMode: .fit)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 100)
    }
}

#Preview {
    EmojiMemoryGameView(emojiViewModel: EmojiMemoryGameViewModel())
}
