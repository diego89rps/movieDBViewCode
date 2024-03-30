//
//  MovieDetailsViewModelTests.swift
//  MovieDBViewCodeTests
//
//  Created by Diego Ribeiro on 30/03/24.
//

import XCTest
@testable import MovieDBViewCode

class MovieDetailsViewModelTests: XCTestCase {
    
    var viewModel: MovieDetailsViewModel!
    var mockCoordinatorDelegate: MockMovieDetailsCoordinatorDelegate!
    var mockViewDelegate: MockMovieDetailsViewDelegate!
    
    override func setUp() {
        super.setUp()
        viewModel = MovieDetailsViewModel(movieId: 1011985)
        mockCoordinatorDelegate = MockMovieDetailsCoordinatorDelegate()
        mockViewDelegate = MockMovieDetailsViewDelegate()
        viewModel.coordinatorDelegate = mockCoordinatorDelegate
        viewModel.viewDelegate = mockViewDelegate
    }
    
    override func tearDown() {
        viewModel = nil
        mockCoordinatorDelegate = nil
        mockViewDelegate = nil
        super.tearDown()
    }
    
    func testFeatchMovieDetails() {
        let expectation = expectation(description: "Fetching movie details")

        viewModel.featchMovieDetails()

        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            XCTAssertTrue(self.mockViewDelegate.loadingViewCalled)
            XCTAssertTrue(self.mockViewDelegate.setupViewCalled)
            XCTAssertFalse(self.mockViewDelegate.loadingViewIsLoading)
            XCTAssertEqual(self.viewModel.movieTitleText, "Kung Fu Panda 4")
            XCTAssertEqual(self.viewModel.movieOverviewText, "Po is gearing up to become the spiritual leader of his Valley of Peace, but also needs someone to take his place as Dragon Warrior. As such, he will train a new kung fu practitioner for the spot and will encounter a villain called the Chameleon who conjures villains from the past.")
            XCTAssertEqual(self.viewModel.voteAverage, 6.928)
            XCTAssertEqual(self.viewModel.homepage, "https://www.dreamworks.com/movies/kung-fu-panda-4")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testDownloadImage() async {
        let posterURL = "https://image.tmdb.org/t/p/w500/1XDDXPXGiI8id7MrUxK36ke7gkX.jpg"

        do {
            let imageData = await viewModel.downloadImage(posterURL: posterURL)
            XCTAssertNotNil(imageData)
        }
    }
    
    func testGoBack() {
        viewModel.goBack()
        
        XCTAssertTrue(mockCoordinatorDelegate.goBackCalled)
    }
}

class MockMovieDetailsCoordinatorDelegate: MovieDetailsCoordinatorDelegate {
    var goBackCalled = false
    
    func goBack() {
        goBackCalled = true
    }
}

class MockMovieDetailsViewDelegate: MovieDetailslViewDelegate {
    var loadingViewCalled = false
    var loadingViewIsLoading = false
    var setupViewCalled = false
    
    func loadingView(isLoading: Bool) {
        loadingViewCalled = true
        loadingViewIsLoading = isLoading
    }
    
    func setupView(data: Data) {
        setupViewCalled = true
    }
}
