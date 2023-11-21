
//
//  Created by Kr Qqq on 11.10.2023.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    private let downloadFactory = FactoryTab(flow: .download)
    private let listFactory = FactoryTab(flow: .list)
    private let categoryFactory = FactoryTab(flow: .category)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setControllers()
    }
    
    private func setControllers() {
        viewControllers = [
            downloadFactory.navigationController,
            listFactory.navigationController,
            categoryFactory.navigationController
        ]
        
        selectedIndex = 0
        tabBar.backgroundColor = .white
    }
}
