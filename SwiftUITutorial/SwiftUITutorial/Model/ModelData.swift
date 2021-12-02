//
//  ModelData.swift
//  SwiftUITutorial
//
//  Created by GJC03280 on 2021/12/01.
//

import Foundation
import Combine

var landmarks: [Landmark] = load(filename: "landmarkData.json")

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


