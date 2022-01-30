import Foundation
import UIKit

enum Player {
    case player1
    case player2
}

struct GamePattern {
    let player:Player
    let indexPath:IndexPath
}

class MainViewModel: NSObject {
    
    var sendGameOverMessage:((_ message:String) -> ())?
    
    var connectFourAlgorithmModel: ConnectFourAlgorithm = {
        return ConnectFourAlgorithm()
    }()
    
    private var resObject: [JsonModel]?
    var currentPlayer:Player = .player1
    var selectedItems:[GamePattern] = []
    
    override init() {
        super.init()
        if let data = readLocalJSONFile(forName: "MockApi") {
            resObject = parse(jsonData: data)
            print("Res== \(resObject)")
        }
    }
    
}

extension MainViewModel {
    
    func setCurrentPlayer() {
        currentPlayer = currentPlayer == .player1 ? .player2 : .player1
    }
    
    func selectedPlayerColor() -> UIColor {
        switch currentPlayer {
        case .player1:
            return UtilityClass.hexStringToUIColor(hex: playerOneColor())
        default:
            return UtilityClass.hexStringToUIColor(hex: playerTwoColor())
        }
    }
    
    func getFirstPlayerName() -> String {
        return resObject?.first?.name1 ?? ""
    }
    
    func playerOneColor() -> String {
        return resObject?.first?.color1 ?? ""
    }
    func playerTwoColor() -> String {
        return resObject?.first?.color2 ?? ""
    }
    
    func getSecondPlayerName() -> String {
        return resObject?.first?.name2 ?? ""
    }
    
    func setSelectedItem(indexPath:IndexPath)  {
        let playerObj = GamePattern(player: currentPlayer, indexPath: indexPath)
        selectedItems.append(playerObj)
        
        //check for verticalArray
        if connectFourAlgorithmModel.generateVerticalAlgorithm(selectedSection: indexPath, selectedItems: selectedItems, player: currentPlayer) {
            sendGameOverMessage?("Winner is \(currentPlayer)")
        } else if connectFourAlgorithmModel.generateHorizontalAlgorithm(selectedSection: indexPath, selectedItems: selectedItems, player: currentPlayer) {
            sendGameOverMessage?("Winner is \(currentPlayer)")
        } else if connectFourAlgorithmModel.generateDiagonalAlgorithm(selectedSection: indexPath, selectedItems: selectedItems, player: currentPlayer) == true {
            sendGameOverMessage?("Winner is \(currentPlayer)")
        }
       // genreralALgo(selectedSection: indexPath, isVertical: false)

    }
    
