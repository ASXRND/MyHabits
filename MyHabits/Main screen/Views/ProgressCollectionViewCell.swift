//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Александр on 03.03.2023.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Add HeaderLabel
    private lazy var headerLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.text = progressHeader
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = colorStyle(style: .gray)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Add ProgressLabel
    private lazy var progressLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = colorStyle(style: .gray)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Add ProgressBar
    private lazy var progressBar: UIProgressView = {
        var view = UIProgressView(frame: .zero)
        view.progressTintColor = colorStyle(style: .blue)
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setuplayoutUpdate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - CellProtocol
extension ProgressCollectionViewCell: CellProtocol {
    typealias CellType = Float
    
    static var reuseId: String { String(describing: self) }
    
    func setuplayoutUpdate() {
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
        
        contentView.addSubview(headerLabel)
        contentView.addSubview(progressLabel)
        contentView.addSubview(progressBar)
        
        NSLayoutConstraint.activate([
            
            headerLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            headerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            headerLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            
            progressLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            progressLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            progressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            progressLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),
            
            progressBar.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 10),
            progressBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            progressBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            progressBar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
    }
    
    func updateCell(object: Float) {
        progressBar.progress = object
        progressLabel.text = String(format: "%.0f %%", object * 100)
    }
}
