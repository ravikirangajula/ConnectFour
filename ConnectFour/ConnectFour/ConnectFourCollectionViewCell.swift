//
//  ConnectFourCollectionViewCell.swift
//  ConnectFour
//
//  Created by Gajula Ravi Kiran on 25/01/2022.
//

import UIKit

class ConnectFourCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "ConnectFourCollectionViewCell"
    
    lazy var circleView: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
       // self.backgroundColor = .yellow
        self.addSubview(circleView)
        setupCollection()
        layoutIfNeeded()
        roundButton()
    }
    
    func setupCollection(){
        circleView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        circleView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        circleView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.90).isActive = true
        circleView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.90).isActive = true
    }
    
    func roundButton() {
        circleView.backgroundColor = .blue
        circleView.layer.masksToBounds = true
        circleView.layer.cornerRadius = circleView.frame.size.width/2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
