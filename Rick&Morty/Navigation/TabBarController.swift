//
//  TabBarController.swift
//  Rick&Morty
//
//  Created by Nikita on 27.03.2024.
//

import UIKit

class TabBarController: UITabBarController {
    
    
    //MARK: - Initialize
    
    init(tabBar: UITabBar) {
        super.init(nibName: nil, bundle: nil)
        self.setValue(tabBar, forKey: "tabBar")
        selectedIndex = 0
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
    
    func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        self.tabBar.standardAppearance = appearance
        appearance.backgroundColor = .backBlue
        self.tabBar.standardAppearance = appearance
    }
    
    //MARK: - Private method
    
    private func setupViewControllersForTabBarItem(viewController: UIViewController, tabBarItems: TabBarItems) -> UINavigationController {
        let view = UINavigationController(rootViewController: viewController)
        view.navigationBar.prefersLargeTitles = true
        view.tabBarItem = UITabBarItem(title: tabBarItems.title, image: tabBarItems.image, selectedImage: tabBarItems.selectedImage)
        view.tabBarController?.tabBar.tintColor = .white
        view.tabBarController?.tabBar.unselectedItemTintColor = .lightGray
        
        return view
    }
}
