//
//  ImageCell.swift
//  Chiff
//
//  Created by Zakirov Tahir on 23.10.2021.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    let imageViewBackground = UIImageView()
    let loadButton = UIButton()
    let blurEffect = UIBlurEffect(style: .light)
    var blurredEffectView = UIVisualEffectView()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadButton.isHidden = true
        imageView.contentMode = .scaleAspectFit

        imageViewBackground.frame = bounds
        imageViewBackground.contentMode = .scaleToFill
        blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = imageViewBackground.bounds
        
        addSubview(imageViewBackground)
        addSubview(blurredEffectView)
        addSubview(imageView)
        addSubview(loadButton)
        
        loadButton.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        imageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        imageViewBackground.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
