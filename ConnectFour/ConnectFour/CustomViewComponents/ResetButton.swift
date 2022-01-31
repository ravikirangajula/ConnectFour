//
//  ResetButton.swift
//  ConnectFour
//
//  Created by Gajula Ravi Kiran on 26/01/2022.
//

import UIKit

class ResetButton: UIView {
    
    var tapOnReset:(() -> ())?

    let roundView: UIButton = {
        let button = UIButton()
        button.setTitle("RESET", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        button.setTitleColor(.red, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .lightGray
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(resetAll), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(roundView)
        setUpView()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        roundButton()
    }
    
    @objc func resetAll() {
        tapOnReset?()
    }
    
    func setUpView() {
        roundView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0.0).isActive = true
        roundView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0.0).isActive = true
        roundView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.50).isActive = true
        roundView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.50).isActive = true
    }
    
    func roundButton() {
        roundView.layer.cornerRadius = roundView.frame.size.width/2
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
