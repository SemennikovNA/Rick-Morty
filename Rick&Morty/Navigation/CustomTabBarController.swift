//
//  CustomTabBarController.swift
//  Rick&Morty
//
//  Created by Nikita on 27.03.2024.
//

import UIKit

class CustomTabBarController: UITabBarController {
    

    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(tabBar: UITabBar) {
        super.init(nibName: nil, bundle: nil)
        self.setValue(tabBar, forKey: "tabBar")
        self.selectedIndex = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    func setupViewControllers() {
        self.viewControllers = [
            setupViewControllersForTabBarItem(viewController: Builder.createMainView(), tabBarItems: TabBarItems.characters),
            setupViewControllersForTabBarItem(viewController: Builder.createSearchView(), tabBarItems: TabBarItems.search)
        ]
    }
    
    //MARK: - Private method
    
    private func setupViewControllersForTabBarItem(viewController: UIViewController, tabBarItems: TabBarItems) -> UINavigationController {
        let view = UINavigationController(rootViewController: viewController)
        view.navigationBar.prefersLargeTitles = true
        view.tabBarItem = UITabBarItem(title: tabBarItems.title, image: tabBarItems.image, selectedImage: tabBarItems.selectedImage)
        return view
    }
}
