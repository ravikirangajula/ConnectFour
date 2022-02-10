//
//  AlgoHandler.swift
//  ConnectFour
//
//  Created by Gajula Ravi Kiran on 30/01/2022.
//

import Foundation

class ConnectFourAlgorithm: NSObject {
    override init() {
        super.init()
    }
}

extension ConnectFourAlgorithm {
    
    func generateVerticalAlgorithm(selectedSection: IndexPath, selectedItems: [GamePattern], player: Player) -> Bool {
        let verticalArray = selectedItems.filter({$0.indexPath.section == selectedSection.section}).filter({$0.player == player})
        //rightArray
        let rowListForSelectedItems = getRowList(inputArray: [verticalArray])
        if rowListForSelectedItems.count > 3 {
            return checkIfConsicutive(inputArray: rowListForSelectedItems)
        }
        return false
    }
    
    func generateHorizontalAlgorithm(selectedSection: IndexPath, selectedItems: [GamePattern], player: Player) -> Bool {
        let horizontalArray = selectedItems.filter({$0.indexPath.row == selectedSection.row}).filter({$0.player == player})
        let rowListForSelectedItems = horizontalArray.map({$0.indexPath.section}).sorted(by: {$0 < $1})
        if rowListForSelectedItems.count > 3 {
            return checkIfConsicutive(inputArray: rowListForSelectedItems)
        }
        return false
    }
    
    func generateDiagonalAlgorithm(selectedSection: IndexPath, selectedItems: [GamePattern], player: Player) -> Bool {
        var leftDiagonalArray:[[GamePattern]] = []
        var rightDiagonalNumber:[[GamePattern]] = []

        //topLeft ->Bottom Right -> )C+ R+)
        for i in 0...4 {
            let coulm = selectedItems.filter({($0.indexPath.section == selectedSection.section + i) && ($0.player == player) && ($0.indexPath.row == selectedSection.row + i)})
            leftDiagonalArray.append(coulm)
        }
        
        //BottomRight -> Top Left ->(c_ R_)
        for i in 0...4 {
            let coulm = selectedItems.filter({($0.indexPath.section == selectedSection.section - i) && ($0.player == player) && ($0.indexPath.row == selectedSection.row - i)})
            leftDiagonalArray.append(coulm)
        }
        
        //topRight -> bottom left -> (c_ r+)
        for i in 0...4 {
            let coulm = selectedItems.filter({($0.indexPath.section == selectedSection.section - i) && ($0.player == player) && ($0.indexPath.row == selectedSection.row + i)})
            rightDiagonalNumber.append(coulm)
        }
        
        //bottonLeft -> topRight -> forward direction (C+ R-)
        for i in 0...4 {
            let coulm = selectedItems.filter({($0.indexPath.section == selectedSection.section + i) && ($0.player == player) && ($0.indexPath.row == selectedSection.row - i)})
            rightDiagonalNumber.append(coulm)
        }
        
        //leftIntArray
        let rowListForSelectedItems = getRowList(inputArray: leftDiagonalArray)
        if rowListForSelectedItems.count > 3 {
            return checkIfConsicutive(inputArray: rowListForSelectedItems)
        }
        
        //rightArray
        let rowListForSelectedItemsRight = getRowList(inputArray: rightDiagonalNumber)
        if rowListForSelectedItemsRight.count > 3 {
            return checkIfConsicutive(inputArray: rowListForSelectedItemsRight)
        }
        return false
    }
    
    func getConsecutivePatterns(inputArray:[Int]) -> [Int] {
        var consecutiveArray:[Int] = []
        let indexSet = IndexSet(inputArray)
        let rangeView = indexSet.rangeView
        let newNumbersArray = rangeView.map { Array($0.indices) }
        for item in newNumbersArray {
            if item.count > 3 {
                consecutiveArray = item
            }
        }
        return consecutiveArray
    }
    
    func isElementsConsicutive(inputArray: [Int]) -> Bool {
        if inputArray.map { $0 - 1 }.dropFirst() == inputArray.dropLast() {
            return true
        }
        return false
    }
}

//MARK: Helper Methods
extension ConnectFourAlgorithm {
    
    private func getRowList(inputArray:[[GamePattern]]) -> [Int] {
        let cleanArray:[GamePattern] = inputArray.flatMap { $0 }.compactMap{ $0 }
        return cleanArray.map({$0.indexPath.row}).sorted(by: {$0 < $1})
    }
    
    private func checkIfConsicutive(inputArray:[Int]) -> Bool {
        if inputArray.count > 3 {
            let consecutiveArray = getConsecutivePatterns(inputArray: inputArray)
            if consecutiveArray.count > 3 {
                return isElementsConsicutive(inputArray: consecutiveArray)
            }
        }
        return false
    }
    
}
