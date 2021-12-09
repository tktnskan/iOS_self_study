//
//  ContentView.swift
//  WatchLandmarks WatchKit Extension
//
//  Created by GJC03280 on 2021/12/09.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LandmarkList()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
