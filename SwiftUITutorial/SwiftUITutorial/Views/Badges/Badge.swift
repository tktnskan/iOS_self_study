//
//  Badge.swift
//  SwiftUITutorial
//
//  Created by Jinyung Yoon on 2021/12/08.
//

import SwiftUI

struct Badge: View {
    
    var badgeSymbols: some View {
        ForEach(0..<8) { index in
            RotatedBadgeSymbol(
                angle: .degrees(Double(index) / Double(8)) * 360
            )
        }
        .opacity(0.5)
    }
    
    var body: some View {
        ZStack {
            BadgeBackground()
            
            GeometryReader { geo in
                badgeSymbols
                    .scaleEffect(1/4, anchor: .top)
                    .position(x: geo.size.width / 2, y: 3 / 4 * geo.size.height)
            }
        }
        .scaledToFit()
    }
}

struct Badge_Previews: PreviewProvider {
    static var previews: some View {
        Badge()
    }
}
