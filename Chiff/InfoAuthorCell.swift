//
//  InfoAuthorCell.swift
//  Chiff
//
//  Created by Zakirov Tahir on 23.10.2021.
//

import UIKit

class InfoAuthorCell: UICollectionViewCell {
    
    let avatarImage = UIImageView()
    let nameLabel = UILabel()
    let rateLabel = UILabel()
    let personLabel = UILabel()
    let stackView = UIStackView()
    let horizontalStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        avatarImage.image = UIImage(named: "ads")
        avatarImage.layer.cornerRadius = 10
        avatarImage.clipsToBounds = true
        
        nameLabel.text = "Юджин Благодаров"
        nameLabel.font = UIFont(name: "Arial-BoldMT", size: 16)
        
        rateLabel.text = "5 отзывов"
        rateLabel.font = UIFont(name: "ArialMT", size: 14)
        rateLabel.textColor = .systemGray
        
        personLabel.text = "Частое лицо"
        personLabel.font = UIFont(name: "ArialMT", size: 14)
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        horizontalStackView.axis = .horizontal
        horizontalStackView.alignment = .center
        horizontalStackView.distribution = .fill
        horizontalStackView.spacing = 10
        
        addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(avatarImage)
        horizontalStackView.addArrangedSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(rateLabel)
        stackView.addArrangedSubview(personLabel)

        avatarImage.constrainWidth(constant: 80)
        avatarImage.constrainHeight(constant: 80)
        horizontalStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 5, left: 10, bottom: 5, right: 10) ,size: .init(width: 0, height: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

