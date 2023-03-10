//
//  TabBarViewController.swift
//  MyHabits
//
//  Created by Александр on 03.03.2023.
//

import UIKit

final class TabBarViewController: UITabBarController {

    private var habitListViewController = HabitsViewController()
    private var infoViewController = InfoViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = colorStyle(style: .magenta)
        
        generateTabBar()
    }

    //MARK: - Creation NC
    private func generateTabBar() {
        viewControllers = [
            createNavController(vc: habitListViewController, itemName: "Привычки", itemImage: "person.2.badge.gearshape.fill"),
            createNavController(vc: infoViewController, itemName: "Информация", itemImage: "person.crop.circle.badge.exclamationmark.fill")
        ]
    }

    //MARK: - Settings NC
    private func createNavController(vc: UIViewController, itemName: String, itemImage: String) -> UINavigationController {
        let item = UITabBarItem(title: itemName, image: UIImage(systemName: itemImage)?.withAlignmentRectInsets(.init(top: 5, left: 0, bottom: 0, right: 0)), tag: 0)
        item.titlePositionAdjustment = .init(horizontal: 0, vertical: 0)

        let navController = UINavigationController(rootViewController: vc)
        navController.tabBarItem = item

        return navController
    }
}
