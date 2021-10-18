//
//  FeedCell.swift
//  Chiff
//
//  Created by Zakirov Tahir on 06.04.2021.
//

import UIKit

class FeedCell: UICollectionViewCell {
    
    let titleLabel = UILabel()
    let imageView = UIImageView()
    let authorLabel = UILabel()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.lightGray
        
        layer.cornerRadius = 8
        layer.masksToBounds = true
        
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont(name: "ArialMT", size: 15)

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        
        authorLabel.font = UIFont(name: "Arial-BoldMT", size: 12)
        authorLabel.textColor = .white
        
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(authorLabel)
        
        imageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        titleLabel.anchor(top: imageView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 4, left: 4, bottom: 4, right: 4), size: .init(width: 0, height: 40))
        authorLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 4, left: 4, bottom: 4, right: 4), size: .init(width: 0, height: 40))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
