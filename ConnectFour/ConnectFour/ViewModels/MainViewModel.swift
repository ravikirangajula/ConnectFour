import Foundation
import UIKit

enum Player {
    case player1
    case player2
}

class MainViewModel: NSObject {
    
    private var resObject: [JsonModel]?
    var currentPlayer:Player = .player1
    var selectedItems:[IndexPath] = []
    
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
        selectedItems.append(indexPath)
    }
    func getSelectedItemsCOunt(indexPath:IndexPath) -> Int {
        let items = selectedItems.filter({$0.section == indexPath.section})
        return items.count
    }
    
    func getIndexToStore(indexPath:IndexPath) -> IndexPath {
        return IndexPath(item: (6 - getSelectedItemsCOunt(indexPath: indexPath)), section: indexPath.section)
    }
    func getSelectedItems() {
        
    }
    
    func canSelectItemAtIndex(indexPath:IndexPath) -> Bool {
        if getSelectedItemsCOunt(indexPath: indexPath) >= 6 || selectedItems.contains(indexPath)  {
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
