//
//  ViewModel.swift
//  FirstRxSwiftApp
//
//  Created by GJC03280 on 2021/11/17.
//

import Foundation
import RxCocoa
import RxSwift

struct UserDetailModel {
    var userData: UserDetail
    var isFavorite: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    var isFavObservable: Observable<Bool> {
        return isFavorite.asObservable()
    }
}

class ViewModel {
    
    let request = APIRequest()
    var users: Observable<[UserDetail]>?
    private let userViewModel = BehaviorRelay<[UserDetailModel]>(value: [])
    var userViewModelObserver: Observable<[UserDetailModel]> {
        return userViewModel.asObservable()
    }
    
    private let disposeBag = DisposeBag()
    
    func fetchUserList() {
        users = request.callAPI()
        users?.subscribe(onNext: { (value) in
            var userViewModelArray = [UserDetailModel]()
            for index in 0..<value.count {
                let user = UserDetailModel(userData: value[index])
                userViewModelArray.append(user)
            }
            self.userViewModel.accept(userViewModelArray)
        }, onError: { (error) in
            _ = self.userViewModel.catch { (error) in
                Observable.empty()
            }
            print(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
}
