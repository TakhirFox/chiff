//
//  FeedCell.swift
//  Chiff
//
//  Created by Zakirov Tahir on 06.04.2021.
//

import UIKit

class FeedCell: UICollectionViewCell {
    
    let label = UILabel()
    let imageView = UIImageView()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.lightGray
        
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        label.numberOfLines = 0
        label.font = label.font.withSize(14)

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        addSubview(label)
        addSubview(imageView)
        
        imageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        label.anchor(top: imageView.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 4, left: 4, bottom: 4, right: 4), size: .init(width: 0, height: 40))
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
