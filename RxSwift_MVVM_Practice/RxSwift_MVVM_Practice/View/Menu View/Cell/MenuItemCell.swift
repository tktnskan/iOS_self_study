//
//  MenuItemCell.swift
//  RxSwift_MVVM_Practice
//
//  Created by Jinyung Yoon on 2021/11/18.
//

import UIKit
import SnapKit

class MenuItemCell: UITableViewCell {

    static let reuseID = "MenuItemCell"
    
    let price = UILabel()
    let title = UILabel()
    let count = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    private func configureUI() {
        let first = makeFirstStackView()
        let second = makeSecondStackView()
        price.text = "1,000"
        contentView.addSubview(first)
        contentView.addSubview(second)
        contentView.addSubview(price)
        
        first.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(8)
            make.bottom.equalTo(contentView.snp.bottom).offset(-8)
            make.leading.equalTo(contentView.snp.leading).offset(20)
        }
        
        second.snp.makeConstraints { make in
            make.leading.equalTo(first.snp.trailing).offset(16)
            make.centerY.equalTo(first.snp.centerY)
        }
        
        price.snp.makeConstraints { make in
            make.leading.greaterThanOrEqualTo(second.snp.trailing).offset(16)
            make.trailing.equalTo(contentView.snp.trailing).offset(-20)
            make.centerY.equalTo(first.snp.centerY)
        }
        
    }
    
    private func makeFirstStackView() -> UIStackView {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fill
        view.spacing = 0
        
        let plusButton = UIButton()
        plusButton.setTitle("+", for: .normal)
        plusButton.setTitleColor(.gray, for: .normal)
        plusButton.addTarget(self, action: #selector(didTouchedPlus), for: .touchUpInside)
        
        plusButton.snp.makeConstraints { make in
            make.width.equalTo(32)
//            make.height.equalTo(28)
        }
        
        let minusButton = UIButton()
        minusButton.setTitle("-", for: .normal)
        minusButton.setTitleColor(.gray, for: .normal)
        minusButton.addTarget(self, action: #selector(didTouchedMinus), for: .touchUpInside)
        
        minusButton.snp.makeConstraints { make in
            make.width.equalTo(32)
//            make.height.equalTo(28)
        }
        
        view.addArrangedSubview(plusButton)
        view.addArrangedSubview(minusButton)
        
        return view
    }
    
    private func makeSecondStackView() -> UIStackView {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fill
        view.spacing = 8
        
        view.addArrangedSubview(title)
        view.addArrangedSubview(count)
        
        return view
    }
    
    @objc func didTouchedPlus() {
        
    }
    
    @objc func didTouchedMinus() {
        
    }
}
