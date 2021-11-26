//
//  UIViewController+ext.swift
//  RxSwift_MVVM_Practice
//
//  Created by GJC03280 on 2021/11/24.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alertVC, animated: true)
    }
}
