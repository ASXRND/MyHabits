//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Александр on 03.03.2023.
//

import UIKit

class HabitViewController: UIViewController {

    weak var thisDelegate: HabitDelegate?

    private var isNew: Bool { get { habitView.data.isNew } }

    //MARK: - Add habitView
    private lazy var habitView: HabitView =  {
        var view = HabitView(frame: .zero)
        view.thisDelegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    convenience init(data: HabitModel) {
        self.init()
        self.habitView.data = data
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        navigationItem.title = isNew ? "Создать" : "Править"
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(actionCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(actionSave))

        setupLayout()
    }

    private func setupLayout() {
        view.addSubview(habitView)

        NSLayoutConstraint.activate([

            habitView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            habitView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            habitView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            habitView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    //MARK: - ActionSave
    @objc private func actionSave() {
        if (isNew == false) {
            if let habit = habitView.data.getHabit() {

                habit.name = habitView.data.name
                habit.date = habitView.data.date
                habit.color = habitView.data.color

                HabitsStore.shared.save()
            }
        } else {
            HabitsStore.shared.habits.append(Habit(name: habitView.data.name, date: habitView.data.date, color: habitView.data.color)) }

        thisDelegate?.updateData()
        actionCancel()
    }

    //MARK: - ActionCancel
    @objc private func actionCancel() {
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - HabitDelegate
extension HabitViewController: HabitDelegate {

    func updateData() {
        thisDelegate?.updateData()
    }

    func presentController(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
        self.present(viewControllerToPresent, animated: flag, completion: completion)
    }

    func dismissController(animated: Bool, completion: (() -> Void)?) {
        self.dismiss(animated: animated, completion: completion)
        thisDelegate?.dismissController(animated: true, completion: nil)
    }
}
