//
//  LoadImageCell.swift
//  Zakshop
//
//  Created by Zakirov Tahir on 11.09.2022.
//

import UIKit

class LoadImageCell: UICollectionViewCell {
    let titleLabel = UILabel()
    let plusLabel = UILabel()
    let plusImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        titleLabel.textColor = .white
        
        plusLabel.textAlignment = .center
        plusLabel.textColor = .init(red: 158/255, green: 158/255, blue: 158/255, alpha: 1)
        plusLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 24)
        
        plusImageView.image = UIImage(systemName: "plus.circle.fill")
        plusImageView.contentMode = .scaleAspectFit
        plusImageView.tintColor = .init(red: 158/255, green: 158/255, blue: 158/255, alpha: 1)
        
        addSubview(titleLabel)
        addSubview(plusLabel)
        addSubview(plusImageView)
        
        titleLabel.anchor(top: topAnchor,
                          leading: leadingAnchor,
                          bottom: nil,
                          trailing: trailingAnchor,
                          padding: .init(top: 10, left: 0, bottom: 0, right: 0),
                          size: .init(width: 0, height: 20))
        
        plusLabel.anchor(top: titleLabel.bottomAnchor,
                         leading: leadingAnchor,
                         bottom: nil,
                         trailing: trailingAnchor,
                         padding: .init(top: 50, left: 0, bottom: 0, right: 0),
                         size: .init(width: 0, height: 50))
        
        plusImageView.anchor(top: plusLabel.bottomAnchor,
                             leading: leadingAnchor,
                             bottom: bottomAnchor,
                             trailing: trailingAnchor,
                             size: .init(width: 50, height: 50))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
