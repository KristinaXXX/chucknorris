//
//  RealmService.swift
//  Сhucknorris
//
//  Created by Kr Qqq on 21.11.2023.
//

import Foundation
import RealmSwift

class RealmService {
    
    public static func getRealm() throws -> Realm {
        let configuration = Realm.Configuration(encryptionKey: getKey())
        guard let realm = try? Realm(configuration: configuration) else {
            print("RealmError.configurationError")
            throw RealmError.configurationError
        }
        return realm
    }
    
    public static func deleteRealm() {
        try! FileManager.default.removeItem(at: Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    private static func getKey() -> Data {
        let keychainIdentifier = "io.Realm.EncryptionExampleKey"
        let keychainIdentifierData = keychainIdentifier.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        var query: [NSString: AnyObject] = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
            kSecAttrKeySizeInBits: 512 as AnyObject,
            kSecReturnData: true as AnyObject
        ]

        var dataTypeRef: AnyObject?
        var status = withUnsafeMutablePointer(to: &dataTypeRef) { SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0)) }
        if status == errSecSuccess {
            return dataTypeRef as! Data
        }

        var key = Data(count: 64)
        key.withUnsafeMutableBytes({ (pointer: UnsafeMutableRawBufferPointer) in
            let result = SecRandomCopyBytes(kSecRandomDefault, 64, pointer.baseAddress!)
            assert(result == 0, "Failed to get random bytes")
        })

        query = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
            kSecAttrKeySizeInBits: 512 as AnyObject,
            kSecValueData: key as AnyObject
        ]
        status = SecItemAdd(query as CFDictionary, nil)
        assert(status == errSecSuccess, "Failed to insert the new key in the keychain")
        return key
    }
}
