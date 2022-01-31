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
        if selectedItems.count == 42 {
            sendGameOverMessage?("Game Over")
        }
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

extension MainViewModel: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItemsInSection()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ConnectFourCollectionViewCell.cellIdentifier, for: indexPath) as? ConnectFourCollectionViewCell else { return UICollectionViewCell() }
        cell.setUpCell()
        return cell
    }
}

extension MainViewModel: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        setCurrentPlayer()
        collectionView.deselectItem(at: indexPath, animated: false)
        setSelectedItem(indexPath: getIndexToStore(indexPath: indexPath))
        collectionView.selectItem(at: getIndexToStore(indexPath: indexPath), animated: false, scrollPosition: UICollectionView.ScrollPosition.centeredHorizontally)
        guard let cell = collectionView.cellForItem(at: getIndexToStore(indexPath: indexPath)) as? ConnectFourCollectionViewCell else { return }
        cell.setUpCell(color: selectedPlayerColor())
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if let selectedItems = collectionView.indexPathsForSelectedItems, selectedItems.contains(indexPath) {
            return false
        }
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        return self.canSelectItemAtIndex(indexPath: indexPath)
    }
}
