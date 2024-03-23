//
//  BaseViewController.swift
//  MovieDBViewCode
//
//  Created by Diego Ribeiro on 19/03/24.
//

import UIKit

open class BaseViewController: UIViewController {
    
    var activityIndicator: UIActivityIndicatorView
    
    init() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.backgroundColor = .white
        activityIndicator.hidesWhenStopped = true
        super.init(nibName: nil, bundle: nil)
        activityIndicator.center = view.center
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = .white
        setupNavBar()
    }
    
    private func setupNavBar() {
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .black
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = .red
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    func callAlert(title: String, description: String, 
                   primaryAction: UIAlertAction, secondaryAction: UIAlertAction?) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        
        alert.addAction(primaryAction)
        
        if let action = secondaryAction {
            alert.addAction(action)
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func loading(isLoading: Bool) {
        if isLoading {
            activityIndicator.startAnimating()
            view.isUserInteractionEnabled = false
        } else {
            activityIndicator.stopAnimating()
            view.isUserInteractionEnabled = true
        }
    }
}
