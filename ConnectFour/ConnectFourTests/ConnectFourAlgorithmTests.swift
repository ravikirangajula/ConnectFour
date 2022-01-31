//
//  ConnectFourAlgorithmTests.swift
//  ConnectFourTests
//
//  Created by Gajula Ravi Kiran on 31/01/2022.
//

import XCTest
@testable import ConnectFour

class ConnectFourAlgorithmTests: XCTestCase {
    
    var algoModel: ConnectFourAlgorithm?
    
    override func setUpWithError() throws {
        algoModel = ConnectFourAlgorithm()
    }

    func testHorizontalMatch() throws {
        
        let indexPath0 = IndexPath(item: 1, section: 0)
        let item0 = GamePattern.init(player: .player1, indexPath: indexPath0)
        
        let indexPath1 = IndexPath(item: 1, section: 1)
        let item1 = GamePattern.init(player: .player1, indexPath: indexPath1)
        
        let indexPath2 = IndexPath(item: 1, section: 2)
        let item2 = GamePattern.init(player: .player1, indexPath: indexPath2)
        
        let indexPath3 = IndexPath(item: 1, section: 3)
        let item3 = GamePattern.init(player: .player1, indexPath: indexPath3)
       
        //test case for true case
        let horizontalMock:[GamePattern] = [item0,item1,item2,item3]
        let isHorizontal = try XCTUnwrap(algoModel?.generateHorizontalAlgorithm(selectedSection: indexPath3, selectedItems: horizontalMock, player: .player1))
        XCTAssertTrue(isHorizontal)
        
        //test case for fail case
        let indexPath4 = IndexPath(item: 2, section: 3)
        let item4 = GamePattern.init(player: .player1, indexPath: indexPath4)
        let horizontalMockFailArray:[GamePattern] = [item1,item2,item3,item4]
        let isInHorizontal = try XCTUnwrap(algoModel?.generateHorizontalAlgorithm(selectedSection: indexPath4, selectedItems: horizontalMockFailArray, player: .player1))
        XCTAssertFalse(isInHorizontal)
        
        //test case for fail case only 3 items
        let horizontalMockForMinimumItems:[GamePattern] = [item1,item2,item3]
        let isHorizontalFor3 = try XCTUnwrap(algoModel?.generateHorizontalAlgorithm(selectedSection: indexPath4, selectedItems: horizontalMockForMinimumItems, player: .player1))
        XCTAssertFalse(isHorizontalFor3)

        //test case for [1,2,4,5] non sequence of same player and same row
        let indexPath5 = IndexPath(item: 1, section: 4)
        let item5 = GamePattern.init(player: .player1, indexPath: indexPath5)
        let nonSequenceArray:[GamePattern] = [item0,item1,item3,item5]
        let isHorizontalForNonSequence = try XCTUnwrap(algoModel?.generateHorizontalAlgorithm(selectedSection: indexPath4, selectedItems: nonSequenceArray, player: .player1))
        XCTAssertFalse(isHorizontalForNonSequence)
    }
    
    func testForVerticalAlgo() throws {
        
        let indexPath0 = IndexPath(item: 1, section: 0)
        let item0 = GamePattern.init(player: .player1, indexPath: indexPath0)
        
        let indexPath1 = IndexPath(item: 2, section: 0)
        let item1 = GamePattern.init(player: .player1, indexPath: indexPath1)
        
        let indexPath2 = IndexPath(item: 3, section: 0)
        let item2 = GamePattern.init(player: .player1, indexPath: indexPath2)
        
        let indexPath3 = IndexPath(item: 4, section: 0)
        let item3 = GamePattern.init(player: .player1, indexPath: indexPath3)
       
        //test case for true case
        let verticalMock:[GamePattern] = [item0,item1,item2,item3]
        let isVerticalMock = try XCTUnwrap(algoModel?.generateVerticalAlgorithm(selectedSection: indexPath3, selectedItems: verticalMock, player: .player1))
        XCTAssertTrue(isVerticalMock)
        
        //test case for fail case
        let indexPath4 = IndexPath(item: 4, section: 1)
        let item4 = GamePattern.init(player: .player1, indexPath: indexPath4)
        let verticalMockFailArray:[GamePattern] = [item1,item2,item3,item4]
        let isInVertical = try XCTUnwrap(algoModel?.generateVerticalAlgorithm(selectedSection: indexPath4, selectedItems: verticalMockFailArray, player: .player1))
        XCTAssertFalse(isInVertical)

        //test case for fail case only 3 items
        let verticalMockForMinimumItems:[GamePattern] = [item1,item2,item3]
        let isVerticalFor3 = try XCTUnwrap(algoModel?.generateVerticalAlgorithm(selectedSection: indexPath4, selectedItems: verticalMockForMinimumItems, player: .player1))
        XCTAssertFalse(isVerticalFor3)

        //test case for [1,2,4,5] non sequence of same player and same row
        let indexPath5 = IndexPath(item: 1, section: 4)
        let item5 = GamePattern.init(player: .player1, indexPath: indexPath5)
        let nonSequenceArray:[GamePattern] = [item0,item1,item3,item5]
        let isVerticalForNonSequence = try XCTUnwrap(algoModel?.generateVerticalAlgorithm(selectedSection: indexPath4, selectedItems: nonSequenceArray, player: .player1))
        XCTAssertFalse(isVerticalForNonSequence)
    }
    
