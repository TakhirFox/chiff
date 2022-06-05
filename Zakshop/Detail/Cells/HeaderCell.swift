//
//  HeaderCell.swift
//  Chiff
//
//  Created by Zakirov Tahir on 27.02.2022.
//

import UIKit

class HeaderCell: UICollectionViewCell {
    
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemGray5
        layer.cornerRadius = 10
        
        titleLabel.font = UIFont(name: "ArialMT", size: 16)
        
        addSubview(titleLabel)
        
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 8, left: 8, bottom: 8, right: 8) ,size: .init(width: 0, height: 0))
        
    }
    
    func setupCell(_ title: String) {
        titleLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
