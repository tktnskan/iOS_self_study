//
//  ViewController.swift
//  FirstRxSwiftApp
//
//  Created by GJC03280 on 2021/11/16.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    fileprivate let bag = DisposeBag()
    
    private let searchView: UISearchBar = UISearchBar()
    private let tableView: UITableView = UITableView()
    
    let userViewModelInstance = ViewModel()
    let userList = BehaviorRelay<[UserDetailModel]>(value: [])
    let filteredList = BehaviorRelay<[UserDetailModel]>(value: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        userViewModelInstance.fetchUserList()
        configureSearchView()
        configureTableView()
        createDismissKeyboardTapGesture()
    }
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    func configureSearchView() {
        view.addSubview(searchView)
        searchView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            make.height.equalTo(70)
        }
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reuseID)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchView.snp.bottom)
            make.leading.trailing.bottom.equalTo(view)
        }
        
        userViewModelInstance.userViewModelObserver.subscribe(onNext: { (value) in
            self.filteredList.accept(value)
            self.userList.accept(value)
        },onError: { error in
            self.errorAlert()
        }).disposed(by: bag)
        
        tableView.tableFooterView = UIView()

        filteredList.bind(to: tableView.rx.items(cellIdentifier: TableViewCell.reuseID, cellType: TableViewCell.self)) { row, model, cell in
            cell.bindCellData(userDetail: model)
        }.disposed(by: bag)
        
        Observable.combineLatest(userList.asObservable(), searchView.rx.text, resultSelector: { users, search in
            return users.filter { (user) -> Bool in
                self.filterUserList(userModel: user, searchText: search)
            }
        }).bind(to: filteredList).disposed(by: bag)
    }
    
    func filterUserList(userModel: UserDetailModel, searchText: String?) -> Bool {
        if let search = searchText, !search.isEmpty, !(userModel.userData.first_name?.contains(search) ?? false) {
            return false
        }
        return true
    }
    
    func errorAlert() {
        let alert = UIAlertController(title: "Error", message: "Check your Internet connection and Try Again!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

