//
//  ContactCell.swift
//  Chiff
//
//  Created by Zakirov Tahir on 23.10.2021.
//

import UIKit

class ContactCell: UICollectionViewCell {
    let callButton = UIButton()
    let messageButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        callButton.backgroundColor = .systemGreen
        callButton.setTitle("Позвонить", for: .normal)
        callButton.layer.cornerRadius = 8
        
        messageButton.backgroundColor = .systemBlue
        messageButton.setTitle("Написать", for: .normal)
        messageButton.layer.cornerRadius = 8
        
        addSubview(callButton)
        addSubview(messageButton)
        
        callButton.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: frame.width / 2, height: 0))
        messageButton.anchor(top: topAnchor, leading: callButton.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 5, bottom: 0, right: 0), size: .init(width: frame.width / 2, height: 0))
        
    }
    
    func setupCell(_ news: DetailNews?) {
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
