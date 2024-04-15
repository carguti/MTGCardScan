//
//  UserDefaults+Utils.swift
//  MTGCardScan
//
//  Created by Carlos Gutiérrez Casado on 15/4/24.
//

import Foundation
 
// MARK: - Custom objects
 
extension UserDefaults {
 
    /// Check for user defaults key existence
    /// - Parameter key: Key to check
    /// - Returns: <code>True</code> if the key exists or <code>false</code> in other case
    static func exists(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    /// Set Codable object into UserDefaults or remove it if object is nil
    /// - Parameters:
    ///   - object: Codable Object
    ///   - forKey: Key string
    public func set<T: Codable>(object: T?, forKey: String) {
        guard let object = object else {
            removeObject(forKey: forKey)
            
            synchronize()
            
            return
        }
        
        let jsonData = try! JSONEncoder().encode(object)
 
        set(jsonData, forKey: forKey)
        
        synchronize()
    }
 
    /// Get Codable object from UserDefaults
    /// - Parameters:
    ///   - object: Codable Object
    ///   - forKey: Key string
    
    
    /// Get Codable object from UserDefaults
    /// - Parameters:
    ///   - objectType: Codable Object
    ///   - forKey: Key string
    /// - Returns: The object if it exists or nil in other case
    public func get<T: Codable>(objectType: T.Type, forKey: String) -> T? {
        guard let result = value(forKey: forKey) as? Data else {
            return nil
        }
 
        return try! JSONDecoder().decode(objectType, from: result)
    }
}
 
// MARK: - OnBoarding
extension UserDefaults {
    struct UserDefaultsOnBoardingKeys {
        static let kOnBoardingShown = "OnBoardingShown"
    }
    
    // MARK: - OnBoarding shown
    var onBoardingShown: Bool {
        get{
            guard let onBoardingShown = get(objectType: Bool.self, forKey: UserDefaultsOnBoardingKeys.kOnBoardingShown) else { return false }
            return onBoardingShown
        }
        
        set {
            set(object: newValue, forKey: UserDefaultsOnBoardingKeys.kOnBoardingShown)
            
            synchronize()
        }
    }
}
