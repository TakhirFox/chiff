//
//  CategoryFeedCell.swift
//  Chiff
//
//  Created by Zakirov Tahir on 01.01.2022.
//

import UIKit
import Kingfisher

class CategoryFeedCell: UICollectionViewCell {

    let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Категория"
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 12)
        view.numberOfLines = 2
        return view
    }()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "ads")
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSubviews()
        configureConstraints()
    }
    
    func setupCell(_ category: Categories) {
        titleLabel.text = category.name
        
        let url = URL(string: category.iconcats?.guid ?? "")
        imageView.kf.setImage(with: url)
    }
    
    private func configureSubviews() {
        addSubview(imageView)
        addSubview(titleLabel)
    }
    
    private func configureConstraints() {
        imageView.anchor(top: topAnchor,
                         leading: leadingAnchor,
                         bottom: nil,
                         trailing: trailingAnchor,
                         padding: .init(top: 8, left: 8, bottom: 8, right: 8))
        
        
        titleLabel.anchor(top: imageView.bottomAnchor,
                          leading: leadingAnchor,
                          bottom: bottomAnchor,
                          trailing: trailingAnchor,
                          size: .init(width: 30, height: 30))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
