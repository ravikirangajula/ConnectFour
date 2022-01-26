//
//  ResetButton.swift
//  ConnectFour
//
//  Created by Gajula Ravi Kiran on 26/01/2022.
//

import UIKit

class ResetButton: UIView {
    
    let roundView: UIButton = {
        let view = UIButton()
        view.setTitle("RESET", for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        view.setTitleColor(.red, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        view.clipsToBounds = true
        return view
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

    func setUpView() {
        roundView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0.0).isActive = true
        roundView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0.0).isActive = true
        roundView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.50).isActive = true
        roundView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.50).isActive = true
    }
    
    func roundButton() {
        roundView.layoutIfNeeded()
        self.layoutIfNeeded()
        roundView.layer.cornerRadius = roundView.frame.size.width/2
        roundView.clipsToBounds = true

    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
