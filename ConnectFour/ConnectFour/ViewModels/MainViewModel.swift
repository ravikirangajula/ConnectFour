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
    
    var dataFetcherModel: DataFetcher?
    
    var currentPlayer:Player = .player1
    var selectedItems:[GamePattern] = []
    
    override init() {
        super.init()
        dataFetcherModel = DataFetcher()
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
        return dataFetcherModel?.resObject?.first?.name1 ?? ""
    }
    
    func playerOneColor() -> String {
        return dataFetcherModel?.resObject?.first?.color1 ?? ""
    }
    func playerTwoColor() -> String {
        return dataFetcherModel?.resObject?.first?.color2 ?? ""
    }
    
    func getSecondPlayerName() -> String {
        return dataFetcherModel?.resObject?.first?.name2 ?? ""
    }
    
    func setSelectedItem(indexPath:IndexPath)  {
        let playerObj = GamePattern(player: currentPlayer, indexPath: indexPath)
        selectedItems.append(playerObj)
        
        //check for verticalArray
        if connectFourAlgorithmModel.generateVerticalAlgorithm(selectedSection: indexPath, selectedItems: selectedItems, player: currentPlayer) {
            sendGameOverMessage?("\(ConnectFourConstants.ALERT_MESSAGE)\(currentPlayer)")
        } else if connectFourAlgorithmModel.generateHorizontalAlgorithm(selectedSection: indexPath, selectedItems: selectedItems, player: currentPlayer) {
            sendGameOverMessage?("\(ConnectFourConstants.ALERT_MESSAGE)\(currentPlayer)")
        } else if connectFourAlgorithmModel.generateDiagonalAlgorithm(selectedSection: indexPath, selectedItems: selectedItems, player: currentPlayer) == true {
            sendGameOverMessage?("\(ConnectFourConstants.ALERT_MESSAGE)\(currentPlayer)")
        }
    }
    
    func getSelectedItemsCount(indexPath:IndexPath) -> Int {
        let items = selectedItems.filter({$0.indexPath.section == indexPath.section})
        return items.count
    }
    
    func getIndexToStore(indexPath:IndexPath) -> IndexPath {
        return IndexPath(item: (6 - getSelectedItemsCount(indexPath: indexPath)), section: indexPath.section)
    }
    
    func canSelectItemAtIndex(indexPath:IndexPath) -> Bool {
        if getSelectedItemsCount(indexPath: indexPath) >= 6 || selectedItems.contains(where: {$0.indexPath == indexPath})  {
            return false
        }
        return true
    }
    
}
