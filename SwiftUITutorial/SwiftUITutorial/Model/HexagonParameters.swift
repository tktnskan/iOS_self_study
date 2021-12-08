//
//  HexagonParameters.swift
//  SwiftUITutorial
//
//  Created by Jinyung Yoon on 2021/12/07.
//

import CoreGraphics

struct HexagonParameters {
    
    struct Segment {
        let line: CGPoint
        let curve: CGPoint
        let control: CGPoint
    }
    
    static let adjustment: CGFloat = 0.085
    
    static let segments = [
        Segment(line: CGPoint(x: 0.6, y: 0.05),
                curve: CGPoint(x: 0.4, y: 0.05),
                control: CGPoint(x: 0.5, y: 0.0)),
        Segment(line: CGPoint(x: 0.05, y: 0.2 + adjustment),
                curve: CGPoint(x: 0.0, y: 0.3 + adjustment),
                control: CGPoint(x: 0.0, y: 0.25 + adjustment)),
        Segment(line: CGPoint(x: 0.0, y: 0.70 - adjustment),
                curve: CGPoint(x: 0.05, y: 0.80 - adjustment),
                control: CGPoint(x: 0.0, y: 0.75 - adjustment)),
        Segment(line: CGPoint(x: 0.4, y: 0.95),
                curve: CGPoint(x: 0.6, y: 0.95),
                control: CGPoint(x: 0.5, y: 1.0)),
        Segment(line: CGPoint(x: 0.95, y: 0.8 - adjustment),
                curve: CGPoint(x: 1.0, y: 0.7 - adjustment),
                control: CGPoint(x: 1.0, y: 0.75 - adjustment)),
        Segment(line: CGPoint(x: 1.0, y: 0.3 + adjustment),
                curve: CGPoint(x: 0.95, y: 0.2 + adjustment),
                control: CGPoint(x: 1.0, y: 0.25 + adjustment)),
    ]
}
