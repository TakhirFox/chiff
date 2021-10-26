//
//  ImageCell.swift
//  Chiff
//
//  Created by Zakirov Tahir on 23.10.2021.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    let loadButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadButton.isHidden = true
                
        addSubview(imageView)
        addSubview(loadButton)
        
        loadButton.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        imageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
