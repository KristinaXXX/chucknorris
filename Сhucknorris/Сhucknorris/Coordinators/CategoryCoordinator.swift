
//
//  Created by Kr Qqq on 11.10.2023.
//

import UIKit

protocol CategoryCoordinatorProtocol {
    func showErrorRecorder(_ text: String)
}

final class CategoryCoordinator: CategoryCoordinatorProtocol {
   
    var navigationController: UINavigationController?
    
    func showErrorRecorder(_ text: String) {
        let alert = UIAlertController(title: "Error recorder", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        navigationController?.present(alert, animated: true, completion: nil)
    }
}
