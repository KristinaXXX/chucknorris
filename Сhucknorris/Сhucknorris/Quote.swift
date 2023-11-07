//
//  Quote.swift
//  Сhucknorris
//
//  Created by Kr Qqq on 06.11.2023.
//

import Foundation
import RealmSwift

class QuoteRealm: Object {
    @Persisted var id: String
    @Persisted var title: String
    @Persisted var categoryId: List<CategoryRealm>
    @Persisted var createdAt: Date
}

class CategoryRealm: Object {
    @Persisted var title: String
}

struct Quote: Codable {
    let categories: [String]
    let createdAt: String
    let iconURL: String
    let id, updatedAt: String
    let url: String
    let value: String

    enum CodingKeys: String, CodingKey {
        case categories
        case createdAt = "created_at"
        case iconURL = "icon_url"
        case id
        case updatedAt = "updated_at"
        case url, value
    }
}

