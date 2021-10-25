//
//  CreatePostCell.swift
//  Chiff
//
//  Created by admin on 19.10.2021.
//

import UIKit

class CreatePostCell: UICollectionViewCell {
    
    let titleLabel = UILabel()
    let textView = UITextView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textView.textColor = UIColor.lightGray
        textView.backgroundColor = .systemGray5
        textView.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 18)
        textView.layer.cornerRadius = 8
        
        
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        
        addSubview(titleLabel)
        addSubview(textView)
        
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0))
        textView.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 5, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CreatePostCell: UITextViewDelegate {
    
    
}

