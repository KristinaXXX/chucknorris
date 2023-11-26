
//
//  Created by Kr Qqq on 11.10.2023.
//

import Foundation
import RealmSwift

final class CategoryModel {

    func loadQuotes(category: CategoryRealm) throws -> Results<QuoteRealm> {
        guard let realm = try? RealmService.getRealm() else { throw RealmError.loadError }
        return realm.objects(QuoteRealm.self).where{$0.categoryId.contains(category)}
    }
    
    func loadCategories() throws -> Results<CategoryRealm> {
        guard let realm = try? RealmService.getRealm() else { throw RealmError.loadError }
        return realm.objects(CategoryRealm.self)
    }
}
