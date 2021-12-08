//
//  ModelData.swift
//  SwiftUITutorial
//
//  Created by Jinyung Yoon on 2021/12/01.
//

import Foundation
import Combine

final class ModelData: ObservableObject {
    @Published var landmarks: [Landmark] = load(filename: "landmarkData.json")
    @Published var profile = Profile.default
    var hikes: [Hike] = load(filename: "hikeData.json")
    
    var categories: [String: [Landmark]] {
        Dictionary (
            grouping: landmarks,
            by: { $0.category.rawValue }
        )
    }
    
    var features: [Landmark] {
        landmarks.filter { $0.isFeatured }
    }
}

func load<T: Decodable>(filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("\(filename) 없음!")
    }
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("\(filename) 로드 불가!")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("\(filename) 파싱 불가!")
    }
}


