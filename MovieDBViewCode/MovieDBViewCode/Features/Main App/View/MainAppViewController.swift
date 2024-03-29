//
//  MainAppViewController.swift
//  MovieDBViewCode
//
//  Created by Diego Ribeiro on 19/03/24.
//

import UIKit

class MainAppViewController: BaseViewController {
    
    // MARK: Properties
    
    lazy var customView: MainAppView = {
        let mainView = MainAppView()
        mainView.translatesAutoresizingMaskIntoConstraints = false
        return mainView
    }()
    
    let viewModel: MainAppViewModel
    
    // MARK: Initializers
    
    init(viewModel: MainAppViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(customView)
        customView.insertIntoSuperView(superView: self.view)
        setupNavBar()
        viewModel.viewDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.setupView()
    }
    
    // MARK: Methods
    
    func setupNavBar() {
        let leftButton = UIBarButtonItem(title: viewModel.leftButtonText, style: .plain, target: self, action: #selector(leftButtonAction))
        let rightButton = UIBarButtonItem(title: viewModel.rightButtonText, style: .plain, target: self, action: #selector(rightButtonAction))
        createNavBar(title: viewModel.screenTitleText, leftButton: leftButton, rightButton: rightButton)
    }
    
    //MARK: - Events
    
    @objc func leftButtonAction() {
        loadingView(isLoading: true)
    }
    
    @objc func rightButtonAction() {
        loadingView(isLoading: false)
    }
}

extension MainAppViewController: MainAppViewModelViewDelegate {
    func createSimpleView() {
        customView.simpleCard.titleLabel.text = viewModel.simpleTitleText
        customView.simpleCard.subTitleLabel.text = viewModel.simpleSubTitleText
        customView.simpleCard.genericClicked = { [weak self] in
            guard let self = self else { return }
            self.viewModel.goToNextView()
        }
    }
    
    func createCompleteView() {
        customView.completedCard.titleLabel.text = viewModel.completedTitleText
        customView.completedCard.subTitleLabel.text = viewModel.completedSubTitleText
        customView.completedCard.genericClicked = { [weak self] in
            guard let self = self else { return }
            self.callAlert(title: viewModel.alertTitleText, 
                           description: viewModel.alertDescriptionText,
                           primaryAction: UIAlertAction(title: viewModel.alertBtnTitleText, 
                                                        style: .default, handler: nil),
                           secondaryAction: nil)
        }
    }
    
    func loadingView(isLoading: Bool) {
        loading(isLoading: isLoading)
    }
}
