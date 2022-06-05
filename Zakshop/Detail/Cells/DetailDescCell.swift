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
        
        descriptionLabel.font = UIFont(name: "ArialMT", size: 16)
        descriptionLabel.numberOfLines = 0
        
        addSubview(descriptionLabel)
        
        descriptionLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
    }
    
    func setupCell(_ news: News?) {
        descriptionLabel.text = news?.content?.rendered
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        descriptionLabel.preferredMaxLayoutWidth = layoutAttributes.size.width - contentView.layoutMargins.left - contentView.layoutMargins.left
        layoutAttributes.bounds.size.height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        return layoutAttributes
    }
    
}
