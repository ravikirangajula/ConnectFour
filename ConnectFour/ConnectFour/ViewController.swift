//
//  ViewController.swift
//  ConnectFour
//
//  Created by Gajula Ravi Kiran on 25/01/2022.
//

import UIKit

class ViewController: UIViewController {
    
    let nameView: PlayerNameView = {
        let vie = PlayerNameView()
        vie.translatesAutoresizingMaskIntoConstraints = false
        return vie
    }()
    
    let stackView: UIStackView = {
        let view = UIStackView()
       // view.backgroundColor = .red
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
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(stackView)
        self.view.addSubview(connectFourCollectionView)
        connectFourCollectionView.delegate = self
        connectFourCollectionView.dataSource = self
        connectFourCollectionView.register(ConnectFourCollectionViewCell.self, forCellWithReuseIdentifier: ConnectFourCollectionViewCell.cellIdentifier)
        setupCollection()
        baseStackView()
        addViewsToStack()
    }
    
    func setupCollection(){
        NSLayoutConstraint.activate([
            connectFourCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            connectFourCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            connectFourCollectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            connectFourCollectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
    func playnerName(){
        NSLayoutConstraint.activate([
            nameView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            nameView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0),
            nameView.heightAnchor.constraint(equalToConstant: 200),
            nameView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1)
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
        stackView.insertArrangedSubview(playerOneColor, at: 0)
        
        let playerOneName = PlayerNameView()
        stackView.insertArrangedSubview(playerOneName, at: 1)
       
        let paddingView = UIView()
        stackView.insertArrangedSubview(paddingView, at: 2)

        //Reset Button
        let bgView = ResetButton()
        stackView.insertArrangedSubview(bgView, at: 3)

        let paddingView2 = UIView()
        stackView.insertArrangedSubview(paddingView2, at: 4)
               
        let playerTwoName = PlayerNameView()
        stackView.insertArrangedSubview(playerTwoName, at: 5)
        
        let playerTwoColor = PlayerColour()
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
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
}
