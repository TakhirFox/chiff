//
//  PaidAdsCell.swift
//  Chiff
//
//  Created by Zakirov Tahir on 23.10.2021.
//

import UIKit

class PaidAdsCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let moreDetailsLabel = UILabel()
    let linkLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.image = UIImage(named: "ads")
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        
        titleLabel.text = "Название рекламы"
        titleLabel.font = UIFont(name: "ArialMT", size: 16)
        
        descriptionLabel.text = "Txtxtxtx ttxTxtxtxtxtt xTxtxtxtxttx Txtxtxtxt txTxtx txtxttx Txtxtxtxttx Txt xtxtxttx Txtxtxtxtt x Txtxtxt xttxTxtxtxtxttx Txtxtxtxtt xTxtxtxtxttxTxtx txtxttx Txt xtxtxttxTx txtxtxttx"
        descriptionLabel.font = UIFont(name: "ArialMT", size: 14)
        descriptionLabel.numberOfLines = 2
        
        moreDetailsLabel.text = "Подробнее"
        moreDetailsLabel.textColor = .systemBlue
        moreDetailsLabel.font = UIFont(name: "ArialMT", size: 14)
        
        linkLabel.text = "ZakirovTakhir.ru"
        linkLabel.textColor = .systemGreen
        linkLabel.font = UIFont(name: "ArialMT", size: 14)
        
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(moreDetailsLabel)
        addSubview(linkLabel)
        
        imageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0) ,size: .init(width: 0, height: 200))
        titleLabel.anchor(top: imageView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 5, left: 0, bottom: 0, right: 0) ,size: .init(width: 0, height: 20))
        descriptionLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0) ,size: .init(width: 0, height: 40))
        moreDetailsLabel.anchor(top: descriptionLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0) ,size: .init(width: 0, height: 20))
        linkLabel.anchor(top: moreDetailsLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0) ,size: .init(width: 0, height: 20))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        layoutAttributes.bounds.size.height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        return layoutAttributes
    }
}
