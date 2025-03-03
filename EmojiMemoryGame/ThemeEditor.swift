//
//  ThemeEditor.swift
//  EmojiMemoryGame
//
//  Created by 김도현 on 3/3/25.
//

import SwiftUI

struct ThemeEditor: View {
    @Binding var theme: Theme
    
    @State private var newEmojis = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Theme Name", text: $theme.name)
            } header: {
                Text("Name")
                    .sectionHeaderStyle()
            }
            Section {
                TextField("Enter new emojis", text: $newEmojis)
                    .onChange(of: newEmojis) { newEmojis in
                        theme.emojis = (newEmojis + theme.emojis).filter{$0.isEmoji}.uniqued
                            
                    }
                EdittableScrollingEmojis(theme: $theme, newEmojis: $newEmojis)
            } header: {
                Text("Emojis: \(theme.emojis.count)")
                    .sectionHeaderStyle()
            }
            
            Section {
               Text("")
            } header: {
                Text("Color")
                    .sectionHeaderStyle()
            }
            .listRowBackground(Color(rgba: theme.color))
            

        }
    }
}

struct EdittableScrollingEmojis: View {
    @Binding var theme: Theme
    @Binding var newEmojis: String
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(theme.emojis.map{ String($0) }, id: \.self) { emoji in
                    Text(emoji)
                        .onTapGesture {
                            theme.emojis.remove(Character(emoji))
                            newEmojis.remove(Character(emoji))
                        }
                }
            }
        }
    }
}

struct ThemeEditor_Previews: PreviewProvider {
    struct Preview: View {
        @State private var theme = Theme(name: "Preview", color: RGBA(color: .accentColor), emojis: "🧆🍛🫔🥘🥗🍝🥪🍜")
        var body: some View {
            ThemeEditor(theme: $theme)
        }
    }
    
    static var previews: some View {
        Preview()
    }
}

extension Text {
    func sectionHeaderStyle() -> some View {
        self
            .font(.title3)
            .fontWeight(.bold)
            .foregroundStyle(.primary)
            .textCase(nil)
    }
}
