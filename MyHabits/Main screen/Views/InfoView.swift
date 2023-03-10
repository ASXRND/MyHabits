//
//  InfoView.swift
//  MyHabits
//
//  Created by Александр on 03.03.2023.
//

import UIKit

final class InfoView: UIView {

    private let data: InfoModel = InfoModel(title: infoTitle, description: infoDescription)

    //MARK: - Add ScrollView
    private lazy var scrollView: UIScrollView = {
        var view = UIScrollView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    //MARK: - Add ContentView
    private lazy var contentView: UIView = {
        var view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    //MARK: - Add TitleLabel
    private lazy var titleLabel: UILabel = {
        var title = UILabel(frame: .zero)
        title.text = data.title
        title.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()

    //MARK: - Add TextView
    private lazy var textView: UITextView = {
        var view = UITextView(frame: .zero)
        view.isScrollEnabled = false
        view.isEditable = false
        view.text = data.description
        view.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - SetupLayout
    private func setupLayout() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(textView)

        let contentViewWidth = contentView.widthAnchor.constraint(equalTo: widthAnchor)
        contentViewWidth.priority = .required
        let contentViewHeight = contentView.heightAnchor.constraint(equalTo: heightAnchor)
        contentViewHeight.priority = .defaultLow

        NSLayoutConstraint.activate([
            contentViewWidth, contentViewHeight,

            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            textView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}
