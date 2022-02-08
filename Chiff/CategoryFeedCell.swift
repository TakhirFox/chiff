//
//  CategoryFeedCell.swift
//  Chiff
//
//  Created by Zakirov Tahir on 01.01.2022.
//

import UIKit

class CategoryFeedCell: UICollectionViewCell {

    let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Категория"
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 13)
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
        configureUI()
    }
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
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
                         padding: .init(top: 0, left: 4, bottom: 0, right: 4))
        
        
        titleLabel.anchor(top: imageView.bottomAnchor,
                          leading: leadingAnchor,
                          bottom: bottomAnchor,
                          trailing: trailingAnchor,
                          size: .init(width: 0, height: 40))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
