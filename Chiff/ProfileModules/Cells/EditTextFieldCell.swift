//
//  EditTextFieldCell.swift
//  Chiff
//
//  Created by Zakirov Tahir on 10.03.2022.
//

import UIKit
import SnapKit

class EditTextFieldCell: UITableViewCell {
    let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Название"
        return view
    }()
    
    let textField: UITextField = {
        let view = UITextField()
        view.backgroundColor = .systemGray5
        view.borderStyle = .roundedRect
        view.text = "asd"
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
        addSubview(textField)
    }
    
    func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(6)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(25)
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(6)
            make.height.equalTo(50)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
