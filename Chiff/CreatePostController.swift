//
//  CreatePostController.swift
//  Chiff
//
//  Created by admin on 19.10.2021.
//

import UIKit

class CreatePostController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private enum Items: Int {
        case titleItem = 0
        case descriptionItem = 1
        case costItem = 2
        case imageItem = 3
        case someItem = 4
        case some2Item = 5
    }
    
    let networkService = NetworkService()
    let publishPostButton = UIButton()
    let activityIndicator = UIActivityIndicatorView()
    var postCreate = CreatePostModel()
    var images = [UIImage]()
    var imagePicker: UIImagePickerController!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Делегируем работу UIImagePicker на себя
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
                        
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.keyboardDismissMode = .onDrag
        
        collectionView.register(DescriptionPostCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(TextfieldCell.self, forCellWithReuseIdentifier: "cell1")
        collectionView.register(CreatePostImageButtonCell.self, forCellWithReuseIdentifier: "cell2")
        
        publishPostButton.backgroundColor = UIColor(displayP3Red: 255, green: 0, blue: 0, alpha: 0.5)
        publishPostButton.layer.cornerRadius = 8
        publishPostButton.setTitle("Опубликовать", for: .normal)
        //        publishPostButton.isHidden = true
        // TODO Как скрыть кнопку изначально? может снизу его показать изначально?
        
        activityIndicator.style = .large
        activityIndicator.color = .black
        
        checkFilledFieldsAndEnableButton()
        
        view.addSubview(publishPostButton)
        view.addSubview(activityIndicator)
        
        publishPostButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 32, bottom: -100, right: 32), size: .init(width: 0, height: 50))
        activityIndicator.centerInSuperview()
        
   
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let items = Items(rawValue: indexPath.item)
        
        switch items {
        case .titleItem:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! TextfieldCell
            cell.titleLabel.text = "Наименование товара"
            cell.textField.placeholder = "Что вы продаете?"
            cell.textField.text = postCreate.title
            cell.textField.addTarget(self, action: #selector(titleDidChange(_:)), for: .editingChanged)
            cell.textField.delegate = self
            
            return cell
            
        case .descriptionItem:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DescriptionPostCell
            cell.titleLabel.text = "Описание товара"
            cell.textView.text = postCreate.description
            cell.textView.delegate = self
            
            return cell
            
        case .costItem:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! TextfieldCell
            cell.titleLabel.text = "Цена"
            cell.textField.placeholder = "Цена Р"
            cell.textField.text = postCreate.cost
            cell.textField.addTarget(self, action: #selector(costDidChange(_:)), for: .editingChanged)
            cell.textField.delegate = self

            return cell
            
        case .imageItem:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! CreatePostImageButtonCell
            
            cell.titleLabel.text = "Фото"
            cell.button.addTarget(self, action: #selector(loadImage), for: .touchUpInside)
            cell.images = images
            postCreate.images = images
            cell.reloadCell()
            
            return cell
            
        case .someItem:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! TextfieldCell
            
            cell.titleLabel.text = "Еще что-то"
            cell.textField.placeholder = "Еще что-то"
            cell.textField.delegate = self

            return cell
            
        case .some2Item:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! TextfieldCell
            cell.titleLabel.text = "Еще что-то"
            cell.textField.placeholder = "Еще что-то"
            cell.textField.delegate = self

            return cell
            
        case .none:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            
            return cell
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 0
        
        let items = Items(rawValue: indexPath.item)
        
        switch items {
        case .titleItem:
            height = 70
        case .descriptionItem:
            height = 200
        case .costItem:
            height = 70
        case .imageItem:
            height = 200
        case .someItem:
            height = 200
        case .some2Item:
            height = 200
        case .none:
            height = 0
        }
        
        return .init(width: view.frame.width - 32, height: height)
        
    }

    
    // Проверяем, заполнили мы все поля, и активируем кнопку.
    func checkFilledFieldsAndEnableButton() {
        publishPostButton.addTarget(self, action: #selector(goToPublish), for: .touchUpInside)
        publishPostButton.backgroundColor = UIColor(displayP3Red: 255, green: 0, blue: 0, alpha: 1)
    }
    
    
}

// Actions

extension CreatePostController {
    
    // Отправляем запрос
    @objc func goToPublish() {
        
        activityIndicator.startAnimating()
        view.isUserInteractionEnabled = false
        
        let title = postCreate.title
        let description = postCreate.description
        let cost = postCreate.cost
        postCreate.status = "publish"
                
        if title == nil || description == nil || cost == nil {
            print("LOG: данные пусты")
            self.activityIndicator.stopAnimating()
            self.view.isUserInteractionEnabled = true
            return
        }
        
//        networkService.createNewPost(post: postCreate) { result in
//            switch result {
//            case .success(_):
//                DispatchQueue.main.async {
//                    self.activityIndicator.stopAnimating()
//                    self.view.isUserInteractionEnabled = true
//                    // TODO Показать что пост был загружен в алерте,
//                    // В алерте после кнопки ОК, пересоздать пустой экран, либо перевести пользователя в объявление.
//                }
//            case .failure(let error):
//                print("LOG: ERROR CREATING POST: \(error)")
//            }
//        }
    }
    
    @objc func titleDidChange(_ textField: UITextField) {
        postCreate.title = textField.text ?? ""
    }
    
    @objc func costDidChange(_ textField: UITextField) {
        postCreate.cost = textField.text ?? ""
    }
    
    // Вызываем Алерт
    @objc func loadImage() {
        let alert = UIAlertController(title: "Загрузить изображение", message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Камера", style: .default) { _ in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        let libraryAction = UIAlertAction(title: "Галерея", style: .default) { _ in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(cameraAction)
        alert.addAction(libraryAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
}

extension CreatePostController {
    // Анимируем появление кнопки "Опубликовать", когда спускаемся вниз.
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollViewContentHeight = scrollView.contentSize.height
        let scrollViewHeight = scrollView.frame.height
        let heightTabBar = tabBarController!.tabBar.frame.size.height
        
        if scrollView.contentOffset.y < (scrollViewContentHeight - scrollViewHeight){
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                self.publishPostButton.frame.origin.y = (scrollViewHeight - 60) + heightTabBar
            }
        } else {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                self.publishPostButton.frame.origin.y = (scrollViewHeight - 60) - heightTabBar
            }
            //            publishPostButton.isHidden = false
        }
        
        // TODO Сделать проверку на пустые поля, но как без костылей,?????
        
        //        if postCreate.title == "" {
        //            print("LOG: УРААА ВСЕ ЗАПОЛНЕННО")
        //        } else {
        //            print("LOG: НЕА НЕ ЗАПОЛНЕННО")
        //        }
        
        //        if isFilledFields == [true, true, true] {
        //            print("LOG: УРААА ВСЕ ЗАПОЛНЕННО \(isFilledFields)")
        //        } else {
        //            print("LOG: НЕА НЕ ВСЕ ЗАПОЛНЕННО \(isFilledFields)")
        //        }
    }
    
}

extension CreatePostController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
//        postCreate.content = textView.text ?? ""
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = .label
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.textColor = UIColor.lightGray
        }
    }
    
}


extension CreatePostController: UITextFieldDelegate {
 
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension CreatePostController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        // Добавляем в начало массива картинку с помощью insert at: начало массива
        self.images.insert(image, at: 0)

        self.collectionView.reloadData()

        imagePicker.dismiss(animated: true) {
          
          
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
