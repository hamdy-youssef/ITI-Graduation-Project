//
//  FavoritesVC.swift
//  ITI Graduation Project
//
//  Created by Hamdy Youssef on 03/09/2023.
//

import UIKit
import RxSwift
import RxCocoa

class FavoritesVC: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.delegate = nil
        tableView.dataSource = nil
        setTableData()
    }
    
    func setTableData() {
        var dataArray = UserDefaultsManager.shared().loadPhoneData() ?? []
        var favorites = Observable.just(dataArray)
        favorites
            .bind(to: self.tableView
                .rx
                .items(cellIdentifier: "favoritesCell", cellType: favoritesCell.self)) {
                    (row, tableViewData, cell) in
                    cell.favName.text = dataArray[row].title
                    cell.favPrice.text = String((dataArray[row].price))
                    cell.favImage.image = dataArray[row].thumbnailData

                }
                .disposed(by: self.disposeBag)
        
    }
    
    
    
}
