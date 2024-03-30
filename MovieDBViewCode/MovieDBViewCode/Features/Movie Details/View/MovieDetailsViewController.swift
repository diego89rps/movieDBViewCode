//
//  MovieDetailsViewController.swift
//  MovieDBViewCode
//
//  Created by Diego Ribeiro on 28/03/24.
//

import UIKit

class MovieDetailsViewController: BaseViewController {
    
    // MARK: Properties
    
    lazy var customView: MovieDetailsView = {
        let mainView = MovieDetailsView()
        mainView.translatesAutoresizingMaskIntoConstraints = false
        return mainView
    }()
    
    let viewModel: MovieDetailsViewModel
    
    // MARK: Initializers
    
    init(viewModel: MovieDetailsViewModel) {
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
        viewModel.featchMovieDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: Methods
    
    func setupNavBar() {
        let leftButton = UIBarButtonItem(title: viewModel.leftButtonText, style: .plain, target: self, action: #selector(leftButtonAction))
        createNavBar(title: viewModel.screenTitleText, leftButton: leftButton, rightButton: nil)
    }
    
    //MARK: - Events
    
    @objc func leftButtonAction() {
        viewModel.goBack()
    }
}

extension MovieDetailsViewController: MovieDetailslViewDelegate {
    func setupView(data: Data) {
        let image = UIImage(data: data)
        customView.thumbnailImageView.image = image
        customView.titleLabel.text = viewModel.movieTitleText
        customView.releaseDataLabel.text = "release data: " + viewModel.releaseData
        customView.descriptionLabel.text = viewModel.movieOverviewText
        customView.voteLabel.text = "Score: \(viewModel.voteAverage)."
        customView.homepageBtn.isHidden = false
        customView.buttonAction = { [weak self] in
            guard let self = self else { return }
            openURL(url: viewModel.homepage)
        }
    }
    
    func loadingView(isLoading: Bool) {
        loading(isLoading: isLoading)
    }
}
