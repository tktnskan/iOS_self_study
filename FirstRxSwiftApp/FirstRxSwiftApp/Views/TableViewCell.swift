//
//  TableViewCell.swift
//  FirstRxSwiftApp
//
//  Created by GJC03280 on 2021/11/17.
//

import UIKit
import SnapKit

class TableViewCell: UITableViewCell {
    
    static let reuseID = "TableViewCell"
    
    private let userName = UILabel()
    private let favoriteImage = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        userName.text = "Name"
        favoriteImage.image = UIImage(systemName: "star.fill")
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(userName)
        contentView.addSubview(favoriteImage)
        
        userName.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView).offset(10)
            make.bottom.equalTo(contentView).offset(-10)
            make.height.equalTo(40)
        }
        
        favoriteImage.snp.makeConstraints { make in
            make.leading.equalTo(userName.snp.trailing).offset(10)
            make.top.equalTo(contentView).offset(10)
            make.bottom.trailing.equalTo(contentView).offset(-10)
            make.width.height.equalTo(30)
        }
    }
    
    func bindCellData(userDetail: UserDetailModel) {
        userName.text = userDetail.userData.first_name
        if userDetail.isFavorite.value {
            favoriteImage.image = UIImage(systemName: "star.fill")
        } else {
            favoriteImage.image = UIImage(systemName: "star")
        }
        favoriteImage.image?.withTintColor(UIColor(red: 212/255, green: 163/255, blue: 50/255, alpha: 1.0))
    }
}
