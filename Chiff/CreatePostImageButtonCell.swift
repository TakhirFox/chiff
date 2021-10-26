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
    var imagePicker: UIImagePickerController!
    weak var viewController: UIViewController? // Как то нужно было презентить алерт)
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Делегируем работу UIImagePicker на себя
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        // Тут думаю и так понятно
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true // чтобы листалось
        collectionView.showsHorizontalScrollIndicator = false // горизонтальный скролл убирем
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "cell1")
        
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        
        addSubview(titleLabel)
        addSubview(collectionView)
        
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 20))
        collectionView.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, size: .init(width: 0, height: 0))

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK: - Actions
extension CreatePostImageButtonCell {
    
    // Вызываем Алерт
    @objc func loadImage() {
        let alert = UIAlertController(title: "Загрузить изображение", message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Камера", style: .default) { _ in
            self.imagePicker.sourceType = .camera
            self.viewController?.present(self.imagePicker, animated: true, completion: nil)
        }
        let libraryAction = UIAlertAction(title: "Галерея", style: .default) { _ in
            self.imagePicker.sourceType = .photoLibrary
            self.viewController?.present(self.imagePicker, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(cameraAction)
        alert.addAction(libraryAction)
        alert.addAction(cancelAction)
        self.viewController?.present(alert, animated: true, completion: nil)
    }
}

extension CreatePostImageButtonCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return images.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            // Тут одна кнопка для загрузки картинки
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! ImageCell
            cell.loadButton.isHidden = false
            cell.imageView.isHidden = true
            
            cell.loadButton.backgroundColor = .systemBlue
            cell.loadButton.addTarget(self, action: #selector(loadImage), for: .touchUpInside)
            
            
            cell.loadButton.layer.cornerRadius = 8
            cell.loadButton.clipsToBounds = true
            return cell
        } else {
            // Тут загруженные картинки
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! ImageCell
            cell.loadButton.isHidden = true
            cell.imageView.isHidden = false
            
            cell.imageView.image = images[indexPath.row]
            cell.imageView.layer.cornerRadius = 8
            cell.imageView.clipsToBounds = true
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: frame.height, height: frame.height)
    }
    
    
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension CreatePostImageButtonCell: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        // Добавляем в начало массива картинку с помощью insert at: начало массива
        self.images.insert(image, at: 0)

        collectionView.reloadData()
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
