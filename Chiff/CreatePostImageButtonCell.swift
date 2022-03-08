//
//  CreatePostImageButtonCell.swift
//  Chiff
//
//  Created by Zakirov Tahir on 20.10.2021.
//

import UIKit
import SnapKit

class CreatePostImageButtonCell: UICollectionViewCell {
    
    // Код, над которым я плачу по ночам, вроде бы и работает, но хочу по архитектуре а спросить не у кого, хочу правильно, а не вот это вот все :(((((((
    let titleLabel = UILabel()
    var images = [UIImage]() // Храним массив изображений
    let button = UIButton()

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        button.backgroundColor = .red
        button.layer.cornerRadius = 8
        button.setTitle("Загрузить фотографию", for: .normal)
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        
        setupCollectionView()
        setupSubviews()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true // чтобы листалось
        collectionView.showsHorizontalScrollIndicator = false // горизонтальный скролл убирем
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "cell1")
    }
    
    func setupSubviews() {
        addSubview(titleLabel)
        addSubview(collectionView)
        addSubview(button)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.leading.trailing.equalTo(0)
            make.height.equalTo(20)
        }
        
        button.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.trailing.leading.equalTo(0)
            make.height.equalTo(50)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(button.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalTo(0)
            make.height.equalTo(100)
        }
    }
    
}


// MARK: - Actions
extension CreatePostImageButtonCell {
    
    func reloadCell() {
        DispatchQueue.main.async() {
            self.collectionView.reloadData()
        }
    }
}

extension CreatePostImageButtonCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! ImageCell
        cell.loadButton.isHidden = true
        cell.imageView.isHidden = false
        
        cell.imageView.image = images[indexPath.row]
        cell.imageView.layer.cornerRadius = 8
        cell.imageView.clipsToBounds = true
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: frame.height, height: frame.height)
    }
    
    
}
