//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Александр on 03.03.2023.
//

import UIKit

final class InfoViewController: UIViewController {

    //MARK: - Add infoView
    private lazy var infoView: InfoView =  {
        var view = InfoView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
    }

    //MARK: - Setup NavigationItem
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        title = InfoViewControllerTitle
        tabBarController?.navigationItem.rightBarButtonItem = nil
    }

    //MARK: - SetupLayout
    private func setupLayout() {
        view.addSubview(infoView)

        NSLayoutConstraint.activate([
            infoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            infoView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            infoView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            infoView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
