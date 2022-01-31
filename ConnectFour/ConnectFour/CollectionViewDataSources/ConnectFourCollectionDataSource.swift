//
//  ConnectFourCollectionDataSource.swift
//  ConnectFour
//
//  Created by Gajula Ravi Kiran on 30/01/2022.
//

import Foundation
import UIKit


class ConnectFourCollectionDataSource: NSObject {
  
    var viewModel: MainViewModel?
    var sendBackGameOverMessage:((_ message:String) -> ())?
    var sendBackPlayer:((_ player:Player) -> ())?


    init(model:MainViewModel?) {
      self.viewModel = model
      super.init()
      viewModel?.sendGameOverMessage = {[weak self] message in
        self?.sendBackGameOverMessage?(message)
     }
        viewModel?.playerChanged = {[weak self] currentPlayer in
          self?.sendBackPlayer?(currentPlayer)
       }
    }
    
    convenience override init() {
        self.init(model:nil)
    }
}

extension ConnectFourCollectionDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfItemsInSection() ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel?.numberOfSections() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ConnectFourCollectionViewCell.cellIdentifier, for: indexPath) as? ConnectFourCollectionViewCell else { return UICollectionViewCell() }
        cell.setUpCell()
        return cell
    }
}

extension ConnectFourCollectionDataSource: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        viewModel.setCurrentPlayer()
        collectionView.deselectItem(at: indexPath, animated: false)
        viewModel.setSelectedItem(indexPath: viewModel.getIndexToStore(indexPath: indexPath))
        collectionView.selectItem(at: viewModel.getIndexToStore(indexPath: indexPath), animated: false, scrollPosition: UICollectionView.ScrollPosition.centeredHorizontally)
        guard let cell = collectionView.cellForItem(at: viewModel.getIndexToStore(indexPath: indexPath)) as? ConnectFourCollectionViewCell else { return }
        cell.setUpCell(color: viewModel.selectedPlayerColor())
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if let selectedItems = collectionView.indexPathsForSelectedItems, selectedItems.contains(indexPath) {
            return false
        }
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        guard let viewModel = viewModel else { return false }
        return viewModel.canSelectItemAtIndex(indexPath: indexPath)
    }
}
