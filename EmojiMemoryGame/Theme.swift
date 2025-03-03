//
//  Theme.swift
//  EmojiMemoryGame
//
//  Created by 김도현 on 3/2/25.
//

import Foundation

struct Theme: Identifiable, Hashable, Equatable {
    let id = UUID()
    
    var name: String
    var color: RGBA
    var emojis: String
    
    static let builtins = [
        Theme(name: "Vehicles", color: RGBA(color: .blue), emojis: "🚙🚗🚘🚕🚖🏎🚚🛻🚛🚐🚓🚔🚑🚒🚀✈️🛫🛬🛩🚁🛸🚲🏍🛶⛵️🚤🛥🛳⛴🚢🚂🚝🚅🚆🚊🚉🚇🛺🚜"),
        Theme(name: "Sports", color: RGBA(color: .red), emojis: "🏈⚾️🏀⚽️🎾🏐🥏🏓⛳️🥅🥌🏂⛷🎳"),
        Theme(name: "Music", color: RGBA(color: .mint), emojis: "🎼🎤🎹🪘🥁🎺🪗🪕🎻"),
        Theme(name: "Animals", color: RGBA(color: .orange), emojis: "🐥🐣🐂🐄🐎🐖🐏🐑🐓🐁🐀🐒🦆🦅🦉🦇🐢🐍🦎🦖🦕🐅🐆🦓🦍🦧🦣🐘🦛🦏🐪🐫🦒🦘🦬🐃🦙🐐🦌🐕🐩🦮🐈🦤🦢🦩🕊🦝🦨🦡🦫🦦🦥🐿🦔"),
        Theme(name: "Animal Faces", color: RGBA(color: .brown), emojis: "🐵🙈🙊🙉🐶🐱🐭🐹🐰🦊🐻🐼🐻‍❄️🐨🐯🦁🐮🐷🐸🐲"),
        Theme(name: "Flora", color: RGBA(color: .green), emojis: "🌲🌴🌿☘️🍀🍁🍄🌾💐🌷🌹🥀🌺🌸🌼🌻"),
        Theme(name: "Weather", color: RGBA(color: .white), emojis: "☀️🌤⛅️🌥☁️🌦🌧⛈🌩🌨❄️💨☔️💧💦🌊☂️🌫🌪"),
        Theme(name: "COVID", color: RGBA(color: .gray), emojis: "💉🦠😷🤧🤒"),
        Theme(name: "Faces", color: RGBA(color: .yellow), emojis: "😀😃😄😁😆😅😂🤣🥲☺️😊😇🙂🙃😉😌😍🥰😘😗😙😚😋😛😝😜🤪🤨🧐🤓😎🥸🤩🥳😏😞😔😟😕🙁☹️😣😖😫😩🥺😢😭😤😠😡🤯😳🥶😥😓🤗🤔🤭🤫🤥😬🙄😯😧🥱😴🤮😷🤧🤒🤠")
    ]
}
