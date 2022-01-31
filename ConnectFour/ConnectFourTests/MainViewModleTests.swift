//
//  MainViewModleTests.swift
//  ConnectFourTests
//
//  Created by Gajula Ravi Kiran on 31/01/2022.
//

import XCTest
@testable import ConnectFour

class MainViewModleTests: XCTestCase {
   
    var viewModel: MainViewModel?
    
    override func setUpWithError() throws {
        viewModel = MainViewModel()
    }

    func testCurrentPLayer() {
        viewModel?.setCurrentPlayer()
        XCTAssertTrue(viewModel?.currentPlayer == .player2)
        viewModel?.setCurrentPlayer()
        XCTAssertTrue(viewModel?.currentPlayer == .player1)
    }
    
    func testPlayerNames() throws {
        let firstPlayerName = try XCTUnwrap(viewModel?.getFirstPlayerName())
        XCTAssertEqual(firstPlayerName, "sathya")
        let secobdPlayerName = try XCTUnwrap(viewModel?.getSecondPlayerName())
        XCTAssertEqual(secobdPlayerName, "Thamana")
    }
    
    func testPlayerColors() throws {
        let firstPlayerColor = try XCTUnwrap(viewModel?.playerOneColor())
        XCTAssertEqual(firstPlayerColor, "#FF0000")
        let secondPlayerColor = try XCTUnwrap(viewModel?.playerTwoColor())
        XCTAssertEqual(secondPlayerColor, "#0000FF")
    }
    
    func testCurrentPlayerColor() throws {
        let firstPlayerColor = try XCTUnwrap(viewModel?.playerOneColor())
        let color = viewModel?.selectedPlayerColor()
        XCTAssertEqual(color, UtilityClass.hexStringToUIColor(hex: firstPlayerColor))
        
        viewModel?.setCurrentPlayer()
        let secondPlayerHexColor = try XCTUnwrap(viewModel?.playerTwoColor())
        let secondPLayerColor = viewModel?.selectedPlayerColor()
        XCTAssertEqual(secondPLayerColor, UtilityClass.hexStringToUIColor(hex: secondPlayerHexColor))
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
}
