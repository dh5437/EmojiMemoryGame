//
//  CardView.swift
//  EmojiMemoryGame
//
//  Created by 김도현 on 3/1/25.
//

import SwiftUI

struct CardView: View {
    let card: EmojiMemoryGameModel<String>.Card
    let theme: Theme
    
    var body: some View {
        ZStack {
            Text(card.content)
                .font(.system(size: 48))
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(Color(rgba: theme.color), lineWidth: 2)
                .background(
                    Color(rgba: theme.color).opacity(card.isFaceUp ? 0 : 1)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                )
        }
        .opacity(card.isMatched ? 0 : 1) // ✅ 매칭된 카드는 숨기기
        .animation(.easeOut(duration: 0.5), value: card.isMatched)
    }
}


#Preview {
    let theme = Theme(name: "Preview", color: RGBA(color: .accentColor), emojis: "🧆🍛🫔🥘🥗🍝🥪🍜")
    CardView(card: EmojiMemoryGameModel<String>.Card(id: "1", content: "👨"), theme: theme)
}
