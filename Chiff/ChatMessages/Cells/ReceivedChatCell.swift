//
//  ReceivedChatCell.swift
//  Chiff
//
//  Created by Zakirov Tahir on 20.03.2022.
//

import UIKit
import SnapKit

class ReceivedChatCell: UITableViewCell {
    
//    let avatarImageView: UIImageView = {
//        let view = UIImageView()
//        view.layer.masksToBounds = true
//        view.image = UIImage(named: "ads")
//        view.contentMode = .scaleAspectFill
//        view.layer.cornerRadius = 10
//        return view
//    }()
    
    let bubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = .init(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.2)
        view.layer.cornerRadius = 8
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        return view
    }()
    
    let messageLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15)
        view.preferredMaxLayoutWidth = 300
        view.numberOfLines = 0
        return view
    }()
    
    let dateLabel: UILabel = {
        let view = UILabel()
        view.text = "12:75"
        view.font = .systemFont(ofSize: 12)
        view.textAlignment = .right
        view.numberOfLines = 1
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none

        configureSubviews()
        configureConstraints()
    }
    
    func configureSubviews() {
        addSubview(bubbleView)
        bubbleView.addSubview(dateLabel)
        bubbleView.addSubview(messageLabel)
    }
    
    func configureConstraints() {
        bubbleView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(4)
            make.leading.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(4)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(bubbleView).inset(10)
            make.top.equalTo(bubbleView).inset(10)
            make.height.equalTo(16)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(bubbleView).inset(10)
            make.top.equalTo(dateLabel.snp.bottom).offset(2)
            make.bottom.equalTo(bubbleView).inset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
