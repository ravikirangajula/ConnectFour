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
        layout.sectionInset = UIEdgeInsets(top: ConnectFourConstants.COLLECTION_VIEW_CELL_INSETS, left: ConnectFourConstants.COLLECTION_VIEW_CELL_INSETS, bottom: ConnectFourConstants.COLLECTION_VIEW_CELL_INSETS, right: ConnectFourConstants.COLLECTION_VIEW_CELL_INSETS)
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listenForDataSourceCallback()
        listenForPLayerChange()
        /* Note: if we use tableview data source as dataSource object then need to implement this
         dataSource.viewModel?.setCurrentPlayer()
         */
        viewModel.setCurrentPlayer()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let layout = connectFourCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        let insetsforHeight = CGFloat(viewModel.numberOfItemsInSection()) * ConnectFourConstants.COLLECTION_VIEW_CELL_INSETS
        let insetsforWidth = 2 * ConnectFourConstants.COLLECTION_VIEW_CELL_INSETS
        let height = (self.connectFourCollectionView.frame.size.height/CGFloat(viewModel.numberOfItemsInSection())) - insetsforHeight
        let width = (self.connectFourCollectionView.frame.size.width/CGFloat(viewModel.numberOfSections())) - insetsforWidth
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
        /* Note: if we use tableview data source as dataSource object then need to implement this
         connectFourCollectionView.delegate = dataSource
         connectFourCollectionView.dataSource = dataSource
        */
        connectFourCollectionView.delegate = viewModel
        connectFourCollectionView.dataSource = viewModel
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
        /* Note: if we use data source then need to implement this
         dataSource.sendBackPlayer = { [weak self] currentPlayer in
         } */
        viewModel.playerChanged = { [weak self] currentPlayer in
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
        /* Note: if use data source then need to implement this
         dataSource.sendBackGameOverMessage = { [weak self] message in
         } */
        viewModel.sendGameOverMessage = { [weak self] message in
            let alreatCOnr = UIAlertController(title: ConnectFourConstants.ALERT_TITLE, message: message, preferredStyle: .alert)
            alreatCOnr.addAction(UIAlertAction(title: ConnectFourConstants.ALERT_BUTTON_TITLE, style: .default, handler: { [weak self] action in
                self?.resetAllData()
            }))
            self?.present(alreatCOnr, animated: true, completion: nil)
        }
    }
    
    private func resetAllData() {
        /* Note: if use data source then need to implement this
         self.dataSource.viewModel?.selectedItems.removeAll()
         } */
        self.viewModel.selectedItems.removeAll()
        self.connectFourCollectionView.reloadData()
    }
}