    func testForDiagonalAlgoForTopToBottom() throws {
        
        let indexPath0 = IndexPath(item: 1, section: 0)
        let item0 = GamePattern.init(player: .player1, indexPath: indexPath0)
        
        let indexPath1 = IndexPath(item: 2, section: 1)
        let item1 = GamePattern.init(player: .player1, indexPath: indexPath1)
        
        let indexPath2 = IndexPath(item: 3, section: 2)
        let item2 = GamePattern.init(player: .player1, indexPath: indexPath2)
        
        let indexPath3 = IndexPath(item: 4, section: 3)
        let item3 = GamePattern.init(player: .player1, indexPath: indexPath3)
       
        //test case for true case
        let diagonalMock:[GamePattern] = [item0,item1,item2,item3]
        let isdiagonal = try XCTUnwrap(algoModel?.generateDiagonalAlgorithm(selectedSection: indexPath3, selectedItems: diagonalMock, player: .player1))
        XCTAssertTrue(isdiagonal)
        
        //test case for fail case
        let indexPath4 = IndexPath(item: 4, section: 1)
        let item4 = GamePattern.init(player: .player1, indexPath: indexPath4)
        let diagonalMockFailArray:[GamePattern] = [item1,item2,item3,item4]
        let isIndiagonal = try XCTUnwrap(algoModel?.generateDiagonalAlgorithm(selectedSection: indexPath4, selectedItems: diagonalMockFailArray, player: .player1))
        XCTAssertFalse(isIndiagonal)

        //test case for fail case only 3 items
        let diagonalMockFailArrayMockForMinimumItems:[GamePattern] = [item1,item2,item3]
        let isDiagonlaFor3 = try XCTUnwrap(algoModel?.generateDiagonalAlgorithm(selectedSection: indexPath4, selectedItems: diagonalMockFailArrayMockForMinimumItems, player: .player1))
        XCTAssertFalse(isDiagonlaFor3)

        //test case for [1,2,4,5] non sequence of same player and same row
        let indexPath5 = IndexPath(item: 1, section: 4)
        let item5 = GamePattern.init(player: .player1, indexPath: indexPath5)
        let nonSequenceArray:[GamePattern] = [item0,item1,item3,item5]
        let isDiagonlaForNonSequence = try XCTUnwrap(algoModel?.generateDiagonalAlgorithm(selectedSection: indexPath4, selectedItems: nonSequenceArray, player: .player1))
        XCTAssertFalse(isDiagonlaForNonSequence)
    }
    
