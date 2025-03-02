//
//  CardView.swift
//  EmojiMemoryGame
//
//  Created by 김도현 on 3/1/25.
//

import SwiftUI

struct CardView: View {
    let card: EmojiMemoryGameModel<String>.Card
    @State private var isVisible = true
    
    var body: some View {
        ZStack {
            if isVisible {
                Text(card.content)
                    .font(.system(size: 48))
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(Color.orange, lineWidth: 2)
                    .background(
                        Color.orange.opacity(card.isFaceUp ? 0 : 1)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    )
                    .animation(.easeOut(duration: 0.5), value: card.isMatched)
                    .onChange(of: card.isMatched) { newValue in
                        if newValue {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                withAnimation {
                                    isVisible = false
                                }
                            }
                        }
                    }
            }
        }
    }
}

#Preview {
    CardView(card: EmojiMemoryGameModel<String>.Card(id: "1", content: "👨"))
}
