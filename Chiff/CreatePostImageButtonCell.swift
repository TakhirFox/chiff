//
//  CreatePostImageButtonCell.swift
//  Chiff
//
//  Created by Zakirov Tahir on 20.10.2021.
//

import UIKit

class CreatePostImageButtonCell: UICollectionViewCell {
    
    let titleLabel = UILabel()
    let loadImageButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadImageButton.backgroundColor = .systemBlue
        loadImageButton.layer.cornerRadius = 8
        
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        
        addSubview(titleLabel)
        addSubview(loadImageButton)
        
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 20))
        loadImageButton.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 5, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

