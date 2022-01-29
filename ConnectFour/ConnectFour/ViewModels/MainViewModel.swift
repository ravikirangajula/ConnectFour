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
        genreralALgo(selectedSection: indexPath, isVertical: true)
        genreralALgo(selectedSection: indexPath, isVertical: false)
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
    
    //    func verticalRowAlgo(selectedSection:IndexPath) {
    //        let selectedSectionItems = selectedItems.filter({$0.indexPath.section == selectedSection.section})
    //        if selectedSectionItems.count > 3 {
    //            let player1Items = selectedSectionItems.filter({$0.player == currentPlayer}).sorted(by: {$0.indexPath < $1.indexPath})
    //            let intArray1:[Int] = player1Items.map({$0.indexPath.row})
    //            if intArray1.map { $0 - 1 }.dropFirst() == intArray1.dropLast() {
    //                sendGameOverMessage?("Game Over Dude")
    //            }
    //        }
    //    }
    
    //    func horizontalAlgo(selectedSection:IndexPath) {
    //        print("items List in Player1 == \(selectedItems)")
    //        let number = selectedItems.filter({$0.indexPath.row == selectedSection.row}).filter({$0.player == currentPlayer})
    //        let intArray1:[Int] = number.map({$0.indexPath.section}).sorted(by: {$0 < $1})
    //        if intArray1.count > 4 {
    //            let subarr0 = intArray1[intArray1.count - 4..<intArray1.count] // ArraySlice<Info>
    //            print("intArray1 == \(intArray1)")
    //            if subarr0.count > 3 {
    //                if subarr0.map { $0 - 1 }.dropFirst() == subarr0.dropLast() {
    //                    sendGameOverMessage?("Game Over Dude")
    //                }
    //            }
    //        } else {
    //            if intArray1.count > 3 {
    //                if intArray1.map { $0 - 1 }.dropFirst() == intArray1.dropLast() {
    //                    sendGameOverMessage?("Game Over Dude")
    //                }
    //            }
    //        }
    //
    //    }
    
    
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
