//
//  MenuVC.swift
//  RxSwift_MVVM_Practice
//
//  Created by Jinyung Yoon on 2021/11/18.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class MenuVC: UIViewController {
    
    let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.spacing = 0
        return view
    }()
    let indicator = UIActivityIndicatorView()
    let tableView = UITableView()
    let itemCountLabel = UILabel()
    let totalPrice = UILabel()
    
    let viewModel = MenuListViewModel()
    var disposeBag = DisposeBag()
    
    
    func configureUI() {
        
        stackView.addArrangedSubview(makeTopView())
        stackView.addArrangedSubview(tableView)
        stackView.addArrangedSubview(makeBottomView())
        stackView.addArrangedSubview(makeOrdeButton())
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
        
        let itemCountUnitLabel = UILabel()
        itemCountUnitLabel.text = "Items"
        
        bottomView.addSubview(label)
        bottomView.addSubview(clearButton)
        bottomView.addSubview(itemCountLabel)
        bottomView.addSubview(itemCountUnitLabel)
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
        }
        
        itemCountUnitLabel.snp.makeConstraints { make in
            make.centerY.equalTo(itemCountLabel.snp.centerY)
            make.leading.equalTo(itemCountLabel.snp.trailing).offset(5)
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
        viewModel.clearAllItemSelections()
    }
    
    @objc func didTouchedOrder() {
        viewModel.onOrder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.register(MenuItemCell.self, forCellReuseIdentifier: MenuItemCell.reuseID)
        
        viewModel.menuObservable
            .observe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: MenuItemCell.reuseID, cellType: MenuItemCell.self)) {
                (index, item, cell) in
                cell.title.text = item.name
                cell.price.text = "\(item.price)"
                cell.count.text = "(\(item.count))"
                
                cell.onChange = { [weak self] increase in
                    self?.viewModel.changeCount(item: item, increase: increase)
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.itemsCount
            .map { "\($0)" }
            .observe(on: MainScheduler.instance)
            .bind(to: itemCountLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.totalPrice
            .map{ $0.currencyKR() }
            .observe(on: MainScheduler.instance)
            .bind(to: totalPrice.rx.text)
            .disposed(by: disposeBag)
        configureUI()
    }
}
