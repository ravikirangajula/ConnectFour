//
//  PlayerNameView.swift
//  ConnectFour
//
//  Created by Gajula Ravi Kiran on 25/01/2022.
//

import UIKit

class PlayerNameView: UIView {
    let nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.text = "Satya"
        return label
    }()
    let statusLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = .clear
        label.textAlignment = .center
        label.textColor = .green
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.text = "your turn"
        return label
    }()
    
    let stackView: UIStackView = {
        let view = UIStackView()
        //view.backgroundColor = .yellow
        view.frame = CGRect(x: 0, y: 0, width: 250, height: 200)
        view.axis = .vertical
        view.distribution = .fillEqually
        view.spacing = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(stackView)
        baseStackView()
        stackView.insertArrangedSubview(nameLabel, at: 0)
        stackView.insertArrangedSubview(statusLabel, at: 1)
        stackView.reloadInputViews()
    }
    
    func baseStackView(){
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0),
            stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            stackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1)
        ])
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
