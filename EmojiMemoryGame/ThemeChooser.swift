//
//  ThemeChooser.swift
//  EmojiMemoryGame
//
//  Created by 김도현 on 3/2/25.
//

import SwiftUI

struct ThemeChooser: View {
    @ObservedObject var themeStore: ThemeStore
    @State private var showEditor = false
    
    var body: some View {
        NavigationStack {
            EdittableThemeChooser(themeStore: themeStore, showEditor: $showEditor)
            .toolbar {
                Button {
                    themeStore.insert(Theme(name: "", color: RGBA(color: .white), emojis: ""))
                    showEditor = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        
    }
}

struct EdittableThemeChooser: View {
    @ObservedObject var themeStore: ThemeStore
    @StateObject private var viewModel = EmojiMemoryGameViewModel(theme: Theme.builtins.first!)
    
    @Binding var showEditor: Bool
    
    var body: some View {
        List {
            ForEach(themeStore.themes) { theme in
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
                .sheet(isPresented: $showEditor) {
                    ThemeEditor(theme: $themeStore.themes[themeStore.selectedThemeIndex])
                }
                .contextMenu {
                    Button {
                        showEditor = true
                        if let index = themeStore.themes.firstIndex(where: {theme.id == $0.id}) {
                            themeStore.selectedThemeIndex = index
                        }
                    } label: {
                        Label("Edit", systemImage: "pencil")
                    }
                    
                    Button(role: .destructive) {
                        withAnimation(.easeInOut) {
                            if let index = themeStore.themes.firstIndex(where: {theme.id == $0.id}) {
                                themeStore.themes.remove(at: index)
                            }
                        }
                    } label: {
                        Label("Delete", systemImage: "minus.circle")
                    }
                }
            }
            .onDelete { indexSet in
                withAnimation {
                    themeStore.themes.remove(atOffsets: indexSet)
                }
            }
            .onMove { indexSet, newOffset in
                themeStore.themes.move(fromOffsets: indexSet, toOffset: newOffset)
            }
        }
        .listRowSpacing(10)
        .navigationTitle(Text("Themes"))
    }
}

struct ScrollingEmojis: View {
    var emojis: Array<String>
    
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
