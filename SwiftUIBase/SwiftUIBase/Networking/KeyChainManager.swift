//
//  KeyChainManager.swift
//  PracticalAction
//
//  Created by manjil on 29/03/2023.
//

import Foundation
import SwiftKeychainWrapper

enum KeyChainKey: String {
    case authModel = "AUTH_MODEL"
}


class KeyChainManager {
    
    //MARK: Properties
    public static let standard = KeyChainManager()
    
    //MARK: Functions
    public func set<T: Codable>(object: T, forKey key: KeyChainKey) {
        let encoded = KeyChainManager.standard.encode(object: object)
        KeychainWrapper.standard[KeychainWrapper.Key(rawValue: key.rawValue)] = encoded
    }
    
    //GET ANY TYPE OF CODABLE OBJECT IN KEYCHAIN
    public func retrieve<T: Codable>(type: T.Type, forKey key: KeyChainKey) -> T? {
        guard  let dataObject = KeychainWrapper.standard.data(forKey: key.rawValue) else {
            print("\(T.self) NO_DATA SAVED")
            return nil
        }
        return KeyChainManager.standard.decode(json: dataObject, as: type)
    }
    
    //CHCEK IF ANY TYPE OF CODABLE OBJECT IN KEYCHAIN IS AVAILABLE
    public func isAvailable<T: Codable> (type: T.Type, forKey key: KeyChainKey) -> Bool {
        let decoded = KeyChainManager.standard.retrieve(type: T.self, forKey: key)
        return decoded != nil
    }
    
    //CLEAR ANY TYPE OF CODABLE OBJECT IN KEYCHAIN IS AVAILABLE
    public func clear(_ key: KeyChainKey? = nil) {
        if let key = key {
            KeychainWrapper.standard.removeObject(forKey: key.rawValue)
        } else {
            KeychainWrapper.standard.removeAllKeys()
        }
    }
    
}

extension KeyChainManager {
    
    private func encode<T: Codable>(object: T) -> Data? {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            return try encoder.encode(object)
        } catch let error {
            print(error.localizedDescription)
        }
        return nil
    }
    
    private func decode<T: Decodable>(json: Data, as clazz: T.Type) -> T? {
        do {
            let decoder = JSONDecoder()
            let data = try decoder.decode(T.self, from: json)
            return data
        } catch {
            print("An error occurred while parsing JSON")
        }
        return nil
    }
}

enum CacheKey: String {
    case isAppInstall
    case dashboardData
}

struct Cacher {
    let userDefault = UserDefaults.standard
    @discardableResult
    func set<T: Codable>(object: T, key: CacheKey) -> Bool {
        do {
            let encodedValue = try JSONEncoder().encode(object)
            userDefault.setValue(encodedValue, forKey: key.rawValue)
            return userDefault.synchronize()
        } catch {
            return false
        }
    }
    
    func get<T: Codable>(type: T.Type,  forKey key: CacheKey) -> T? {
        guard let data = userDefault.value(forKey: key.rawValue) as? Data else { return nil }
        do {
            let decodedValue = try JSONDecoder().decode(T.self, from: data)
            return decodedValue
        } catch {
            return nil
        }
    }
    
    @discardableResult
    func set(value: Any, key: CacheKey) -> Bool {
        userDefault.setValue(value, forKey: key.rawValue)
        return userDefault.synchronize()
    }
    
    func get<T>(type: T.Type, key: CacheKey) -> T?   {
        return userDefault.value(forKey: key.rawValue) as? T
    }
    
    @discardableResult
    public func delete(forKey key: CacheKey) -> Bool {
        userDefault.removeObject(forKey: key.rawValue)
        return userDefault.synchronize()
    }
}
