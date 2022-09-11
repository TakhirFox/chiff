//
//  UserMapCell.swift
//  Zakshop
//
//  Created by Zakirov Tahir on 11.09.2022.
//

import UIKit

class UserMapCell: UICollectionViewCell {
    let titleLabel = UILabel()
    let imageView = UIImageView()
    let horizontalStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemGray5
        layer.cornerRadius = 10
        
        titleLabel.font = UIFont(name: "ArialMT", size: 16)
        titleLabel.numberOfLines = 3
        
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true

        horizontalStackView.axis = .horizontal
        horizontalStackView.alignment = .center
        horizontalStackView.distribution = .equalCentering
        horizontalStackView.spacing = 10
        
        addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(titleLabel)
        horizontalStackView.addArrangedSubview(imageView)
        
        imageView.constrainWidth(constant: 100)
        imageView.constrainHeight(constant: 80)
        
        horizontalStackView.anchor(top: topAnchor,
                                   leading: leadingAnchor,
                                   bottom: bottomAnchor,
                                   trailing: trailingAnchor,
                                   padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
