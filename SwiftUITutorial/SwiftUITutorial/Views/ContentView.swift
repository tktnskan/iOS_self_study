//
//  ContentView.swift
//  SwiftUITutorial
//
//  Created by GJC03280 on 2021/12/01.
//

import SwiftUI

struct Epicode {
    let song: String
    let singer: String
    let track: String
}

struct ContentView: View {
    let epicode = Epicode(song: "Dynamite", singer: "BTS", track: "DayTime Version")
    @State private var isPlaying = false
    
    var body: some View {
//        LandmarkList()
        
        VStack {
            Text(self.epicode.song)
                .font(.title)
                .foregroundColor(self.isPlaying ? .blue : .black)
            
            Text(self.epicode.track)
                .font(.footnote)
                .foregroundColor(.secondary)
            
            Text(self.epicode.singer)
                .foregroundColor(.secondary)
            
            PlayButton(isPlaying: $isPlaying)
        }
    }
}

struct PlayButton: View {
    @Binding var isPlaying: Bool
    
    var body: some View {
        Button(action: {
            self.isPlaying.toggle()
        }) {
            Image(systemName: "play.fill")
                .font(.system(size: 30))
                .foregroundColor(self.isPlaying ? .blue : .black)
        }
        .padding(15)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
