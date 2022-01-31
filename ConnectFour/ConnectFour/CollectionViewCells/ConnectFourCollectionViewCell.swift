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
        button.isUserInteractionEnabled = true
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(circleView)
        self.contentView.isUserInteractionEnabled = true
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

    func setUpCell(color:UIColor = #colorLiteral(red: 0.1921568627, green: 0.5843137255, blue: 0.6196078431, alpha: 1)) {
        circleView.backgroundColor = color
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
