
//
//  Created by Kr Qqq on 11.10.2023.
//

import Foundation
import RealmSwift

final class ListModel {
    
    func loadQuotes() throws -> Results<QuoteRealm> {
        guard let realm = try? RealmService.getRealm() else { throw RealmError.loadError }
        return realm.objects(QuoteRealm.self).sorted(byKeyPath: "createdAt")
    }
    
}
