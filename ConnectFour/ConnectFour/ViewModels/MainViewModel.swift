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
    //callBack method
    var sendGameOverMessage:((_ message:String) -> ())?
    var playerChanged:((_ currentPlayer:Player) -> ())?

    lazy var connectFourAlgorithmModel: ConnectFourAlgorithm = {
        return ConnectFourAlgorithm()
    }()
    
    lazy var dataFetcherModel: DataFetcher = {
        return DataFetcher()
    }()
    
    var currentPlayer:Player = .player1
    var selectedItems:[GamePattern] = []
    
    override init() {
        super.init()
    }
}

//MARK: Public Methods
extension MainViewModel {
    
    func setCurrentPlayer() {
        currentPlayer = currentPlayer == .player1 ? .player2 : .player1
        playerChanged?(currentPlayer)
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
        return dataFetcherModel.resObject?.first?.name1 ?? ""
    }
    
    func playerOneColor() -> String {
        return dataFetcherModel.resObject?.first?.color1 ?? ""
    }
    func playerTwoColor() -> String {
        return dataFetcherModel.resObject?.first?.color2 ?? ""
    }
    
    func getSecondPlayerName() -> String {
        return dataFetcherModel.resObject?.first?.name2 ?? ""
    }
    
    func setSelectedItem(indexPath:IndexPath)  {
        let playerObj = GamePattern(player: currentPlayer, indexPath: indexPath)
        selectedItems.append(playerObj)
        
        //check for verticalArray
        if connectFourAlgorithmModel.generateVerticalAlgorithm(selectedSection: indexPath, selectedItems: selectedItems, player: currentPlayer) {
            sendGameOverMessage?("\(ConnectFourConstants.ALERT_MESSAGE) \(getCurrentPlayerName())")
        } else if connectFourAlgorithmModel.generateHorizontalAlgorithm(selectedSection: indexPath, selectedItems: selectedItems, player: currentPlayer) {
            sendGameOverMessage?("\(ConnectFourConstants.ALERT_MESSAGE) \(getCurrentPlayerName())")
        } else if connectFourAlgorithmModel.generateDiagonalAlgorithm(selectedSection: indexPath, selectedItems: selectedItems, player: currentPlayer) == true {
            sendGameOverMessage?("\(ConnectFourConstants.ALERT_MESSAGE) \(getCurrentPlayerName())")
        }
    }
    

    
    func getIndexToStore(indexPath:IndexPath) -> IndexPath {
        return IndexPath(item: (numberOfItemsInSection() - getSelectedItemsCount(indexPath: indexPath)), section: indexPath.section)
    }
    
    func canSelectItemAtIndex(indexPath:IndexPath) -> Bool {
        if getSelectedItemsCount(indexPath: indexPath) >= numberOfItemsInSection() || selectedItems.contains(where: {$0.indexPath == indexPath})  {
            return false
        }
        return true
    }
    
}

//MARK: Private methods
extension MainViewModel {
    
    private func getSelectedItemsCount(indexPath:IndexPath) -> Int {
        let items = selectedItems.filter({$0.indexPath.section == indexPath.section})
        return items.count
    }
    
    private func getCurrentPlayerName() -> String {
        return currentPlayer == .player1 ? getFirstPlayerName() : getSecondPlayerName()
    }
    
}

//MARK: Collection Data Source inputs
extension MainViewModel {
    func numberOfSections() -> Int {
        return 7
    }
    
    func numberOfItemsInSection() -> Int {
        return 6
    }
}
