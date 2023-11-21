//
//  Download.swift
//  Сhucknorris
//
//  Created by Kr Qqq on 05.11.2023.
//

import Foundation
//import RealmSwift

final class DownloadViewModel {

    private let model: DownloadModel
    private let coordinator: DownloadCoordinator
    
    init(model: DownloadModel, coordinator: DownloadCoordinator) {
        self.model = model
        self.coordinator = coordinator
    }
    
    func loadRandom(completionView: @escaping () -> Void) {
        
        NetworkService.requestJSONDecoder(appConfiguration: .chucknorrisRandom, completion: { [weak self] result in
            switch result {
            case .success(let quote):
                if let quote = quote as? Quote {
                    if self?.model.findQuote(quote.id) == nil {
                        self?.model.createQuote(quote: quote)
                    }
                }
            case .failure(let error):
                self?.coordinator.showError(error.localizedDescription)
            }
            completionView()
        })
        
    }
}
