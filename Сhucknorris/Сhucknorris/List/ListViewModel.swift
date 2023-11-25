
//
//  Created by Kr Qqq on 11.10.2023.
//

import Foundation
import RealmSwift

final class ListViewModel {

    private let model: ListModel
    private let coordinator: ListCoordinatorProtocol
    private var quotes: Results<QuoteRealm>?
    
    init(model: ListModel, coordinator: ListCoordinatorProtocol) {
        self.model = model
        self.coordinator = coordinator
        updateQuotes()
    }
    
    func quotesCount() -> Int {
        guard let quotes = quotes else { return 0 }
        return quotes.count
    }
    
    func selectQuote(selectRow: Int) -> QuoteRealm {
        quotes![selectRow]
    }
    
    func updateQuotes() {
        do {
            quotes = try model.loadQuotes()
        } catch {
            print(error)
        }
    }
}
