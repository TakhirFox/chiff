//
//  EditAvatarCell.swift
//  Chiff
//
//  Created by Zakirov Tahir on 10.03.2022.
//

import UIKit
import SnapKit

class EditAvatarCell: UITableViewCell {
    let avatarImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 75
        view.layer.masksToBounds = true
        view.image = UIImage(named: "no_image")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        configureSubviews()
        configureConstraints()
    }
    
    func configureSubviews() {
        addSubview(avatarImageView)
    }
    
    func configureConstraints() {
        avatarImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(150)
            make.width.equalTo(150)
        }

        contentView.snp.makeConstraints { make in
            make.height.equalTo(200)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
