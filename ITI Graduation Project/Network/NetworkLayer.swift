//
//  NetworkLayer.swift
//  ITI Graduation Project
//
//  Created by Hamdy Youssef on 03/09/2023.
//

import Foundation
import Alamofire


class NetworkLayer {
    static func getData(completion: @escaping (_ error: Error?, _ mobArr: [IphoneData]?) -> Void) {
        AF.request("https://dummyjson.com/products", method: HTTPMethod.get , parameters: nil, encoding: URLEncoding.default, headers: nil).response { response in
            print(response)
            
            guard response.error == nil else {
                print(response.error!)
                completion (response.error!, nil)
                return
            }
            
            guard let data = response.data else {
                
                return
            }
            do {
                print(data)
                let decoder = JSONDecoder()
                let iphone = try decoder.decode(myData.self, from: data)
                let mob = iphone.products
                completion(nil, mob)
                
            } catch let error {
                print(error)
                completion(error, nil)
                
            }
            
        }
        
    }
}
