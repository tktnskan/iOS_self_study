//
//  EmojiMemoryGame.swift
//  SwiftUITutorial
//
//  Created by GJC03280 on 2021/08/11.
//

import SwiftUI

// viewModel
class EmojiMemoryGame {
    static let emojis = ["😀","😃","😄","😁","😆","🤣","🥲","😍","🥰","😜","🤯","🤬","🥶","👻","👾","👺"]
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4) { pairIdx in
            emojis[pairIdx]
        }
    }
    
    private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
}
