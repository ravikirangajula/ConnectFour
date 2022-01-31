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
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = UIColor.white
        collection.isScrollEnabled = true
        collection.isUserInteractionEnabled = true
        collection.allowsMultipleSelection = true
        return collection
    }()
    
    lazy var dataSource: ConnectFourCollectionDataSource = {
        let obj = ConnectFourCollectionDataSource(model: viewModel)
        return obj
    }()
    
    lazy var playerTwoName: PlayerNameView = {
        let view = PlayerNameView()
        return view
    }()
    
    lazy var playerOneName: PlayerNameView = {
        let view = PlayerNameView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        initializeComponents()
        addViewsToStack()
        viewModel = MainViewModel()
        dataSource.viewModel?.setCurrentPlayer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listenForDataSourceCallback()
        listenForPLayerChange()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let layout = connectFourCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        let height = (self.connectFourCollectionView.frame.size.height/6) - 30
        let width = (self.connectFourCollectionView.frame.size.width/7) - 10
        layout.itemSize = CGSize(width: width, height: height)
        connectFourCollectionView.collectionViewLayout = layout
    }
}

//MARK: UI Setup
extension ViewController {
    private func setUpUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(stackView)
        self.view.addSubview(connectFourCollectionView)
        setupCollection()
        baseStackView()
    }
    
    private func initializeComponents() {
        connectFourCollectionView.delegate = dataSource
        connectFourCollectionView.dataSource = dataSource
        connectFourCollectionView.register(ConnectFourCollectionViewCell.self, forCellWithReuseIdentifier: ConnectFourCollectionViewCell.cellIdentifier)
    }
    
    private func setupCollection(){
        NSLayoutConstraint.activate([
            connectFourCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            connectFourCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            connectFourCollectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            connectFourCollectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
    private func baseStackView(){
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            stackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0),
            stackView.heightAnchor.constraint(equalToConstant: 180),
            stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1)
        ])
    }
    
    private func addViewsToStack() {
        let playerOneColor = PlayerColour()
        playerOneColor.setUPUI(color: UtilityClass.hexStringToUIColor(hex: viewModel.playerOneColor()))
        stackView.addArrangedSubview(playerOneColor)
        
        playerOneName.setUpUI(name: viewModel.getFirstPlayerName())
        stackView.addArrangedSubview(playerOneName)
        
        let paddingView = UIView()
        stackView.addArrangedSubview(paddingView)

        //Reset Button
        let bgView = ResetButton()
        bgView.tapOnReset = { [weak self] in
            self?.resetAllData()
        }
        stackView.addArrangedSubview(bgView)
        
        let paddingView2 = UIView()
        stackView.addArrangedSubview(paddingView2)
        
        playerTwoName.setUpUI(name: viewModel.getSecondPlayerName())
        stackView.addArrangedSubview(playerTwoName)
        
        let playerTwoColor = PlayerColour()
        playerTwoColor.setUPUI(color: UtilityClass.hexStringToUIColor(hex: viewModel.playerTwoColor()))
        stackView.addArrangedSubview(playerTwoColor)
        
        stackView.reloadInputViews()
    }
    
}

//MARK: CallBacks
extension ViewController {
    
    private func listenForPLayerChange() {
        dataSource.sendBackPlayer = { [weak self] currentPlayer in
            DispatchQueue.main.async {
                if currentPlayer == .player1 {
                    self?.playerOneName.setStatus(isHidden: true)
                    self?.playerTwoName.setStatus(isHidden: false)
                } else {
                    self?.playerOneName.setStatus(isHidden: false)
                    self?.playerTwoName.setStatus(isHidden: true)
                }
            }
        }
    }
    private func listenForDataSourceCallback() {
        dataSource.sendBackGameOverMessage = { [weak self] message in
            let alreatCOnr = UIAlertController(title: ConnectFourConstants.ALERT_TITLE, message: message, preferredStyle: .alert)
            alreatCOnr.addAction(UIAlertAction(title: ConnectFourConstants.ALERT_BUTTON_TITLE, style: .default, handler: { [weak self] action in
                self?.resetAllData()
            }))
            self?.present(alreatCOnr, animated: true, completion: nil)
        }
    }
    
    private func resetAllData() {
        self.dataSource.viewModel?.selectedItems.removeAll()
        self.connectFourCollectionView.reloadData()
    }
}
