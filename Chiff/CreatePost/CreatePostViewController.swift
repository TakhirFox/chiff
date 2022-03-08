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
        
    func setCategories(cat: [Categories])
    func showTitleIsEmpty()
    func showCategoryIsEmpty()
    func showCostIsEmpty()
    func showDescriptionIsEmpty()
    
    func showCategoriesError(error: String)
    func showStartLoadAnimating()
    func showCreatePostSuccess(_ idPost: Int)
    func showCreatePostError(_ error: String)
}

class CreatePostViewController: BaseViewController, CreatePostViewControllerProtocol {
    
    private enum Items: Int {
        case titleItem = 0
        case categoryItem = 1
        case costItem = 2
        case descriptionItem = 3
        case imageItem = 4
    }
    
    var post = CreatePostModel()
    var images = [UIImage]()
    var categories: [Categories] = []
    
    var collectionView: UICollectionView!
    var imagePicker: UIImagePickerController!
    var pickerView: UIPickerView!
    
    var presenter: CreatePostPresenterProtocol?
    
    let publishPostView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(displayP3Red: 255, green: 0, blue: 0, alpha: 1)
        view.layer.cornerRadius = 25
        return view
    }()
    
    let publishWindowView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(displayP3Red: 255, green: 255, blue: 255, alpha: 1)
        view.layer.cornerRadius = 25
        view.alpha = 0
        return view
    }()
    
    let publishMessageLabel: UILabel = {
        let view = UILabel()
        view.text = "Разное"
        view.textAlignment = .center
        view.font = .boldSystemFont(ofSize: 22)
        view.numberOfLines = 0
        view.alpha = 0
        view.textColor = .black
        return view
    }()
    
    let publishLabelButton: UIButton = {
        let view = UIButton()
        view.setTitle("Опубликовать", for: .normal)
        view.addTarget(self, action: #selector(goToPublishAction), for: .touchUpInside)
        return view
    }()
    
    let publishNewButton: UIButton = {
        let view = UIButton()
        view.setTitle("Добавить еще", for: .normal)
        view.alpha = 0
        view.backgroundColor = UIColor(displayP3Red: 255, green: 0, blue: 0, alpha: 1)
        view.layer.cornerRadius = 8
        view.addTarget(self, action: #selector(createNewPostAction), for: .touchUpInside)
        return view
    }()
    
    let publishShowPostButton: UIButton = {
        let view = UIButton()
        view.setTitle("Посмореть объявление", for: .normal)
        view.alpha = 0
        view.backgroundColor = UIColor(displayP3Red: 255, green: 0, blue: 0, alpha: 1)
        view.layer.cornerRadius = 8
        view.addTarget(self, action: #selector(showPostAction), for: .touchUpInside)
        return view
    }()
    
    let publishActivityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        view.alpha = 0
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.getCategories()
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
                
        setupCollectionView()
        setupImagePicker()
        setupSubviews()
        setupConstraints()
        
        pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    func setupSubviews() {
        view.addSubview(collectionView)
        view.addSubview(publishPostView)
        publishPostView.addSubview(publishLabelButton)
        publishPostView.addSubview(publishActivityIndicator)
        publishPostView.addSubview(publishWindowView)
        publishPostView.addSubview(publishMessageLabel)
        publishPostView.addSubview(publishNewButton)
        publishPostView.addSubview(publishShowPostButton)
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        
        publishPostView.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.bottom.equalTo(-100)
            make.centerX.equalTo(self.view.snp.centerX)
        }
        
        publishLabelButton.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(0)
        }
        
        publishActivityIndicator.snp.makeConstraints { make in
            make.center.equalTo(self.publishPostView.snp.center)
        }
        
        publishWindowView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview().inset(4)
        }
        
        publishMessageLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self.publishWindowView).offset(16)
            make.top.equalTo(self.publishWindowView).offset(16)
            make.height.equalTo(100)
        }
        
        publishNewButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self.publishPostView).inset(16)
            make.top.equalTo(self.publishMessageLabel.snp.bottom).offset(16)
            make.height.equalTo(50)
        }
        
        publishShowPostButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self.publishPostView).inset(16)
            make.top.equalTo(self.publishNewButton.snp.bottom).offset(16)
            make.height.equalTo(50)
        }
    }
    
    func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.keyboardDismissMode = .onDrag
        collectionView.register(DescriptionPostCell.self, forCellWithReuseIdentifier: "cell")
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
            cell.textField.addTarget(self, action: #selector(titleDidChange(_:)), for: .editingChanged)
            cell.textField.delegate = self
            return cell
            
            
        case .categoryItem:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! TextfieldCell
            cell.titleLabel.text = "Категории"
//            cell.textField.text = "\(post.category)"
            cell.textField.inputView = pickerView
            cell.textField.delegate = self
            return cell
            
        case .costItem:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! TextfieldCell
            cell.titleLabel.text = "Цена"
            cell.textField.addTarget(self, action: #selector(costDidChange(_:)), for: .editingChanged)
            cell.textField.delegate = self
            return cell
            
        case .descriptionItem:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DescriptionPostCell
            cell.titleLabel.text = "Описание товара"
            cell.textView.delegate = self
            return cell
            
        case .imageItem:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! CreatePostImageButtonCell
            
            cell.titleLabel.text = "Фото"
            cell.button.addTarget(self, action: #selector(loadImage), for: .touchUpInside)
            cell.images = images
            post.images = images
            cell.reloadCell()
            
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
        case .categoryItem:
            height = 70
        case .costItem:
            height = 70
        case .descriptionItem:
            height = 400
        case .imageItem:
            height = 300
        case .none:
            height = 0
        }
        
        return .init(width: view.frame.width - 32, height: height)
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

        imagePicker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
}

extension CreatePostViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        post.category = categories[row].id
    }
    
}

