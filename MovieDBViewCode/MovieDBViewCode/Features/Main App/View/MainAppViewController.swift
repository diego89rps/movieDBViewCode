//
//  MainAppViewController.swift
//  MovieDBViewCode
//
//  Created by Diego Ribeiro on 19/03/24.
//

import UIKit

class MainAppViewController: BaseViewController {
    typealias CustomView = MainAppView
    
    let customView = CustomView()
    let viewModel: MainAppViewModel
    
    init(viewModel: MainAppViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = customView
        title = "TITULO"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDelegate = self
        viewModel.setupView()
    }
}

extension MainAppViewController: MainAppViewModelViewDelegate {
    func createSimpleView() {
        customView.simpleCard.titleLabel.text = viewModel.simpleTitleText
        customView.simpleCard.subTitleLabel.text = viewModel.simpleSubTitleText
        customView.simpleCard.genericClicked = { [weak self] in
            guard let self = self else { return }
//            self.viewModel.goToNextView()
            exemploUso()
        }
    }
    
    func createCompleteView() {
        customView.completedCard.titleLabel.text = viewModel.completedTitleText
        customView.completedCard.subTitleLabel.text = viewModel.completedSubTitleText
        customView.completedCard.genericClicked = { [weak self] in
            guard let self = self else { return }
            self.callAlert(title: viewModel.alertTitleText, description: viewModel.alertDescriptionText, primaryAction: UIAlertAction(title: viewModel.alertBtnTitleText, style: .default, handler: nil),
                           secondaryAction: nil)
        }
    }
    
    func exemploUso() {
        view = activityIndicator
        loading(isLoading: true)
        
        // Simular uma operação de carregamento assíncrona
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.view = self.customView
            self.loading(isLoading: false)
        }
    }
}
