//
//  User Defaults.swift
//  ITI Graduation Project
//
//  Created by Hamdy Youssef on 03/09/2023.
//

import Foundation

class UserDefaultsManager {
    
    private static let sharedInstance = UserDefaultsManager ()
    static func shared () -> UserDefaultsManager {
        return UserDefaultsManager.sharedInstance
    }
    
    private init() {}
    
    func savePhoneData(phone: [FavoritesPhones]) {
        let encoder = JSONEncoder ()
        if let encodedPhone = try? encoder.encode (phone) {
            let def = UserDefaults.standard
            def.set(encodedPhone, forKey: "phone")
        }
    }
    
    func loadPhoneData() -> [FavoritesPhones]? {
        let def = UserDefaults.standard
        if let savedPhone = def.object(forKey: "phone") as? Data {
            let decoder = JSONDecoder ( )
            if let savedPhone = try? decoder.decode ([FavoritesPhones].self, from: savedPhone) {
                return savedPhone
            }
        }
        return nil
    }
}