extension CreatePostViewController: UITextViewDelegate, UITextFieldDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView.text != nil {
            post.description = textView.text
        }
    }
    
}

// Actions
extension CreatePostViewController {
    
    @objc func goToPublishAction(_ sender: UITapGestureRecognizer) {
        presenter?.checkTextFieldEmpty(post: post)
    }
    
    @objc func createNewPostAction(_ sender: UITapGestureRecognizer) {

    }
    
    @objc func showPostAction(_ sender: UITapGestureRecognizer) {

    }
    
    @objc func titleDidChange(_ textField: UITextField) {
        if textField.text != nil {
            post.title = textField.text
        }
    }
    
    @objc func costDidChange(_ textField: UITextField) {
        if textField.text != nil {
            post.cost = textField.text
        }
    }
    
    @objc func descriprionDidChange(_ textField: UITextField) {
        if textField.text != nil {
            post.description = textField.text
        }
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
                
                self.publishPostView.snp.updateConstraints { make in
                    make.bottom.equalTo(100)
                }
                
                self.view.layoutIfNeeded()
            }
        } else {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                self.publishPostView.snp.updateConstraints { make in
                    make.bottom.equalTo(-100)
                }
                
                self.view.layoutIfNeeded()
                
            }
        }
    }
    
}

// Implemented CreatePostViewControllerProtocol
extension CreatePostViewController {
    func setCategories(cat: [Categories]) {
        DispatchQueue.main.async {
            self.categories = cat
            self.collectionView.reloadData()
            self.collectionView.isHidden = false
            self.activityIndicator.stopAnimating()
        }
    }
    
    func showStartLoadAnimating() {
        view.isUserInteractionEnabled = false
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            self.collectionView.alpha = 0.5
            self.publishLabelButton.alpha = 0
            self.publishActivityIndicator.startAnimating()
            self.publishActivityIndicator.alpha = 1
            
            self.publishPostView.snp.updateConstraints { make in
                make.width.equalTo(50)
                make.bottom.equalTo(-self.view.frame.height / 2)
            }

            self.view.layoutIfNeeded()
        }
    }
    
    func showCreatePostSuccess(_ idPost: Int) {
        DispatchQueue.main.async {
            self.view.isUserInteractionEnabled = true
            self.collectionView.isScrollEnabled = false
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                self.publishMessageLabel.text = "🥳 \n Поздравляем. Объявление доступно всем "
                self.publishMessageLabel.alpha = 1
                self.publishWindowView.alpha = 1
                self.publishNewButton.alpha = 1
                self.publishShowPostButton.alpha = 1
                self.publishActivityIndicator.stopAnimating()
                
                self.publishPostView.snp.updateConstraints { make in
                    make.width.equalTo(self.view.frame.width - 32)
                    make.height.equalTo(300)
                    make.bottom.equalTo(-self.view.frame.height / 2.5)
                }

                self.view.layoutIfNeeded()
            }
        }
    }
    
    func showCreatePostError(_ error: String) {
        DispatchQueue.main.async {
            self.view.isUserInteractionEnabled = true
            self.collectionView.isScrollEnabled = false
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                self.publishMessageLabel.alpha = 1
                self.publishActivityIndicator.stopAnimating()
                
                self.publishPostView.snp.updateConstraints { make in
                    make.width.equalTo(self.view.frame.width - 32)
                    make.height.equalTo(200)
                    make.bottom.equalTo(-self.view.frame.height / 2.5)
                }

                self.view.layoutIfNeeded()
            }
        }
    }
    
    func showCategoriesError(error: String) {
        DispatchQueue.main.async {
            print("LOG: ОШИБКА КАТЕГОРИИ ВЬЮ: \(error)")
        }
    }
    
    func showTitleIsEmpty() {
        print("LOG: НЕ ЗАПОЛНЕНО ПОЛЕ НАЗВАНИЕ")
    }
    
    func showCategoryIsEmpty() {
        print("LOG: НЕ ЗАПОЛНЕНО ПОЛЕ КАТЕГОРИЯ")
    }
    
    func showCostIsEmpty() {
        print("LOG: НЕ ЗАПОЛНЕНО ПОЛЕ ЦЕНА")
    }
    
    func showDescriptionIsEmpty() {
        print("LOG: НЕ ЗАПОЛНЕНО ПОЛЕ ОПИСАНИЕ")
    }
    
}
