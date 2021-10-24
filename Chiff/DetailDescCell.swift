//
//  DetailDescCell.swift
//  Chiff
//
//  Created by Zakirov Tahir on 23.10.2021.
//

import UIKit

class DetailDescCell: UICollectionViewCell {
    
    let descriptionLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        descriptionLabel.text = "TxtxtxtxttxTxtxtxtxttxTxtxtxtxttx TxtxtxtxttxTxtxtxtxttx Txtxtxtxttx TxtxtxtxttxTxtxtxtxttx TxtxtxtxttxTxtxtxtxttx TxtxtxtxttxTxtxtxtxttxTxtxtxtxttx TxtxtxtxttxTxtxtxtxttx"
        descriptionLabel.font = UIFont(name: "ArialMT", size: 16)
        descriptionLabel.numberOfLines = 0
        
        addSubview(descriptionLabel)
        
        descriptionLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0) ,size: .init(width: 0, height: 0))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
