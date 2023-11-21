
//
//  Created by Kr Qqq on 11.10.2023.
//

import Foundation
import RealmSwift

final class CategoryViewModel {

    private let model: CategoryModel
    private let coordinator: CategoryCoordinatorProtocol
    private var quotes: Results<QuoteRealm>?
    private var categories: Results<CategoryRealm>?
    private var category: CategoryRealm?
    
    init(model: CategoryModel, coordinator: CategoryCoordinatorProtocol) {
        self.model = model
        self.coordinator = coordinator
        if category != nil {
            quotes = model.loadQuotes(category: category!)
        } else {
            categories = model.loadCategories()
        }
    }
    
    func setCategory(category: CategoryRealm) {
        self.category = category
    }
    
    func quotesCount() -> Int {
        quotes!.count
    }
    
    func selectQuote(selectRow: Int) -> QuoteRealm {
        quotes![selectRow]
    }
    
    func updateQuotes() {
        quotes = model.loadQuotes(category: category!)
    }
    
    func categoriesCount() -> Int {
        categories!.count
    }
    
    func selectCategory(selectRow: Int) -> CategoryRealm {
        categories![selectRow]
    }
    
    func updateCategories() {
        categories = model.loadCategories()
    }

}
