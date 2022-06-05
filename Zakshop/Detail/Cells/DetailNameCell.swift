//
//  DetailNameCell.swift
//  Chiff
//
//  Created by Zakirov Tahir on 23.10.2021.
//

import UIKit

class DetailNameCell: UICollectionViewCell {
    
    let titleLabel = UILabel()
    let costLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.font = UIFont(name: "ArialMT", size: 22)
        
        costLabel.font = UIFont(name: "Arial-BoldMT", size: 22)
        
        addSubview(titleLabel)
        addSubview(costLabel)
        
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 4, right: 0) ,size: .init(width: 0, height: 0))
        costLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, size: .init(width: 0, height: 0))
        
    }
    
    func setupCell(_ news: News?) {
        titleLabel.text = news?.title?.rendered
        costLabel.text = "\(news?.cost ?? "") ₽"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
