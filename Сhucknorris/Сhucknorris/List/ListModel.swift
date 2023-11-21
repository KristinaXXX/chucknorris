
//
//  Created by Kr Qqq on 11.10.2023.
//

import Foundation
import RealmSwift

final class ListModel {
    
    func loadQuotes() -> Results<QuoteRealm> {
        let realm = try! Realm()
        return realm.objects(QuoteRealm.self).sorted(byKeyPath: "createdAt")
    }
    
}
