//
//  MenuStore.swift
//  RxSwift_MVVM_Practice
//
//  Created by GJC03280 on 2021/11/24.
//

import Foundation
import RxSwift

protocol MenuFetchable {
    func fetchMenus() -> Observable<[MenuItem]>
}

class MenuStore: MenuFetchable {
    func fetchMenus() -> Observable<[MenuItem]> {
        struct Response: Decodable {
            let menus: [MenuItem]
        }
        
        return APIService.fetchAllMenusRx()
            .map { data in
                guard let response = try? JSONDecoder().decode(Response.self, from: data) else {
                    throw NSError(domain: "Decoding Error", code: -1, userInfo: nil)
                }
                return response.menus
            }
    }
}
