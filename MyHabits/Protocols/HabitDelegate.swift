//
//  HabitDelegate.swift
//  MyHabits
//
//  Created by Александр on 03.03.2023.
//

import UIKit

protocol HabitDelegate: AnyObject {

    func updateData()
    func presentController(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?)
    func dismissController(animated: Bool, completion: (() -> Void)?)
}
