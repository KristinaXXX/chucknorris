
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
            updateQuotes()
        } else {
            updateCategories()
        }
    }
    
    func setCategory(category: CategoryRealm) {
        self.category = category
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
            quotes = try model.loadQuotes(category: category!)
        } catch {
            print(error)
        }
    }
    
    func categoriesCount() -> Int {
        guard let categories = categories else { return 0 }
        return categories.count
    }
    
    func selectCategory(selectRow: Int) -> CategoryRealm {
        categories![selectRow]
    }
    
    func updateCategories() {
        do {
            categories = try model.loadCategories()
        } catch {
            print(error)
        }
    }

}
