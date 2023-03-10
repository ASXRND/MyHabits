//
//  NavigationViewController.swift
//  MyHabits
//
//  Created by Александр on 03.03.2023.
//

import UIKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    convenience init() {
        self.init(rootViewController: TabBarViewController())
    }
}
