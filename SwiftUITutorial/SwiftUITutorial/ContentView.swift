//
//  ContentView.swift
//  SwiftUITutorial
//
//  Created by HotelShilla on 2021/08/04.
//

import SwiftUI

struct ContentView: View {

    var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(viewModel.cards, id: \.self) { card in
                        CardView(content: card.content)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
        }
        .padding(.horizontal)
    }
}




struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                    .rotation3DEffect(isFaceUp ? Angle(degrees: 0):Angle(degrees: 180), axis: (x: CGFloat(0), y: CGFloat(25), z: CGFloat(0)))
                    .animation(.default)
                    .onTapGesture {
                        isFaceUp.toggle()
                    }
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
    }  
}
