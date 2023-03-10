//
//  CellModel.swift
//  MyHabits
//
//  Created by Александр on 03.03.2023.
//

import UIKit

struct CellModel {

    let date: Date
    let isCheck: Bool

    init(date: Date, isCheck: Bool) {
        self.date = date
        self.isCheck = isCheck
    }
}
