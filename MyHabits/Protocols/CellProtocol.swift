//
//  CellProtocol.swift
//  MyHabits
//
//  Created by Александр on 03.03.2023.
//

protocol CellProtocol {

    associatedtype CellType

    static var reuseId: String { get }

    func setuplayoutUpdate()
    func updateCell(object: CellType)
}
