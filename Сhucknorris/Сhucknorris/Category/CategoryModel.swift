
//
//  Created by Kr Qqq on 11.10.2023.
//

import Foundation
import RealmSwift

final class CategoryModel {

    func loadQuotes(category: CategoryRealm) -> Results<QuoteRealm> {

        let realm = try! Realm()
        return realm.objects(QuoteRealm.self).where{$0.categoryId.contains(category)}
    }
    
    func loadCategories() -> Results<CategoryRealm> {
        let realm = try! Realm()
        return realm.objects(CategoryRealm.self)
    }
}
