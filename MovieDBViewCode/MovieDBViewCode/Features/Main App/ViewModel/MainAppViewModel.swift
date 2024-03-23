//
//  MainAppViewModel.swift
//  MovieDBViewCode
//
//  Created by Diego Ribeiro on 23/03/24.
//

import Foundation

protocol MainAppViewModelCoordinatorDelegate: AnyObject {
    func goToNextView()
}

protocol MainAppViewModelViewDelegate: AnyObject {
    func createSimpleView()
    func createCompleteView()
}

class MainAppViewModel {
    
    weak var viewDelegate: MainAppViewModelViewDelegate?
    weak var CoordinatordDlegate: MainAppViewModelCoordinatorDelegate?
    
    var simpleTitleText: String {
        return "Implementacao Simples"
    }
    
    var simpleSubTitleText: String {
        return "Implementado apenas a lista de filmes e seus detalhes"
    }
    
    var completedTitleText: String {
        return "Implementacao Completa"
    }
    
    var completedSubTitleText: String {
        return "Implementado material completo da API MOVIE DB"
    }
    
    var alertTitleText: String {
        return "INDISPONIVEL"
    }
    
    var alertDescriptionText: String {
        return "Aplicacao em desenvolvimento."
    }
    
    var alertBtnTitleText: String {
        return "OK"
    }
    
    init() {
        
    }
    
    func setupView() {
        viewDelegate?.createSimpleView()
        viewDelegate?.createCompleteView()
    }
    
    func goToNextView() {
        
    }
}
