//
//  GenericCardView.swift
//  MovieDBViewCode
//
//  Created by Diego Ribeiro on 23/03/24.
//

import UIKit

class GenericCardView: UIView, BaseViewCode {
    // MARK: Properties
    
    var genericClicked: (() -> Void)?

    lazy var titleLabel: UILabel = createLabel(size: 14, color: .black)
    lazy var subTitleLabel: UILabel = createLabel(size: 11, color: .gray)
    
    // MARK: Initializers
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderWidth = 2
        layer.borderColor = UIColor.darkGray.cgColor
        layer.cornerRadius = 3
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(genericTapped)))
        isUserInteractionEnabled = true
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: Methods
    
    func setupSubviews() {
        addSubview(titleLabel)
        addSubview(subTitleLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            subTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            subTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            subTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24)
        ])
    }
    
    @objc func genericTapped() {
        if let callback = self.genericClicked {
            callback()
        }
    }
}
