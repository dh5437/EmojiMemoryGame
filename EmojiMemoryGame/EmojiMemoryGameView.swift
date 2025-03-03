//
//  ContentView.swift
//  EmojiMemoryGame
//
//  Created by 김도현 on 2/28/25.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var emojiViewModel: EmojiMemoryGameViewModel
    let theme: Theme
    
    var body: some View {
        VStack {
            Text(emojiViewModel.currentTheme.name)
                .font(.largeTitle)
                .fontWeight(.black)
            cards
            Spacer()
            bottomContents
        }
        .padding()
    }
    
    var cards: some View {
        AspectVGrid(emojiViewModel.model.deck, aspectRatio: 2/3, content: { card in
            CardView(card: card, theme: theme)
                .aspectRatio(2/3, contentMode: .fit)
                .matchedGeometryEffect(id: card.id, in: discardedPileNamespace, isSource: false)
                .onTapGesture {
                    emojiViewModel.choose(card)
                }
            }
        )
        .frame(maxWidth: .infinity, maxHeight: 350)
    }
    
    var bottomContents: some View {
        HStack {
            Text("Score: \(emojiViewModel.score)")
                .font(.system(size: 20, weight: .bold))
            Spacer()
            
            Button {
                withAnimation {
                    emojiViewModel.shuffle()
                }
            } label: {
                Image(systemName: "shuffle")
                    .buttonize(Color(rgba: theme.color))
            }
            
            Button {
                withAnimation {
                    emojiViewModel.createNewGame(with: theme)
                }
            } label: {
                Image(systemName: "gamecontroller")
                    .buttonize(Color(rgba: theme.color))
            }

            Spacer()
            discardPile
        }
        .frame(maxWidth: .infinity, maxHeight: 100)
    }
    
    @Namespace private var discardedPileNamespace
    
    var discardPile: some View {
        ZStack {
            if emojiViewModel.model.discardedDeck.isEmpty {
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(Color(rgba: theme.color), lineWidth: 2)
                    .background(
                        Color.gray
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    )
                    .aspectRatio(2/3, contentMode: .fit)
            }
            ForEach(emojiViewModel.model.discardedDeck, id: \.self) { card in
                ZStack {
                    Text(card.content)
                        .font(.system(size: 48))
                        .background(Color.white)
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(Color(rgba: theme.color), lineWidth: 2)
                }
                .aspectRatio(2/3, contentMode: .fit)
                .matchedGeometryEffect(id: card.id, in: discardedPileNamespace)
                .transition(.identity)
            }
        }
    }
}

#Preview {
    let theme = Theme(name: "Preview", color: RGBA(color: .accentColor), emojis: "🧆🍛🫔🥘🥗🍝🥪🍜")
    EmojiMemoryGameView(emojiViewModel: EmojiMemoryGameViewModel(theme: theme), theme: theme)
}
