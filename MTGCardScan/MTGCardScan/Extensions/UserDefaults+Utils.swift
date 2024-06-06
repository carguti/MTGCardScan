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
        get {
            guard let onBoardingShown = get(objectType: Bool.self, forKey: UserDefaultsOnBoardingKeys.kOnBoardingShown) else { return false }
            return onBoardingShown
        }
        
        set {
            set(object: newValue, forKey: UserDefaultsOnBoardingKeys.kOnBoardingShown)
            
            synchronize()
        }
    }
}

// MARK: - Selected card
extension UserDefaults {
    struct UserDefaultsSelectedCardKeys {
        static let kSelectedCard = "SelectedCard"
    }
    
    // MARK: - Get fav cards
    var selectedCard: Card? {
        get {
            guard let selectedCard = get(objectType: Card.self, forKey: UserDefaultsSelectedCardKeys.kSelectedCard) else { return nil }
            return selectedCard
        }
        
        set {
            set(object: newValue, forKey: UserDefaultsSelectedCardKeys.kSelectedCard)
            
            synchronize()
        }
    }
}

// MARK: - Selected card image
extension UserDefaults {
    struct UserDefaultsSelectedCardImageKeys {
        static let kSelectedCardImageUri = "SelectedCardImageUri"
    }
    
    // MARK: - Get fav cards
    var selectedCardImageUri: String {
        get {
            guard let selectedCardImageUri = get(objectType: String.self, forKey: UserDefaultsSelectedCardImageKeys.kSelectedCardImageUri) else { return "" }
            return selectedCardImageUri
        }
        
        set {
            set(object: newValue, forKey: UserDefaultsSelectedCardImageKeys.kSelectedCardImageUri)
            
            synchronize()
        }
    }
}

// MARK: - Selected card edition
extension UserDefaults {
    struct UserDefaultsSelectedCardEditionKeys {
        static let kSelectedCardEdition = "SelectedCardEdition"
    }
    
    // MARK: - Get fav cards
    var selectedCardEdition: String {
        get {
            guard let selectedCardEdition = get(objectType: String.self, forKey: UserDefaultsSelectedCardEditionKeys.kSelectedCardEdition) else { return "" }
            return selectedCardEdition
        }
        
        set {
            set(object: newValue, forKey: UserDefaultsSelectedCardEditionKeys.kSelectedCardEdition)
            
            synchronize()
        }
    }
}

// MARK: - Historial cards
extension UserDefaults {
    struct UserDefaultsCardsHistorialKeys {
        static let kCardsHistorial = "CardsHistorial"
    }
    
    // MARK: - Get fav cards
    var cardsHistorial: [Card] {
        get {
            guard let favCards = get(objectType: [Card].self, forKey: UserDefaultsCardsHistorialKeys.kCardsHistorial) else { return [] }
            return favCards
        }
        
        set {
            set(object: newValue, forKey: UserDefaultsCardsHistorialKeys.kCardsHistorial)
            
            synchronize()
        }
    }
}

// MARK: - Fav cards
extension UserDefaults {
    struct UserDefaultsFavCardsKeys {
        static let kFavCards = "FavCards"
    }
    
    // MARK: - Get fav cards
    var favCards: [Card] {
        get {
            guard let favCards = get(objectType: [Card].self, forKey: UserDefaultsFavCardsKeys.kFavCards) else { return [] }
            return favCards
        }
        
        set {
            set(object: newValue, forKey: UserDefaultsFavCardsKeys.kFavCards)
            
            synchronize()
        }
    }
}
