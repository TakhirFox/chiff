//
//  EditButtonCell.swift
//  Chiff
//
//  Created by Zakirov Tahir on 10.03.2022.
//

import UIKit
import SnapKit

class EditButtonCell: UITableViewCell {
    let actionButton: UIButton = {
        let view = UIButton()
        view.layer.cornerRadius = 8
        view.backgroundColor = .red
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        configureSubviews()
        configureConstraints()
    }
    
    func configureSubviews() {
        addSubview(actionButton)
    }
    
    func configureConstraints() {
        actionButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }

        contentView.snp.makeConstraints { make in
            make.height.equalTo(120)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
