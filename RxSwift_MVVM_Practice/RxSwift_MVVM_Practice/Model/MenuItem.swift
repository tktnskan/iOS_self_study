//
//  MenuItem.swift
//  RxSwift_MVVM_Practice
//
//  Created by Jinyung Yoon on 2021/11/23.
//

import Foundation

struct MenuItem: Decodable {
    var name: String
    var price: Int
}

extension MenuItem: Equatable {
    static func == (lhs: MenuItem, rhs: MenuItem) -> Bool {
        return lhs.name == rhs.name && lhs.price == rhs.price
    }
}
