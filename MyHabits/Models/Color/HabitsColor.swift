//
//  HabitsColor.swift
//  MyHabits
//
//  Created by Александр on 03.03.2023.
//

import UIKit

enum HabitsColor {
    case gray
    case lightGray
    case white
    case magenta
    case blue
    case green
    case darkBlue
    case orange
}

func colorStyle(style: HabitsColor) -> UIColor {
    switch style {
        case .gray:
            return UIColor.systemGray
        case .lightGray:
            return UIColor.systemGray2
        case .white:
            return getColor(red: 242, green: 242, blue: 247)
        case .magenta:
            return getColor(red: 161, green: 22, blue: 204)
        case .blue:
            return getColor(red: 41, green: 109, blue: 255)
        case .green:
            return getColor(red: 29, green: 179, blue: 34)
        case .darkBlue:
            return getColor(red: 98, green: 54, blue: 255)
        case .orange:
            return getColor(red: 255, green: 159, blue: 79)
    }
}

private func getColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) -> UIColor {
    let colorMax: CGFloat = 255
    return UIColor.init(red: red/colorMax, green: green/colorMax, blue: blue/colorMax, alpha: alpha)
}
