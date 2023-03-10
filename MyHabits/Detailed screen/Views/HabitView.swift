//
//  HabitView.swift
//  MyHabits
//
//  Created by Александр on 03.03.2023.
//

import UIKit

class HabitView: UIView {

    weak var thisDelegate: HabitDelegate?

    var data: HabitModel = HabitModel()
    {
        didSet {
            nameText.text = data.name
            colorButton.backgroundColor = data.color
            datePicker.date = data.date

            updateDateDescription()

            if (data.isNew) {
                nameText.becomeFirstResponder()
                delButton.removeFromSuperview()
            }
        }
    }

    //MARK: - Add NameLabel
    private lazy var nameLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.text = habitNameTitle
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    //MARK: - Add NameText
    private lazy var nameText: UITextField = {
        var text = UITextField(frame: .zero)
        text.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        text.placeholder = habitNamePlaceholder
        text.addTarget(self, action: #selector(updateName(_:)), for: .editingChanged)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()

    //MARK: - Add ColorLabel
    private lazy var colorLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.text = habitColorTitle
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    //MARK: - Add ColorButton
    private lazy var colorButton: UIButton = {
        var button = UIButton(frame: .zero)
        button.addTarget(self, action: #selector(updateColor), for: .touchUpInside)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    //MARK: - Add DateLabel
    private lazy var dateLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.text = habitDateTitle
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    //MARK: - Add DateDescriptionLabel
    private lazy var dateDescriptionLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    //MARK: - Add DatePicker
    private lazy var datePicker: UIDatePicker = {
        var picker = UIDatePicker(frame: .zero)
        picker.preferredDatePickerStyle = .wheels
        picker.datePickerMode = .time
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.addTarget(self, action: #selector(updateDate(_:)), for: .valueChanged)
        return picker
    }()

    //MARK: - Add DelButton
    private lazy var delButton: UIButton = {
        var button = UIButton(frame: .zero)
        button.setTitle("Удалить привычку", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        button.setTitleColor(.red, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(actionDelit), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupLayout()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - SetupLayout
    private func setupLayout() {

        addSubview(nameLabel)
        addSubview(nameText)
        addSubview(colorLabel)
        addSubview(colorButton)
        addSubview(dateLabel)
        addSubview(dateDescriptionLabel)
        addSubview(datePicker)
        addSubview(delButton)

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 22),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            nameText.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 7),
            nameText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            colorLabel.topAnchor.constraint(equalTo: nameText.bottomAnchor, constant: 15),
            colorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            colorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            colorButton.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 7),
            colorButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            colorButton.widthAnchor.constraint(equalToConstant: 30),
            colorButton.heightAnchor.constraint(equalToConstant: 30),

            dateLabel.topAnchor.constraint(equalTo: colorButton.bottomAnchor, constant: 15),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            dateDescriptionLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 7),
            dateDescriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dateDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            datePicker.topAnchor.constraint(equalTo: dateDescriptionLabel.bottomAnchor, constant: 15),
            datePicker.leadingAnchor.constraint(equalTo: leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: trailingAnchor),

            delButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            delButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }

    //MARK: - UpdateName
    @objc private func updateName(_ textField: UITextField) {
        data.name = textField.text ?? ""
    }

    //MARK: - UpdateColor
    @objc private func updateColor() {
        let picker = UIColorPickerViewController()
        picker.selectedColor = data.color
        picker.delegate = self

        thisDelegate?.presentController(picker, animated: true, completion: nil)
    }

    //MARK: - UpdateDate
    @objc private func updateDate(_ datePicker: UIDatePicker) {
        if data.date != datePicker.date {
            data.date = datePicker.date
            updateDateDescription()
        }
    }

    //MARK: - ActionDelit Deleting a habit
    @objc private func actionDelit() {
        weak var weakSelf = self
        let alert = UIAlertController(title: "Удалить привычку", message: "Вы хотите удалить привычку \"\(String(describing: data.name))\"?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: { (action) in
            if let index = weakSelf?.data.id { HabitsStore.shared.habits.remove(at: index) }
            weakSelf?.thisDelegate?.dismissController(animated: true, completion: nil)
        }))

        thisDelegate?.presentController(alert, animated: true, completion: nil)
    }

    //MARK: - UpdateDateDescription
    private func updateDateDescription(){
        let baseStr = NSMutableAttributedString(string: habitDateDescriptionPattern, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .regular)])
        let formatter = DateFormatter()
        formatter.timeStyle = .short

        let dateStr = NSAttributedString(string: formatter.string(from: data.date), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .regular), NSAttributedString.Key.foregroundColor: colorStyle(style: .blue)])
        baseStr.append(dateStr)
        dateDescriptionLabel.attributedText = baseStr
    }
}

//MARK: - Extension UIColorPickerViewControllerDelegate
extension HabitView: UIColorPickerViewControllerDelegate {

    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        if data.color != viewController.selectedColor {
            data.color = viewController.selectedColor
            colorButton.backgroundColor = data.color
        }
    }
}
