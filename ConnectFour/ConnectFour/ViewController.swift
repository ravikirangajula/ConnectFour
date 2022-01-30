//
//  ViewController.swift
//  ConnectFour
//
//  Created by Gajula Ravi Kiran on 25/01/2022.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var viewModel: MainViewModel = { [weak self] in
        return MainViewModel()
    }()
    
    let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var connectFourCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = UIColor.white
        collection.isScrollEnabled = true
        collection.isUserInteractionEnabled = true
        collection.allowsMultipleSelection = true
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainViewModel()
        viewModel.setCurrentPlayer()
        setUpUI()
        initliseComponents()
        addViewsToStack()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.sendGameOverMessage = { [weak self] message in
            let alreatCOnr = UIAlertController(title: ConnectFourConstants.ALERT_TITLE, message: message, preferredStyle: .alert)
            alreatCOnr.addAction(UIAlertAction(title: ConnectFourConstants.ALERT_BUTTON_TITLE, style: .default, handler: { [weak self] action in
                self?.viewModel.selectedItems.removeAll()
                self?.connectFourCollectionView.reloadData()
            }))
            self?.present(alreatCOnr, animated: true, completion: nil)
        }
        
    }
    
    func setUpUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(stackView)
        self.view.addSubview(connectFourCollectionView)
        setupCollection()
        baseStackView()
    }
    
    func initliseComponents() {
        connectFourCollectionView.delegate = self
        connectFourCollectionView.dataSource = self
        connectFourCollectionView.register(ConnectFourCollectionViewCell.self, forCellWithReuseIdentifier: ConnectFourCollectionViewCell.cellIdentifier)
    }
    
    func setupCollection(){
        NSLayoutConstraint.activate([
            connectFourCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            connectFourCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            connectFourCollectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            connectFourCollectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
    func baseStackView(){
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            stackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0),
            stackView.heightAnchor.constraint(equalToConstant: 180),
            stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1)
        ])
    }
    
    func addViewsToStack() {
        let playerOneColor = PlayerColour()
        playerOneColor.setUPUI(color: UtilityClass.hexStringToUIColor(hex: viewModel.playerOneColor()))
        stackView.insertArrangedSubview(playerOneColor, at: 0)
        
        let playerOneName = PlayerNameView()
        playerOneName.setUpUI(name: viewModel.getFirstPlayerName())
        stackView.insertArrangedSubview(playerOneName, at: 1)
        
        let paddingView = UIView()
        stackView.insertArrangedSubview(paddingView, at: 2)
        
        //Reset Button
        let bgView = ResetButton()
        bgView.tapOnReset = { [weak self] in
            self?.viewModel.selectedItems.removeAll()
            self?.connectFourCollectionView.reloadData()
        }
        stackView.insertArrangedSubview(bgView, at: 3)
        
        let paddingView2 = UIView()
        stackView.insertArrangedSubview(paddingView2, at: 4)
        
        let playerTwoName = PlayerNameView()
        playerTwoName.setUpUI(name: viewModel.getSecondPlayerName())
        stackView.insertArrangedSubview(playerTwoName, at: 5)
        
        let playerTwoColor = PlayerColour()
        playerTwoColor.setUPUI(color: UtilityClass.hexStringToUIColor(hex: viewModel.playerTwoColor()))
        
        stackView.insertArrangedSubview(playerTwoColor, at: 6)
        
        stackView.reloadInputViews()
    }
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ConnectFourCollectionViewCell.cellIdentifier, for: indexPath) as? ConnectFourCollectionViewCell else { return UICollectionViewCell() }
        cell.setUpCell()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (self.connectFourCollectionView.frame.size.height/6) - 30
        let width = (self.connectFourCollectionView.frame.size.width/7) - 10
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.setCurrentPlayer()
        collectionView.deselectItem(at: indexPath, animated: false)
        viewModel.setSelectedItem(indexPath: viewModel.getIndexToStore(indexPath: indexPath))
        collectionView.selectItem(at: viewModel.getIndexToStore(indexPath: indexPath), animated: false, scrollPosition: UICollectionView.ScrollPosition.centeredHorizontally)
        guard let cell = connectFourCollectionView.cellForItem(at: viewModel.getIndexToStore(indexPath: indexPath)) as? ConnectFourCollectionViewCell else { return }
        cell.setUpCell(color: viewModel.selectedPlayerColor())
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if let selectedItems = connectFourCollectionView.indexPathsForSelectedItems, selectedItems.contains(indexPath) {
            return false
        }
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        return viewModel.canSelectItemAtIndex(indexPath: indexPath)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
}
