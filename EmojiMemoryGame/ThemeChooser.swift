//
//  ThemeChooser.swift
//  EmojiMemoryGame
//
//  Created by 김도현 on 3/2/25.
//

import SwiftUI

struct ThemeChooser: View {
    @ObservedObject var themeStore: ThemeStore
    @StateObject private var viewModel = EmojiMemoryGameViewModel(theme: Theme.builtins.first!)
    
    var body: some View {
        NavigationStack {
            List(themeStore.themes) { theme in
                NavigationLink {
                    EmojiMemoryGameView(emojiViewModel: viewModel, theme: theme)
                        .onAppear {
                            viewModel.changeTheme(to: theme)
                        }
                } label: {
                    VStack(alignment: .leading) {
                        Text(theme.name)
                            .font(.title)
                        Text("Number of emojis: \(theme.emojis.count)")
                        ScrollingEmojis(emojis: theme.emojis.map {
                            String($0)
                        })
                    }
                }
                .listRowBackground(Color(rgba: theme.color))
            }
            .listRowSpacing(10)
            .navigationTitle(Text("Themes"))
        }
        
    }
}

struct ScrollingEmojis: View {
    let emojis: Array<String>
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(emojis, id: \.self) { emoji in
                    Text(emoji)
                }
            }
        }
    }
}

#Preview {
    ThemeChooser(themeStore: ThemeStore())
}
