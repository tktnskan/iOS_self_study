//
//  EmojiMemoryGame.swift
//  SwiftUITutorial
//
//  Created by Jinyung Yoon on 2021/08/11.
//

import SwiftUI

// viewModel
class EmojiMemoryGame: ObservableObject {
    static let emojis = ["👩‍👩‍👧‍👦", "👥", "🦆","🤬","🥶","👻","👾","👺", "🪳", "🪲", "🦖", "🦕", "🦋", "🦅", "🐍", "🐡", "🦀", "🦞" ,"🦐", "🦑"]
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 10) { pairIdx in
            emojis[pairIdx]
        }
    }
    
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intent(s)
    func choose(_ card: MemoryGame<String>.Card) {
        model.chooseCard(card)
    }
}
