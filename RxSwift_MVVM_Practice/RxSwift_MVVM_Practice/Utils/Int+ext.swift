//
//  Int+ext.swift
//  RxSwift_MVVM_Practice
//
//  Created by Jinyung Yoon on 2021/11/23.
//

import Foundation

extension Int {
    func currencyKR() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.init(identifier: "ko_KR")
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
