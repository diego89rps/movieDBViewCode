//
//  MainAppViewModelTests.swift
//  MovieDBViewCodeTests
//
//  Created by Diego Ribeiro on 30/03/24.
//

@testable import MovieDBViewCode
import XCTest

class MainAppViewModelTests: XCTestCase {
    
    var viewModel: MainAppViewModel!
    var mockViewDelegate: MockMainAppViewModelViewDelegate!
    var mockCoordinatorDelegate: MockMainAppViewModelCoordinatorDelegate!
    
    override func setUp() {
        super.setUp()
        viewModel = MainAppViewModel()
        mockViewDelegate = MockMainAppViewModelViewDelegate()
        mockCoordinatorDelegate = MockMainAppViewModelCoordinatorDelegate()
        viewModel.viewDelegate = mockViewDelegate
        viewModel.coordinatordDlegate = mockCoordinatorDelegate
    }
    
    override func tearDown() {
        viewModel = nil
        mockViewDelegate = nil
        mockCoordinatorDelegate = nil
        super.tearDown()
    }
    
    func testSetupView() {
        viewModel.setupView()
        XCTAssertTrue(mockViewDelegate.createSimpleViewCalled)
        XCTAssertTrue(mockViewDelegate.createCompleteViewCalled)
    }
    
    func testGoToNextView() {
        viewModel.goToNextView()
        XCTAssertTrue(mockCoordinatorDelegate.goToNextViewCalled)
    }
}

class MockMainAppViewModelViewDelegate: MainAppViewModelViewDelegate {
    var createSimpleViewCalled = false
    var createCompleteViewCalled = false
    
    func createSimpleView() {
        createSimpleViewCalled = true
    }
    
    func createCompleteView() {
        createCompleteViewCalled = true
    }
    
    func loadingView(isLoading: Bool) {
        // opcional para teste
    }
}

class MockMainAppViewModelCoordinatorDelegate: MainAppViewModelCoordinatorDelegate {
    var goToNextViewCalled = false
    
    func goToNextView() {
        goToNextViewCalled = true
    }
}
