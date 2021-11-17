//
//  DataModel.swift
//  FirstRxSwiftApp
//
//  Created by GJC03280 on 2021/11/17.
//

import Foundation

struct DataModel: Codable {
    let page: Int?
    let per_page: Int?
    let total: Int?
    let total_page: Int?
    let data: [UserDetail]?
}
