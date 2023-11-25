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
        var key = Data(count: 64)
        _ = key.withUnsafeMutableBytes { (pointer: UnsafeMutableRawBufferPointer) in
            SecRandomCopyBytes(kSecRandomDefault, 64, pointer.baseAddress!)
        }
        let configuration = Realm.Configuration(encryptionKey: key)
        guard let realm = try? Realm(configuration: configuration) else {
            print("RealmError.configurationError")
            throw RealmError.configurationError
        }
        return realm
    }
    
    public static func deleteRealm() {

        try! FileManager.default.removeItem(at: Realm.Configuration.defaultConfiguration.fileURL!)
    }
}