    func generateDiagonalArray(selectedSection:IndexPath) {
        var number:[[GamePattern]] = []
        for i in 0...selectedSection.section {
            let coulm = selectedItems.filter({($0.indexPath.section == selectedSection.section - i) && ($0.player == currentPlayer) && ($0.indexPath.row == selectedSection.row + i)})
            number.append(coulm)
        }
        print("number == \(number)")
        var arr:[GamePattern] = number.flatMap { $0 }.compactMap{ $0 } ?? []
        var intArray1:[Int] = arr.map({$0.indexPath.row}).sorted(by: {$0 < $1})
        print("intArray == \(intArray1)")
        if intArray1.count > 3 {
            if get4Concctivearray(inputArray: intArray1).count > 3 {
                isElementsConsicutive(inputArray: get4Concctivearray(inputArray: intArray1))
            }
        }
    }
    func generateTopToBottomDiagonalArray(selectedSection:IndexPath) {
        var number:[[GamePattern]] = []
        for i in 0...selectedSection.section {
            let coulm = selectedItems.filter({($0.indexPath.section == selectedSection.section - i) && ($0.player == currentPlayer) && ($0.indexPath.row == selectedSection.row - i)})
            number.append(coulm)
        }
        print("number == \(number)")
        var arr:[GamePattern] = number.flatMap { $0 }.compactMap{ $0 } ?? []
        var intArray1:[Int] = arr.map({$0.indexPath.row}).sorted(by: {$0 < $1})
        print("intArray == \(intArray1)")
        if intArray1.count > 3 {
            if get4Concctivearray(inputArray: intArray1).count > 3 {
                isElementsConsicutive(inputArray: get4Concctivearray(inputArray: intArray1))
            }
        }
    }
    
//    func generateCommonDiagonalArray(selectedSection:IndexPath) {
//        var leftnumber:[[GamePattern]] = []
//        var rightnumber:[[GamePattern]] = []
//
//        let totalRows = 6
//        let totalSections = 7
//        var remainingRows = totalRows - selectedSection.row
//        var remainingSections = totalSections - selectedSection.section
//
//
//        //bottomleft
//        if remainingRows != 0 {
//        for i in 0...remainingRows {
//            let coulm = selectedItems.filter({($0.indexPath.section == selectedSection.section + i) && ($0.player == currentPlayer) && ($0.indexPath.row == selectedSection.row + i)})
//            leftnumber.append(coulm)
//        }
//        }
//        //topLeft
//        if remainingSections != totalSections {
//            remainingSections = remainingSections == 0 ? totalSections : remainingSections
//            for i in 0...(remainingSections + 1) {
//                let coulm = selectedItems.filter({($0.indexPath.section == selectedSection.section - i) && ($0.player == currentPlayer) && ($0.indexPath.row == selectedSection.row - i)})
//                leftnumber.append(coulm)
//            }
//
//        }
//
//        //bottomright
//        for i in 0...remainingRows {
//            let coulm = selectedItems.filter({($0.indexPath.section == selectedSection.section - i) && ($0.player == currentPlayer) && ($0.indexPath.row == selectedSection.row + i)})
//            rightnumber.append(coulm)
//        }
//
//        //topRight
//        if remainingSections != totalSections {
//            remainingSections = remainingSections == 0 ? totalSections : remainingSections
//            for i in 0...remainingSections {
//                let coulm = selectedItems.filter({($0.indexPath.section == selectedSection.section + i) && ($0.player == currentPlayer) && ($0.indexPath.row == selectedSection.row - i)})
//                rightnumber.append(coulm)
//            }
//
//        }
//        print("number == \(leftnumber)")
//        print("number == \(rightnumber)")
//
//        var arr:[GamePattern] = leftnumber.flatMap { $0 }.compactMap{ $0 }
//        let intArray1:[Int] = arr.map({$0.indexPath.row}).sorted(by: {$0 < $1})
//        print("intArray == \(intArray1)")
//
//        var rightArr:[GamePattern] = rightnumber.flatMap { $0 }.compactMap{ $0 }
//        let rightIntArray1:[Int] = rightArr.map({$0.indexPath.row}).sorted(by: {$0 < $1})
//        print("rightIntArray1 == \(rightIntArray1)")
//
//
//        if intArray1.count > 3 {
//            if get4Concctivearray(inputArray: intArray1).count > 3 {
//                isElementsConsicutive(inputArray: get4Concctivearray(inputArray: intArray1))
//            }
//        }
//
//        if rightIntArray1.count > 3 {
//            if get4Concctivearray(inputArray: rightIntArray1).count > 3 {
//                isElementsConsicutive(inputArray: get4Concctivearray(inputArray: rightIntArray1))
//            }
//        }
//
//    }
    
//    func generateDiagonalArray(selectedSection:IndexPath) {
//        var number:[[GamePattern]] = []
//        for i in 0...selectedSection.section {
//            let coulm = selectedItems.filter({($0.indexPath.section == selectedSection.section - i) && ($0.player == currentPlayer) && ($0.indexPath.row == selectedSection.row + i)})
//            number.append(coulm)
//        }
//        print("number == \(number)")
//        var arr:[GamePattern] = number.flatMap { $0 }.compactMap{ $0 } ?? []
//        var intArray1:[Int] = arr.map({$0.indexPath.row}).sorted(by: {$0 < $1})
//        print("intArray == \(intArray1)")
//        if intArray1.count > 3 {
//            if get4Concctivearray(inputArray: intArray1).count > 3 {
//                isElementsConsicutive(inputArray: get4Concctivearray(inputArray: intArray1))
//            }
//        }
//    }
//    func generateTopToBottomDiagonalArray(selectedSection:IndexPath) {
//        var number:[[GamePattern]] = []
//        for i in 0...selectedSection.section {
//            let coulm = selectedItems.filter({($0.indexPath.section == selectedSection.section - i) && ($0.player == currentPlayer) && ($0.indexPath.row == selectedSection.row - i)})
//            number.append(coulm)
//        }
//        print("number == \(number)")
//        var arr:[GamePattern] = number.flatMap { $0 }.compactMap{ $0 } ?? []
//        var intArray1:[Int] = arr.map({$0.indexPath.row}).sorted(by: {$0 < $1})
//        print("intArray == \(intArray1)")
//        if intArray1.count > 3 {
//            if get4Concctivearray(inputArray: intArray1).count > 3 {
//                isElementsConsicutive(inputArray: get4Concctivearray(inputArray: intArray1))
//            }
//        }
//    }
    
