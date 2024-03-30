//
//  MovieDetailsView.swift
//  MovieDBViewCode
//
//  Created by Diego Ribeiro on 28/03/24.
//

import UIKit

class MovieDetailsView: BaseView, BaseViewCode {
    
    // MARK: Properties
    
    var buttonAction: (() -> Void)?
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.contentMode = .scaleAspectFill
        return stackView
    }()
    
    lazy var imageSection = createSimpleView()
    
    lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 230).isActive = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var contentSection = createSimpleView()
    
    lazy var titleLabel: UILabel = createLabel(size: 16, color: .black)
    
    lazy var releaseDataLabel: UILabel = createLabel(size: 10, color: .lightGray)
    
    lazy var descriptionLabel: UILabel = createLabel(size: 12, color: .darkGray)
    
    lazy var voteLabel: UILabel = createLabel(size: 12, color: .lightGray)
    
    lazy var homepageBtn: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
        button.setTitle("Where to watch", for: .normal)
        button.isHidden = true
        return button
    }()

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
        imageSection.heightAnchor.constraint(equalToConstant: 230).isActive = true
        imageSection.addSubview(thumbnailImageView)
        
        contentSection.addSubview(titleLabel)
        contentSection.addSubview(releaseDataLabel)
        contentSection.addSubview(descriptionLabel)
        contentSection.addSubview(voteLabel)

        stackView.addArrangedSubview(imageSection)
        stackView.addArrangedSubview(contentSection)
        stackView.addArrangedSubview(homepageBtn)
        container.addSubview(stackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: container.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
        
        setupImageSectionConstraints()
        setupContentSectionConstraints()
    }
    
    func setupImageSectionConstraints() {
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(greaterThanOrEqualTo: imageSection.topAnchor),
            thumbnailImageView.leadingAnchor.constraint(equalTo: imageSection.leadingAnchor),
            thumbnailImageView.trailingAnchor.constraint(equalTo: imageSection.trailingAnchor),
            thumbnailImageView.bottomAnchor.constraint(greaterThanOrEqualTo: imageSection.bottomAnchor)
        ])
    }
    
    func setupContentSectionConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentSection.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentSection.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentSection.trailingAnchor, constant: -16),
            
            releaseDataLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            releaseDataLabel.leadingAnchor.constraint(equalTo: contentSection.leadingAnchor, constant: 16),
            releaseDataLabel.trailingAnchor.constraint(equalTo: contentSection.trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: releaseDataLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentSection.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentSection.trailingAnchor, constant: -16),
            
            voteLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 4),
            voteLabel.leadingAnchor.constraint(equalTo: contentSection.leadingAnchor, constant: 16),
            voteLabel.trailingAnchor.constraint(equalTo: contentSection.trailingAnchor, constant: -16),
            
            voteLabel.bottomAnchor.constraint(equalTo: contentSection.bottomAnchor)
        ])
    }
    
    @objc func buttonTapped() {
        buttonAction?()
    }
}
