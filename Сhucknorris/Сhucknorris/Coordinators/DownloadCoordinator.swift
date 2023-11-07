
//
//  Created by Kr Qqq on 11.10.2023.
//

import UIKit

protocol DownloadCoordinatorProtocol {
    func showError(_ text: String)
}

final class DownloadCoordinator: DownloadCoordinatorProtocol {
   
    var navigationController: UINavigationController?
    
    func showError(_ text: String) {
        let alert = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        navigationController?.present(alert, animated: true, completion: nil)
    }
}
