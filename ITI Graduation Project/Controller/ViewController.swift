//
//  ViewController.swift
//  ITI Graduation Project
//
//  Created by Hamdy Youssef on 03/09/2023.
//

import UIKit
import RxCocoa
import RxSwift
import SDWebImage

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    var arrOfPhones: [[String: String]] = []
    var favorites: [FavoritesPhones] = [FavoritesPhones]()
    let cellSelectionSubject = PublishSubject<IndexPath>()
    var brand: String!
    var desc: String!
    var price: String!
    
    override func viewDidLoad() {
        fetchAndProcessData()
        favorites = UserDefaultsManager.shared().loadPhoneData() ?? []
        super.viewDidLoad()
    }
    
    func getDataFromNetworkLayer() {
        
    }
    // MARK: - Fetching and Processing Data
     func fetchAndProcessData() {
        fetchData { result in
            switch result {
            case .success(let phones):
                DispatchQueue.main.async {
                    self.processFetchedData(phones)
                    self.setupTableView()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    // MARK: - Fetching Data
     func fetchData(completion: @escaping (Result<[IphoneData], Error>) -> Void) {
        NetworkLayer.getData { error, mobArr in
            if let error = error {
                completion(.failure(error))
            } else if let mobArr = mobArr {
                completion(.success(mobArr))
            }
        }
    }

    // MARK: - Processing Data
     func processFetchedData(_ phones: [IphoneData]) {
        arrOfPhones = phones.map { phone in
            ["title": phone.title,
             "price": String(phone.price),
             "brand": phone.brand,
             "description": phone.description,
             "thumbnail": phone.thumbnail ?? "not found"]
        }
    }

    // MARK: - TableView Setup
     func setupTableView() {
         let arrayOfData = Observable.just(self.arrOfPhones)
        arrayOfData
            .bind(to: self.tableView
                .rx
                .items(cellIdentifier: "searchCell", cellType: searchCell.self)) {
                    (row, tableViewData, cell) in
                    self.configure(cell: cell, with: tableViewData)
                }
        .disposed(by: disposeBag)

        tableView
            .rx
            .itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.handleCellSelection(at: indexPath)
            })
            .disposed(by: disposeBag)
    }

    // MARK: - Configuring Cells
     func configure(cell: searchCell, with data: [String: Any]) {
        cell.searchName.text = data["title"] as? String
        cell.searchPrice.text = data["price"] as? String
        self.brand = data["brand"] as? String
        self.desc = data["description"] as? String
        cell.searchImage.sd_setImage(with: URL(string: (data["thumbnail"] as? String)!))
        setupAddToFavoritesGesture(for: cell)
    }

    // MARK: - Add to Favorites Gesture
     func setupAddToFavoritesGesture(for cell: searchCell) {
         cell.searchAddToFav.rx.tap
             .subscribe(onNext: { [weak self] in
                 if cell.searchAddToFav.currentImage == UIImage(systemName: "heart"){
                     cell.searchAddToFav.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                     let newProduct = FavoritesPhones(title: cell.searchName.text!, price: Double(cell.searchPrice.text ?? "0") ?? 0, thumbnail: cell.searchImage.image!)
                     self?.favorites.append(newProduct)
                     UserDefaultsManager.shared().savePhoneData(phone: self!.favorites)
                 }
                 else {
                     cell.searchAddToFav.setImage(UIImage(systemName: "heart"), for: .normal)
                     self!.removeFavrite(cell: cell)
                 }
             })
             .disposed(by: disposeBag)
     }
        

    // MARK: - Handle Cell Selection
     func handleCellSelection(at indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? searchCell {
            cell.isSelected = true
            // SELECTED
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let details = sb.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsVC
            if let title = cell.searchName.text,
               let price = cell.searchPrice.text,
               let image = cell.searchImage.image {
                details.titleName = title
                details.imagee = image
                details.Brand = brand
                details.Desc = desc
                details.Price = price
                present(details, animated: true)
            }
        }
    }
   
    func removeFavrite(cell: searchCell) {
        cell.searchAddToFav.setImage(UIImage(systemName: "heart"), for: .normal)
        let removeElement = FavoritesPhones(title: cell.searchName.text!, price: Double(cell.searchPrice.text ?? "0") ?? 0, thumbnail: cell.searchImage.image!)
        self.favorites.removeAll{$0 == removeElement}
        UserDefaultsManager.shared().savePhoneData(phone: self.favorites)

    }
}



