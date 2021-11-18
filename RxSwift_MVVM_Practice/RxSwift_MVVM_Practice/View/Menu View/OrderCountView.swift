//
//  OrderCountView.swift
//  RxSwift_MVVM_Practice
//
//  Created by Jinyung Yoon on 2021/11/18.
//

import UIKit
 
protocol OrderCountViewDelegate: AnyObject{
    func didTouchedOrder()
}

class OrderCountView: UIStackView {

    let indicator = UIActivityIndicatorView()
    let tableView = UITableView()
    let itemCountLabel = UILabel()
    let totalPrice = UILabel()
    
    weak var delegate: OrderCountViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        axis = .vertical
        distribution = .fill
        spacing = 0
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MenuItemCell.self, forCellReuseIdentifier: MenuItemCell.reuseID)
        
        totalPrice.text = "1,000,000"
        itemCountLabel.text = "0 Items"
        configureUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        
        addArrangedSubview(makeTopView())
        addArrangedSubview(tableView)
        addArrangedSubview(makeBottomView())
        addArrangedSubview(makeOrdeButton())
    }
    
    func makeTopView() -> UIView {
        let topView = UIView()
        let label = UILabel()
        label.text = "Fried Center"
        label.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        
        indicator.style = UIActivityIndicatorView.Style.large
        indicator.color = .lightGray
        
        topView.addSubview(label)
        topView.addSubview(indicator)
        
        label.snp.makeConstraints { make in
            make.centerY.equalTo(topView.snp.centerY)
            make.leading.equalTo(topView.snp.leading).offset(20)
            make.trailing.greaterThanOrEqualTo(topView.snp.trailing).offset(-20)
        }
        
        indicator.snp.makeConstraints { make in
            make.centerY.equalTo(label.snp.centerY)
            make.leading.equalTo(label.snp.trailing).offset(16)
        }
        
        topView.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        
        return topView
    }
    
    func makeBottomView() -> UIView {
        let bottomView = UIView()
        let label = UILabel()
        label.text = "Your Order"
        let clearButton = UIButton()
        clearButton.setTitle("Clear", for: .normal)
        clearButton.addTarget(self, action: #selector(didTouchedClear), for: .touchUpInside)
        
        bottomView.addSubview(label)
        bottomView.addSubview(clearButton)
        bottomView.addSubview(itemCountLabel)
        bottomView.addSubview(totalPrice)
        
        label.snp.makeConstraints { make in
            make.top.equalTo(bottomView).offset(10)
            make.leading.equalTo(bottomView).offset(20)
        }
        
        clearButton.snp.makeConstraints { make in
            make.width.greaterThanOrEqualTo(48)
            make.height.equalTo(36)
            make.centerY.equalTo(label.snp.centerY)
            make.leading.equalTo(label.snp.trailing).offset(16)
        }
        
        itemCountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(label.snp.centerY)
            make.leading.greaterThanOrEqualTo(label.snp.trailing).offset(16)
            make.leading.greaterThanOrEqualTo(clearButton.snp.trailing).offset(20)
            make.trailing.equalTo(bottomView).offset(-20)
        }
        
        totalPrice.snp.makeConstraints { make in
            make.leading.greaterThanOrEqualTo(bottomView).offset(20)
            make.trailing.equalTo(bottomView).offset(-20)
            make.bottom.equalTo(bottomView).offset(-16)
            make.top.equalTo(itemCountLabel.snp.bottom).offset(16)
        }
        
        return bottomView
    }
    
    func makeOrdeButton() -> UIButton {
        let btn = UIButton()
        btn.setTitle("ORDER", for: .normal)
        btn.backgroundColor = .blue
        btn.addTarget(self, action: #selector(didTouchedOrder), for: .touchUpInside)
        btn.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        
        return btn
    }
    
    @objc func didTouchedClear() {
        
    }
    
    @objc func didTouchedOrder() {
        delegate?.didTouchedOrder()
    }
}

extension OrderCountView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItemCell") as! MenuItemCell
        
        cell.title.text = "MENU \(indexPath.row)"
        cell.price.text = "\(indexPath.row * 100)"
        cell.count.text = "(0)"
        
        return cell
    }
}
