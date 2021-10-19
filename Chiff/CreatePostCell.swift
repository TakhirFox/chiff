//
//  CreatePostCell.swift
//  Chiff
//
//  Created by admin on 19.10.2021.
//

import UIKit

class CreatePostCell: UICollectionViewCell {
    
    let titleLabel = UILabel()
    let textfield = UITextField()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        

        
        backgroundColor = .green
        
        textfield.placeholder = "Введите поле"
        textfield.backgroundColor = .red
        textfield.layer.cornerRadius = 8
        
        titleLabel.text = "Описание поста, записи, чего-либо еще"
        
        addSubview(titleLabel)
        addSubview(textfield)
        
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0))
        textfield.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 70))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


