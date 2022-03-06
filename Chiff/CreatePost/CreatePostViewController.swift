//
//  CreatePostViewController.swift
//  Chiff
//
//  Created by Zakirov Tahir on 06.03.2022.
//

import UIKit
import SnapKit

protocol CreatePostViewControllerProtocol: AnyObject {
    var presenter: CreatePostPresenterProtocol? { get set }
}

class CreatePostViewController: BaseViewController, CreatePostViewControllerProtocol {
    
    private enum Items: Int {
        case titleItem = 0
        case descriptionItem = 1
        case costItem = 2
        case imageItem = 3
        case someItem = 4
        case some2Item = 5
    }
    
    var collectionView: UICollectionView!
    var post = CreatePostModel()
    var images = [UIImage]()
    var imagePicker: UIImagePickerController!
    var presenter: CreatePostPresenterProtocol?
    
    let publishPostButton: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(displayP3Red: 255, green: 0, blue: 0, alpha: 1)
        view.layer.cornerRadius = 25
        return view
    }()
    
    let publishLabelButton: UIButton = {
        let view = UIButton()
        view.setTitle("Опубликовать", for: .normal)
        return view
    }()
    
    let publishActivityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        view.alpha = 0
        return view
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        
        publishPostButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToPublish)))
        
        setupCollectionView()
        setupImagePicker()
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        view.addSubview(collectionView)
        view.addSubview(publishPostButton)
        publishPostButton.addSubview(publishLabelButton)
        publishPostButton.addSubview(publishActivityIndicator)
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        
        publishPostButton.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.bottom.equalTo(-100)
            make.centerX.equalTo(self.view.snp.centerX)
        }
        
        publishLabelButton.snp.makeConstraints { make in
            make.center.equalTo(self.publishPostButton.snp.center)
        }
        
        publishActivityIndicator.snp.makeConstraints { make in
            make.center.equalTo(self.publishPostButton.snp.center)
        }
        
    }
    
    func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.keyboardDismissMode = .onDrag
        collectionView.register(CreatePostCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(TextfieldCell.self, forCellWithReuseIdentifier: "cell1")
        collectionView.register(CreatePostImageButtonCell.self, forCellWithReuseIdentifier: "cell2")
    }
    
    func setupImagePicker() {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
    }
    
}

extension CreatePostViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let items = Items(rawValue: indexPath.item)
        
        switch items {
        case .titleItem:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! TextfieldCell
            cell.titleLabel.text = "Наименование товара"
            cell.textField.placeholder = "Что вы продаете?"
            cell.textField.text = post.title
            cell.textField.addTarget(self, action: #selector(titleDidChange(_:)), for: .editingChanged)
            cell.textField.delegate = self
            
            return cell
            
        case .descriptionItem:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CreatePostCell
            cell.titleLabel.text = "Описание товара"
            cell.textView.text = post.content
            cell.textView.delegate = self
            
            return cell
            
        case .costItem:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! TextfieldCell
            cell.titleLabel.text = "Цена"
            cell.textField.placeholder = "Цена Р"
            cell.textField.text = post.cost
            cell.textField.addTarget(self, action: #selector(costDidChange(_:)), for: .editingChanged)
            cell.textField.delegate = self

            return cell
            
        case .imageItem:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! CreatePostImageButtonCell
            
            cell.titleLabel.text = "Фото"
            cell.button.addTarget(self, action: #selector(loadImage), for: .touchUpInside)
            cell.images = images
            post.images = images
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
    
   
}

extension CreatePostViewController: UITextViewDelegate, UITextFieldDelegate {
    func textViewDidChange(_ textView: UITextView) {
        post.content = textView.text ?? ""
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

extension CreatePostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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

// Actions
extension CreatePostViewController {
    // Отправляем запрос
    @objc func goToPublish(_ sender: UITapGestureRecognizer) {
        view.isUserInteractionEnabled = false
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            self.collectionView.alpha = 0.5
            self.publishLabelButton.alpha = 0
            self.publishActivityIndicator.startAnimating()
            self.publishActivityIndicator.alpha = 1
            
            self.publishPostButton.snp.updateConstraints { make in
                make.width.equalTo(50)
                make.bottom.equalTo(-300)
            }

            self.view.layoutIfNeeded()
        }
        
//        activityIndicator.startAnimating()
//        view.isUserInteractionEnabled = false
//
//        let title = post.title
//        let description = post.content
//        let cost = post.cost
//        post.status = "publish"
//
//        if title == nil || description == nil || cost == nil {
//            print("LOG: данные пусты")
//            self.activityIndicator.stopAnimating()
//            self.view.isUserInteractionEnabled = true
//            return
//        }
        
//        networkService.createNewPost(post: post) { result in
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
        post.title = textField.text ?? ""
    }
    
    @objc func costDidChange(_ textField: UITextField) {
        post.cost = textField.text ?? ""
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
    
    
    
    // Анимируем появление кнопки "Опубликовать", когда спускаемся вниз.
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollViewContentHeight = scrollView.contentSize.height
        let scrollViewHeight = scrollView.frame.height
        let heightTabBar = tabBarController!.tabBar.frame.size.height
        
        if scrollView.contentOffset.y < (scrollViewContentHeight - scrollViewHeight){
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                
                self.publishPostButton.snp.updateConstraints { make in
//                    make.leading.trailing.equalTo(self.view.frame.width).inset(16)
                    make.bottom.equalTo(100)
                }
                
                self.view.layoutIfNeeded()
            }
        } else {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                self.publishPostButton.snp.updateConstraints { make in
//                    make.leading.trailing.equalTo(self.view.frame.width).inset(16)
                    make.bottom.equalTo(-100)
                }
                
                self.view.layoutIfNeeded()
                
            }
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

// Implemented CreatePostViewControllerProtocol
extension CreatePostViewController {
    
}
