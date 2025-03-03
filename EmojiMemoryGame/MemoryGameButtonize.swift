//
//  MemoryGameButtonize.swift
//  EmojiMemoryGame
//
//  Created by 김도현 on 3/3/25.
//

import SwiftUI

struct MemoryGameButtonize: ViewModifier {
    let color: Color
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(20)
            .background(color)
            .cornerRadius(20)
    }
}

extension View {
    func buttonize(_ color: Color) -> some View {
        self.modifier(MemoryGameButtonize(color: color))
    }
}

#Preview {
    Image(systemName: "shuffle")
        .buttonize(Color.blue)
}
