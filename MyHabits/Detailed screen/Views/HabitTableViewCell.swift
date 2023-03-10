//
//  HabitTableViewCell.swift
//  MyHabits
//
//  Created by Александр on 03.03.2023.
//

import UIKit

final class HabitTableViewCell: UITableViewCell {


    //MARK: - Add DateLabel
    private lazy var dateLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    //MARK: - Add CheckImage
    private lazy var checkImage: UIImageView = {
        var image = UIImageView()
        image.tintColor = colorStyle(style: .magenta)
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setuplayoutUpdate()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - SetuplayoutUpdate
    func setuplayoutUpdate() {

        contentView.addSubview(dateLabel)
        contentView.addSubview(checkImage)

        let checkImageWidth = checkImage.widthAnchor.constraint(lessThanOrEqualToConstant: 20)
        checkImageWidth.priority = .defaultLow
        let checkImageHeight = checkImage.heightAnchor.constraint(lessThanOrEqualToConstant: 20)
        checkImageHeight.priority = .defaultLow

        NSLayoutConstraint.activate([
            checkImageHeight, checkImageWidth,

            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            dateLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7),

            checkImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            checkImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            checkImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}

//MARK: - Extension CellProtocol
extension HabitTableViewCell: CellProtocol {
    typealias CellType = CellModel

    static var reuseId: String { String(describing: self) }

    func updateCell(object: CellModel) {
        var dateStr: String?
        if (Calendar.current.isDateInToday(object.date)) { dateStr = "Сегодня" }
        else if (Calendar.current.isDateInYesterday(object.date)) { dateStr = "Вчера" }
        else {
            let currentDateComponents = Calendar.current.dateComponents([.day, .month, .year], from: Date())
            let inDateComponents = Calendar.current.dateComponents([.day, .month, .year], from: object.date)

            if (currentDateComponents.year == inDateComponents.year &&
                currentDateComponents.month == inDateComponents.month &&
                (currentDateComponents.day ?? 0) - (inDateComponents.day ?? 0) == 2) { dateStr = "Позавчера" }
            else {
                if let indexDate = HabitsStore.shared.dates.lastIndex(of: object.date) {
                    dateStr = HabitsStore.shared.trackDateString(forIndex: indexDate)
                }
            }
        }

        dateLabel.text = dateStr
        if (object.isCheck) {
            checkImage.image = UIImage(systemName: "checkmark")
        }
    }
}
