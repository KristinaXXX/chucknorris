
//
//  Created by Kr Qqq on 05.11.2023.
//

import Foundation
import RealmSwift

final class DownloadModel {
  
    func takeCategory(_ title: String) -> CategoryRealm? {
        let realm = try! Realm()
        let categoriesRealm = realm.objects(CategoryRealm.self).filter("title == %@", title)
        if categoriesRealm.isEmpty {
            let categoryRealm = CategoryRealm()
            categoryRealm.title = title
            try! realm.write {
                realm.add(categoryRealm)
            }
            return categoryRealm
        } else {
            return categoriesRealm[0]
        }
    }
    
    func findQuote(_ id: String) -> QuoteRealm? {
        let realm = try! Realm()
        let quotesRealm = realm.objects(QuoteRealm.self).filter("id == %@", id)
        if !quotesRealm.isEmpty {
            return quotesRealm[0]
        }
        return nil
    }
    
    func createQuote(quote: Quote) {
        let realm = try! Realm()
        let quoteRealm = QuoteRealm()
        quoteRealm.title = quote.value
        quoteRealm.id = quote.id
        quoteRealm.createdAt = NSDate() as Date
        
        for category in quote.categories {
            if let categoryRealm = takeCategory(category) {
                quoteRealm.categoryId.append(categoryRealm)
            }
        }
        try! realm.write {
            realm.add(quoteRealm)
        }
    }
}

