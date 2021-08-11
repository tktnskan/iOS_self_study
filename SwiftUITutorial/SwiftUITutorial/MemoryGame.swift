//
//  MemoryGame.swift
//  SwiftUITutorial
//
//  Created by GJC03280 on 2021/08/11.
//

import Foundation

struct MemoryGame<CardContent> {
    private(set) var cards: [Card]
    
    func chooseCard(_ card: Card) {
        
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        
        // add numberOfPairsOfCards * 2 cards to cards array
        for pairIdx in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIdx)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    struct Card {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent // generic
    }
}
