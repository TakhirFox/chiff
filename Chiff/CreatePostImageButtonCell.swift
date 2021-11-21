//
//  CreatePostImageButtonCell.swift
//  Chiff
//
//  Created by Zakirov Tahir on 20.10.2021.
//

import UIKit

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
        
        // Тут думаю и так понятно
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true // чтобы листалось
        collectionView.showsHorizontalScrollIndicator = false // горизонтальный скролл убирем
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "cell1")
        
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        
        addSubview(titleLabel)
        addSubview(collectionView)
        addSubview(button)
        
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 20))
        collectionView.anchor(top: titleLabel.bottomAnchor, leading: button.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, size: .init(width: 0, height: 0))
        button.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: collectionView.leadingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 100, height: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK: - Actions
extension CreatePostImageButtonCell {
    
    func reloadCell() {
        DispatchQueue.main.async() {
            print("XXXASSXSXSX \(self.images)")
            self.collectionView.reloadData()
        }
    }
}

extension CreatePostImageButtonCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Тут загруженные картинки
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
