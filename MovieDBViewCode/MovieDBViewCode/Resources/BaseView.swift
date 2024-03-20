//
//  BaseView.swift
//  MovieDBViewCode
//
//  Created by Diego Ribeiro on 19/03/24.
//
import UIKit
class BaseView: UIScrollView {
    
    var container: UIView = {
        return UIView()
    }()
    
    // MARK: Initializers
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
