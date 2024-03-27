//
//  MainAppView.swift
//  MovieDBViewCode
//
//  Created by Diego Ribeiro on 19/03/24.
//

import UIKit

class MainAppView: BaseView, BaseViewCode {
    
    // MARK: Properties
    
    lazy var image: UIImageView = {
        let stackView = UIImageView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        stackView.contentMode = .scaleToFill
        return stackView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.contentMode = .scaleToFill
        return stackView
    }()
    
    lazy var simpleCard: GenericCardView = GenericCardView()
    
    lazy var completedCard: GenericCardView = GenericCardView()
    

    // MARK: Initializers
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: Methods
    
    func setupSubviews() {
        stackView.addArrangedSubview(simpleCard)
        stackView.addArrangedSubview(completedCard)
        container.addSubview(stackView)
        container.addSubview(image)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(greaterThanOrEqualTo: container.topAnchor),
            image.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            
            stackView.topAnchor.constraint(greaterThanOrEqualTo: container.topAnchor, constant: 300),
            stackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(greaterThanOrEqualTo: container.bottomAnchor),
        ])
    }
}
