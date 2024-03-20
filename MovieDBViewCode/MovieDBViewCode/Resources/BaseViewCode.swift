//
//  BaseViewCode.swift
//  MovieDBViewCode
//
//  Created by Diego Ribeiro on 19/03/24.
//

public protocol BaseViewCode {
    func setupView()
    func setupSubviews()
    func setupConstraints()
}

extension BaseViewCode {
    func setupView() {
        setupSubviews()
        setupConstraints()
    }
}
