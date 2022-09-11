//
//  TextfieldCell.swift
//  Chiff
//
//  Created by Zakirov Tahir on 24.10.2021.
//

import UIKit

class TextfieldCell: UICollectionViewCell {
    
    let fieldView = UIView()
    let titleLabel = UILabel()
    let textField = UITextField()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        fieldView.backgroundColor = .systemGray5
        fieldView.layer.cornerRadius = 8
        
        textField.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 18)

        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        
        addSubview(fieldView)
        addSubview(titleLabel)
        addSubview(textField)
        
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 20))
        
        fieldView.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 5, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0))
        
        textField.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 5, left: 8, bottom: 0, right: 8), size: .init(width: 0, height: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TextfieldCell: UITextViewDelegate {
    
    
}

