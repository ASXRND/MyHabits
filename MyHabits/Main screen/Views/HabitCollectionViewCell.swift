//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Александр on 03.03.2023.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {

    weak var thisDelegate: HabitDelegate?

    private var data: HabitModel = HabitModel()
    {
        didSet {
            nameLabel.text = data.name
            nameLabel.textColor = data.color
            if let habit = data.getHabit() {
                dateLabel.text = habit.dateString

                updateCheckButton(habit: habit)
                updateDescriptionLabel(habit: habit)
            }
        }
    }

    //MARK: - Add NameLabel
    private lazy var nameLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    //MARK: - Add DateLabel
    private lazy var dateLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = colorStyle(style: .lightGray)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    //MARK: - Add DescriptionLabel
    private lazy var myDescriptionLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = colorStyle(style: .lightGray)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    //MARK: - Add CheckButton
    private lazy var checkButton: UIButton = {
        var button = UIButton(frame: .zero)
        button.tintColor = .systemBackground
        button.layer.cornerRadius = 18
        button.layer.borderWidth = 3
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(actionCheckHabit), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setuplayoutUpdate()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - ActionCheckHabit
    @objc private func actionCheckHabit() {
        if let habit = data.getHabit(), habit.isAlreadyTakenToday == false {
            HabitsStore.shared.track(habit)
            thisDelegate?.updateData()
        }
    }

    //MARK: - UpdateCheckButton
    private func updateCheckButton(habit: Habit) {
        if (habit.isAlreadyTakenToday != false) {
            checkButton.backgroundColor = habit.color
            checkButton.layer.borderColor = habit.color.cgColor
            checkButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
        } else {
            checkButton.backgroundColor = nil
            checkButton.layer.borderColor = habit.color.cgColor
            checkButton.setImage(nil, for: .normal)
        }
    }

    //MARK: - UpdateDescriptionLabel
    private func updateDescriptionLabel(habit: Habit) {
        myDescriptionLabel.text = "Подряд: \(habit.trackDates.count)"
    }
}

//MARK: - CellProtocol
extension HabitCollectionViewCell: CellProtocol {
    typealias CellType = HabitModel

    static var reuseId: String { String(describing: self) }

    func setuplayoutUpdate() {
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true

        contentView.addSubview(nameLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(myDescriptionLabel)
        contentView.addSubview(checkButton)

        NSLayoutConstraint.activate([

            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7),

            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            dateLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),

            myDescriptionLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            myDescriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),

            checkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -26),
            checkButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkButton.widthAnchor.constraint(equalToConstant: 36),
            checkButton.heightAnchor.constraint(equalToConstant: 36)
        ])
    }

    //MARK: - UpdateCell
    func updateCell(object: HabitModel) {
        self.data = object
    }
}
