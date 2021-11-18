//
//  OrderVC.swift
//  RxSwift_MVVM_Practice
//
//  Created by Jinyung Yoon on 2021/11/18.
//

import UIKit
import SnapKit

class OrderVC: UIViewController {

    var ordersList: UITextView = UITextView()
    var ordersListHeight: CGFloat = 0
    var itemsPrice = CustomLabel(textAlignment: .right, size: 17, weight: .regular, defaultText: "₩0")
    var vatPrice = CustomLabel(textAlignment: .right, size: 17, weight: .regular, defaultText: "₩0")
    var totalPrice = CustomLabel(textAlignment: .right, size: 50, weight: .bold, defaultText: "₩0")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Receipt"
        view.backgroundColor = .systemBackground
        //let totalPrice = 0
        //let vatPrice = Int(Float(allItemsPrice) * 0.1 / 10 + 0.5) * 10
        
        // TODO: update selected menu info
        ordersList.text = """
        SELECTED MENU 1
        SELECTED MENU 2
        SELECTED MENU 3
        SELECTED MENU 4
        SELECTED MENU 5
        SELECTED MENU 6
        SELECTED MENU 7
        SELECTED MENU 8
        SELECTED MENU 9
        """
        
        updateTextViewHeight()
        configureUI()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func updateTextViewHeight() {
        ordersList.font = UIFont.systemFont(ofSize: 32, weight: .thin)
        let text = ordersList.text ?? ""
        let width = ordersList.bounds.width
        let font = ordersList.font ?? UIFont.systemFont(ofSize: 20)

        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = text.boundingRect(with: constraintRect,
                                            options: [.usesLineFragmentOrigin, .usesFontLeading],
                                            attributes: [NSAttributedString.Key.font: font],
                                            context: nil)
        let height = boundingBox.height

        ordersListHeight = height + 40
    }
    
    private func configureUI() {
        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        let innerView = UIView()
        scrollView.addSubview(innerView)
        innerView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(scrollView)
            make.width.equalToSuperview()
            make.height.equalTo(view).priority(1)
        }
        
        let outerStackView = UIStackView()
        outerStackView.spacing = 8
        outerStackView.distribution = .fill
        outerStackView.axis = .vertical
        innerView.addSubview(outerStackView)
        outerStackView.snp.makeConstraints { make in
            make.bottom.top.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        outerStackView.addArrangedSubview(makeEmptyView(height: 30))
        
        let orderitems = CustomLabel(textAlignment: .left, size: 24, weight: .medium, defaultText: "Ordered Items")
        outerStackView.addArrangedSubview(orderitems)
        
        outerStackView.addArrangedSubview(ordersList)
        
        ordersList.snp.makeConstraints { make in
            make.height.equalTo(ordersListHeight)
        }
        
        outerStackView.addArrangedSubview(makeEmptyView(height: 30))
        
        let priceToPay = CustomLabel(textAlignment: .left, size: 24, weight: .medium, defaultText: "Price to pay")
        outerStackView.addArrangedSubview(priceToPay)
        
        outerStackView.addArrangedSubview(makeInnerStackView(first: CustomLabel(textAlignment: .left, size: 28, weight: .thin, defaultText: "Items"), second: itemsPrice))
        outerStackView.addArrangedSubview(makeInnerStackView(first: CustomLabel(textAlignment: .left, size: 28, weight: .thin, defaultText: "VAT"), second: vatPrice))
        
        outerStackView.addArrangedSubview(makeEmptyView(height: 16))
        outerStackView.addArrangedSubview(makeEmptyView(height: 1, color: .lightGray))
        outerStackView.addArrangedSubview(makeEmptyView(height: 16))
        outerStackView.addArrangedSubview(totalPrice)
        outerStackView.addArrangedSubview(makeEmptyView(height: 40))
    }
    
    func makeEmptyView(height: CGFloat, color: UIColor = .systemBackground) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        view.snp.makeConstraints { make in
            make.height.equalTo(height)
        }
        return view
    }
    
    func makeInnerStackView(first: UILabel, second: UILabel) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 0
        
        stack.addArrangedSubview(first)
        stack.addArrangedSubview(second)
        
        return stack
    }
}



class CustomLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment, size: CGFloat, weight: UIFont.Weight, defaultText: String? = nil) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.text = defaultText
        self.textColor = .secondaryLabel
        self.font = UIFont.systemFont(ofSize: size, weight: weight)
    }
}

