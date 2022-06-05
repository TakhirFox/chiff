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
        
        backgroundColor = .systemGray5
        layer.cornerRadius = 10
        
        avatarImage.layer.cornerRadius = 10
        avatarImage.clipsToBounds = true
        
        nameLabel.font = UIFont(name: "Arial-BoldMT", size: 16)
        
        rateLabel.font = UIFont(name: "ArialMT", size: 14)
        rateLabel.textColor = .systemGray
        
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
        horizontalStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 5, left: 10, bottom: 5, right: 10))
    }
    
    func setupCell(_ user: User?) {
        if let user = user {
            let firstname = user.firstname!
            let lastname = user.lastname!
            nameLabel.text = firstname + " " + lastname
            
            let urlString = URL(string: user.avatarimage?.guid ?? "")
            avatarImage.kf.setImage(with: urlString)

            rateLabel.text = "5 отзывов?"
            personLabel.text = "Частое лицо?"
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        nameLabel.preferredMaxLayoutWidth = layoutAttributes.size.width - contentView.layoutMargins.left - contentView.layoutMargins.left
        layoutAttributes.bounds.size.height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        return layoutAttributes
    }
    
}

