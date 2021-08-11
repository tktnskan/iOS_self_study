//
//  SwiftUITutorialApp.swift
//  SwiftUITutorial
//
//  Created by HotelShilla on 2021/08/04.
//

import SwiftUI

@main
struct SwiftUITutorialApp: App {
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