    ///    test to check 1,2,3,4 are in diagonal
    ///    1,0,0,0
    ///    0,2,0,0
    ///    0,0,3,0
    ///    0,0,0,4
    func testDiagonalArrayForTopLeftBottomRight() throws {
        let indexPath0 = IndexPath(item: 1, section: 0)
        let item0 = GamePattern.init(player: .player1, indexPath: indexPath0)
        
        let indexPath1 = IndexPath(item: 2, section: 1)
        let item1 = GamePattern.init(player: .player1, indexPath: indexPath1)
        
        let indexPath2 = IndexPath(item: 3, section: 2)
        let item2 = GamePattern.init(player: .player1, indexPath: indexPath2)
        
        let indexPath3 = IndexPath(item: 4, section: 3)
        let item3 = GamePattern.init(player: .player1, indexPath: indexPath3)
       
        //test case for true case
        let diagonalMock:[GamePattern] = [item0,item1,item2,item3].reversed()
        let isdiagonal = try XCTUnwrap(algoModel?.generateDiagonalAlgorithm(selectedSection: indexPath3, selectedItems: diagonalMock, player: .player1))
        XCTAssertTrue(isdiagonal)
    }
    
    ///    test to check 1,2,3,4 are in diagonal
    ///    4,0,0,0
    ///    0,3,0,0
    ///    0,0,2,0
    ///    0,0,0,1
    func testDiagonalArrayForBottomRightTopLeft() throws {
        let indexPath0 = IndexPath(item: 1, section: 0)
        let item0 = GamePattern.init(player: .player1, indexPath: indexPath0)
        
        let indexPath1 = IndexPath(item: 2, section: 1)
        let item1 = GamePattern.init(player: .player1, indexPath: indexPath1)
        
        let indexPath2 = IndexPath(item: 3, section: 2)
        let item2 = GamePattern.init(player: .player1, indexPath: indexPath2)
        
        let indexPath3 = IndexPath(item: 4, section: 3)
        let item3 = GamePattern.init(player: .player1, indexPath: indexPath3)
       
        //test case for true case
        let diagonalMock:[GamePattern] = [item0,item1,item2,item3].reversed()
        let isdiagonal = try XCTUnwrap(algoModel?.generateDiagonalAlgorithm(selectedSection: indexPath0, selectedItems: diagonalMock, player: .player1))
        XCTAssertTrue(isdiagonal)
    }

    
    
    ///    test to check 1,2,3,4 are in diagonal
    ///    0,0,0,1
    ///    0,0,2,0
    ///    0,3,0,0
    ///    4,0,0,0
    func testDiagonalArrayForLeftDiagonal() throws {
        let indexPath0 = IndexPath(item: 1, section: 3)
        let item0 = GamePattern.init(player: .player1, indexPath: indexPath0)
        
        let indexPath1 = IndexPath(item: 2, section: 2)
        let item1 = GamePattern.init(player: .player1, indexPath: indexPath1)
        
        let indexPath2 = IndexPath(item: 3, section: 1)
        let item2 = GamePattern.init(player: .player1, indexPath: indexPath2)
        
        let indexPath3 = IndexPath(item: 4, section: 0)
        let item3 = GamePattern.init(player: .player1, indexPath: indexPath3)
       
        //test case for true case
        let diagonalMock:[GamePattern] = [item0,item1,item2,item3]
        let isdiagonal = try XCTUnwrap(algoModel?.generateDiagonalAlgorithm(selectedSection: indexPath3, selectedItems: diagonalMock, player: .player1))
        XCTAssertTrue(isdiagonal)
    }

    ///    test to check 1,2,3,4 are in diagonal
    ///    0,0,0,4
    ///    0,0,3,0
    ///    0,2,0,0
    ///    1,0,0,0
    func testDiagonalArrayForBottomLeftTopRightDiagonal() throws {
        let indexPath0 = IndexPath(item: 4, section: 3)
        let item0 = GamePattern.init(player: .player1, indexPath: indexPath0)
        
        let indexPath1 = IndexPath(item: 3, section: 2)
        let item1 = GamePattern.init(player: .player1, indexPath: indexPath1)
        
        let indexPath2 = IndexPath(item: 2, section: 1)
        let item2 = GamePattern.init(player: .player1, indexPath: indexPath2)
        
        let indexPath3 = IndexPath(item: 1, section: 0)
        let item3 = GamePattern.init(player: .player1, indexPath: indexPath3)
       
        //test case for true case
        let diagonalMock:[GamePattern] = [item0,item1,item2,item3]
        let isdiagonal = try XCTUnwrap(algoModel?.generateDiagonalAlgorithm(selectedSection: indexPath2, selectedItems: diagonalMock, player: .player1))
        XCTAssertTrue(isdiagonal)
    }
    
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    

}