    func generateLeftDiagonalArray(selectedSection:IndexPath) {
        var number:[[GamePattern]] = []
        for i in 0...(7 - selectedSection.section) {
            let coulm = selectedItems.filter({($0.indexPath.section == selectedSection.section + i) && ($0.player == currentPlayer) && ($0.indexPath.row == selectedSection.row + i)})
            number.append(coulm)
        }
        print("number == \(number)")
        var arr:[GamePattern] = number.flatMap { $0 }.compactMap{ $0 }
        let intArray1:[Int] = arr.map({$0.indexPath.row}).sorted(by: {$0 < $1})
        print("generateLeftDiagonalArray intArray == \(intArray1)")
        if intArray1.count > 3 {
            if get4Concctivearray(inputArray: intArray1).count > 3 {
                isElementsConsicutive(inputArray: get4Concctivearray(inputArray: intArray1))
            }
        }
    }
    
    func genreralALgo(selectedSection:IndexPath, isVertical:Bool) {
        var number:[GamePattern] = []
        var intArray1:[Int] = []
        if isVertical {
            number = selectedItems.filter({$0.indexPath.section == selectedSection.section}).filter({$0.player == currentPlayer})
            intArray1 = number.map({$0.indexPath.row}).sorted(by: {$0 < $1})
        } else {
            number = selectedItems.filter({$0.indexPath.row == selectedSection.row}).filter({$0.player == currentPlayer})
            intArray1 = number.map({$0.indexPath.section}).sorted(by: {$0 < $1})
        }
        if intArray1.count > 3 {
            if get4Concctivearray(inputArray: intArray1).count > 3 {
                isElementsConsicutive(inputArray: get4Concctivearray(inputArray: intArray1))
            }
        }
    }
    
    func get4Concctivearray(inputArray:[Int]) -> [Int] {
        let indexSet = IndexSet(inputArray)
        let rangeView = indexSet.rangeView
        let newNumbersArray = rangeView.map { Array($0.indices) }
        var arra:[Int] = []
        for item in newNumbersArray {
            if item.count > 3 {
                arra = item
            }
        }
        return arra
    }
    
    func isElementsConsicutive(inputArray:[Int]){
        if inputArray.map { $0 - 1 }.dropFirst() == inputArray.dropLast() {
            sendGameOverMessage?("Game Over Dude")
        }
    }
    
    func getSelectedItemsCOunt(indexPath:IndexPath) -> Int {
        let items = selectedItems.filter({$0.indexPath.section == indexPath.section})
        return items.count
    }
    
    func getIndexToStore(indexPath:IndexPath) -> IndexPath {
        return IndexPath(item: (6 - getSelectedItemsCOunt(indexPath: indexPath)), section: indexPath.section)
    }
    
    func canSelectItemAtIndex(indexPath:IndexPath) -> Bool {
        if getSelectedItemsCOunt(indexPath: indexPath) >= 6 || selectedItems.contains(where: {$0.indexPath == indexPath})  {
            return false
        }
        return true
    }
    
}

//MARK: Json Loading
extension MainViewModel {
    
    private func readLocalJSONFile(forName name: String) -> Data? {
        do {
            if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                return data
            }
        } catch {
            print("error: \(error)")
        }
        return nil
    }
    
    func parse(jsonData: Data) -> [JsonModel]? {
        do {
            let decodedData = try JSONDecoder().decode([JsonModel].self, from: jsonData)
            return decodedData
        } catch {
            print("error: \(error)")
        }
        return nil
    }
}
