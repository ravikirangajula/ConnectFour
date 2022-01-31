//
//  PlayerNameView.swift
//  ConnectFour
//
//  Created by Gajula Ravi Kiran on 25/01/2022.
//

import UIKit

class PlayerNameView: UIView {
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.text = "your turn."
        return label
    }()
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.frame = CGRect(x: 0, y: 0, width: 250, height: 200)
        view.axis = .vertical
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(stackView)
        baseStackView()
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(statusLabel)
        stackView.reloadInputViews()
    }
    
    private func baseStackView(){
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
    
    func setUpUI(name:String) {
        self.nameLabel.text = name
        self.statusLabel.isHidden = true
    }
    
    func setStatus(isHidden: Bool = true) {
        self.statusLabel.isHidden = isHidden
    }
}
