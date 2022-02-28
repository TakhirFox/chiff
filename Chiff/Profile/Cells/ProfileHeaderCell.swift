//
//  ProfileHeaderCell.swift
//  Chiff
//
//  Created by Zakirov Tahir on 28.02.2022.
//

import UIKit
import Kingfisher

class ProfileHeaderCell: UICollectionViewCell {
    
    let avatarImage = UIImageView()
    let fullnameLabel = UILabel()
    let usernameLabel = UILabel()
    let rateLabel = UILabel()
    let personLabel = UILabel()
    let privateMessage = UIButton()
    let stackView = UIStackView()
    let horizontalStackView = UIStackView()
    let verticalGlobalStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemGray5
        layer.cornerRadius = 10
        
        avatarImage.layer.cornerRadius = 10
        avatarImage.clipsToBounds = true
        avatarImage.contentMode = .scaleAspectFill
        
        fullnameLabel.font = UIFont(name: "Arial-BoldMT", size: 16)
        
        usernameLabel.font = UIFont(name: "ArialMT", size: 16)
        usernameLabel.textColor = .systemGray
        
        rateLabel.font = UIFont(name: "ArialMT", size: 14)
        rateLabel.textColor = .systemGray
        
        personLabel.font = UIFont(name: "ArialMT", size: 14)
        
        privateMessage.setTitle("Написать", for: .normal)
        privateMessage.backgroundColor = .systemBlue
        privateMessage.layer.cornerRadius = 8
        
        verticalGlobalStackView.axis = .vertical
        verticalGlobalStackView.alignment = .fill
        verticalGlobalStackView.distribution = .fill
        verticalGlobalStackView.spacing = 10
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        horizontalStackView.axis = .horizontal
        horizontalStackView.alignment = .top
        horizontalStackView.distribution = .fill
        horizontalStackView.spacing = 10
        
        addSubview(verticalGlobalStackView)
        verticalGlobalStackView.addArrangedSubview(horizontalStackView)
        verticalGlobalStackView.addArrangedSubview(privateMessage)
        horizontalStackView.addArrangedSubview(avatarImage)
        horizontalStackView.addArrangedSubview(stackView)
        stackView.addArrangedSubview(fullnameLabel)
        stackView.addArrangedSubview(usernameLabel)
        stackView.addArrangedSubview(rateLabel)
        stackView.addArrangedSubview(personLabel)

        privateMessage.constrainHeight(constant: 40)
        avatarImage.constrainWidth(constant: 120)
        avatarImage.constrainHeight(constant: 120)

        verticalGlobalStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,
                                       padding: .init(top: 10, left: 10, bottom: 10, right: 10), size: .init(width: UIScreen.main.bounds.size.width - 32, height: 0))
         
    }
    
    func setupCell(_ user: User?) {
        if let user = user {
            let firstname = user.firstname ?? ""
            let lastname = user.lastname ?? ""
            fullnameLabel.text = firstname + " " + lastname
            usernameLabel.text = user.name
            
            let urlString = URL(string: user.avatarimage?.guid ?? "")
            avatarImage.kf.setImage(with: urlString)

            rateLabel.text = "5 отзывов?"
            personLabel.text = "Частое лицо?"
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

