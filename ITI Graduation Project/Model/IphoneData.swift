//
//  IphoneData.swift
//  ITI Graduation Project
//
//  Created by Hamdy Youssef on 03/09/2023.
//

import Foundation
import UIKit

struct myData: Codable {
    let products: [IphoneData]
    let total: Int
    let skip: Int
    let limit: Int
}

struct IphoneData: Codable {
    
    let id: Int
    let title: String
    let description: String
    let price: Double
    let discountPercentage: Double
    let rating: Double
    let stock: Int
    let brand: String
    let category: String
    let thumbnail: String
    let images: [String]
    
}


struct FavoritesPhones: Codable, Equatable{
    
    let title: String
    let price: Double
    let thumbnail: Data
    
    var thumbnailData: UIImage? {
        return UIImage(data: thumbnail)
    }
    
    init(title: String, price: Double, thumbnail: UIImage) {
           self.title = title
           self.price = price
        self.thumbnail = thumbnail.jpegData(compressionQuality: 1.0) ?? Data()
       }
    
}

