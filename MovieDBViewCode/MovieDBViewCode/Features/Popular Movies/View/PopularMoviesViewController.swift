//
//  PopularMoviesViewController.swift
//  MovieDBViewCode
//
//  Created by Diego Ribeiro on 28/03/24.
//

import UIKit

class PopularMoviesViewController: BaseViewController {
    
    // MARK: Properties
    
    lazy var customView: PopularMoviesView = {
        let mainView = PopularMoviesView()
        mainView.translatesAutoresizingMaskIntoConstraints = false
        return mainView
    }()
    
    let viewModel: PopularMoviesViewModel
    
    // MARK: Initializers
    
    init(viewModel: PopularMoviesViewModel) {
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

        customView.tableView.dataSource = self
        customView.tableView.delegate = self
        customView.tableView.register(PopularMovieCell.self, forCellReuseIdentifier: "CustomCell")
        
        setupNavBar()
        viewModel.viewDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.featchPopularMovies()
    }
    
    // MARK: Methods
    
    func setupNavBar() {
        let leftButton = UIBarButtonItem(title: viewModel.leftButtonText, 
                                         style: .plain, target: self,
                                         action: #selector(leftButtonAction))
        let rightButton = UIBarButtonItem(title: viewModel.rightButtonText, 
                                          style: .plain, target: self,
                                          action: #selector(rightButtonAction))
        createNavBar(title: viewModel.screenTitleText, 
                     leftButton: leftButton, rightButton: rightButton)
    }
    
    //MARK: - Events
    
    @objc func leftButtonAction() {
        viewModel.goBack()
    }
    
    @objc func rightButtonAction() {
        
    }
}

extension PopularMoviesViewController: PopularMoviesViewModelViewDelegate {
    func reloadTableView() {
        self.customView.tableView.reloadData()
    }
    
    func createCompleteView() {

    }
    
    func loadingView(isLoading: Bool) {
        loading(isLoading: isLoading)
    }
    
    func setupImage(data: Data) {

    }
}
extension PopularMoviesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfMovies
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! PopularMovieCell
        
        cell.titleLabel.text = viewModel.movieTitle(at: indexPath.row)
        cell.descriptionLabel.text = viewModel.movieOverview(at: indexPath.row)
        
        if let posterPath = viewModel.moviePosterPath(at: indexPath.row) {
            Task {
                do {
                    let imageData = await viewModel.downloadImage(posterURL: posterPath)
                    if let imageData = imageData, let image = UIImage(data: imageData) {
                        DispatchQueue.main.async  {
                            cell.imageView?.image = image.resize(toSize: CGSize(width: 142, height: 219))
                            cell.setNeedsLayout()
                        }
                    }
                }
            }
        }
                
        return cell
    }
    
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       viewModel.goToNextView(index: indexPath.row)
    }
    
}
