//
//  MenuVC.swift
//  RxSwift_MVVM_Practice
//
//  Created by Jinyung Yoon on 2021/11/18.
//

import UIKit

class MenuVC: UIViewController {
    
    var stackView = OrderCountView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.isNavigationBarHidden = true
        stackView.delegate = self
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension MenuVC: OrderCountViewDelegate {
    func didTouchedOrder() {
        let nextVC = OrderVC()
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
