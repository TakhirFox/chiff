//
//  TitleCell.swift
//  Chiff
//
//  Created by Zakirov Tahir on 13.03.2022.
//

import UIKit
import SnapKit

class TitleCell: UITableViewCell {
    let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Название?"
        view.font = .boldSystemFont(ofSize: 52)
        view.numberOfLines = 0
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        configureSubviews()
        configureConstraints()
    }
    
    func configureSubviews() {
        addSubview(titleLabel)
    }
    
    func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }

        contentView.snp.makeConstraints { make in
            make.height.equalTo(150)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
