//
//  UITextView+ext.swift
//  RxSwift_MVVM_Practice
//
//  Created by GJC03280 on 2021/11/24.
//

import UIKit

extension UITextView {
    func calHeight() -> CGFloat {
        
        func heightWithConstrainedWidth(text: String, width: CGFloat, font: UIFont) -> CGFloat {
            let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
            let boundingBox = text.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
            return boundingBox.height
        }
        
        guard let text = self.text, let font = self.font else {
            return 0
        }
        let width = bounds.width
        return heightWithConstrainedWidth(text: text, width: width, font: font)
    }
}
