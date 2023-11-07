
//
//  Created by Kr Qqq on 11.10.2023.
//

import UIKit

final class FactoryTab {
    enum Flow {
        case download
        case list
        case category
    }
    
    private let flow: Flow
    let navigationController = UINavigationController()
    
    init(flow: Flow) {
        self.flow = flow
        startModule()
    }
    
    private func startModule() {
        switch flow {
            
        case .download:
            let coordinator = DownloadCoordinator()
            let model = DownloadModel()
            let viewModel = DownloadViewModel(model: model, coordinator: coordinator)
            let viewController = DownloadViewController(viewModel: viewModel)
            viewController.tabBarItem = UITabBarItem(title: "Download", image: UIImage(systemName: "square.and.arrow.down"), tag: 0)
            coordinator.navigationController = navigationController
            navigationController.tabBarItem.title = "Download"
            navigationController.setViewControllers([viewController], animated: true)
        
        case .list:
            let coordinator = ListCoordinator()
            let model = ListModel()
            let viewModel = ListViewModel(model: model, coordinator: coordinator)
            let viewController = ListViewController(viewModel: viewModel)
            viewController.tabBarItem = UITabBarItem(title: "List", image: UIImage(systemName: "list.bullet"), tag: 0)
            coordinator.navigationController = navigationController
            navigationController.tabBarItem.title = "List"
            navigationController.setViewControllers([viewController], animated: true)
            
        case .category:
            let coordinator = CategoryCoordinator()
            let model = CategoryModel()
            let viewModel = CategoryViewModel(model: model, coordinator: coordinator)
            let viewController = CategoryViewController(viewModel: viewModel)
            viewController.tabBarItem = UITabBarItem(title: "Category", image: UIImage(systemName: "list.bullet.indent"), tag: 0)
            coordinator.navigationController = navigationController
            navigationController.tabBarItem.title = "Category"
            navigationController.setViewControllers([viewController], animated: true)
        }
    }
}
