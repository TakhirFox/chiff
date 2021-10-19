//
//  CreatePostController.swift
//  Chiff
//
//  Created by admin on 19.10.2021.
//

import UIKit

class CreatePostController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let networkService = NetworkService()
    let publishPost = UIView()
    
    private enum Items: Int {
        case titleItem = 0
        case descriptionItem = 1
        case costItem = 2
        case imageItem = 3
        case someItem = 4
        case some2Item = 5
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .systemGroupedBackground

        collectionView.register(CreatePostCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(CreatePostImageButtonCell.self, forCellWithReuseIdentifier: "cell2")
        
        publishPost.backgroundColor = .red
        publishPost.layer.cornerRadius = 8
        publishPost.isHidden = true
        
        view.addSubview(publishPost)
        
        publishPost.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 32, bottom: tabBarController!.tabBar.frame.size.height + 10, right: 32), size: .init(width: 0, height: 50))
        
//        networkService.postNewPost(title: "asddas", content: "asdads", status: "publish") { result in
//            switch result {
//
//            case .success(let post):
//                print("LOG: CREATE POST SUCCESSFUL \(post)")
//            case .failure(let error):
//                print("LOG: ERROR CREATING POST: \(error)")
//
//            }
//        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let items = Items(rawValue: indexPath.item)
        
        switch items {
        case .titleItem:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CreatePostCell
            cell.titleLabel.text = "Наименование товара"
            cell.textView.text = "Что вы продаете?"
            return cell
            
        case .descriptionItem:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CreatePostCell
            cell.titleLabel.text = "Описание товара"
            cell.textView.text = "Расскажите подробнее"
            return cell
            
        case .costItem:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CreatePostCell
            cell.titleLabel.text = "Цена"
            cell.textView.text = "Цена Р"
            return cell
            
        case .imageItem:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! CreatePostImageButtonCell
            cell.titleLabel.text = "Фото"
            
            return cell
            
        case .someItem:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CreatePostCell
            cell.titleLabel.text = "Еще что-то"
            cell.textView.text = "Еще что-то"
            return cell
            
        case .some2Item:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CreatePostCell
            cell.titleLabel.text = "Еще что-то"
            cell.textView.text = "Еще что-то"
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

extension CreatePostController {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollViewContentHeight = scrollView.contentSize.height
        let scrollViewHeight = scrollView.frame.height
        
        if scrollView.contentOffset.y < (scrollViewContentHeight - scrollViewHeight){
            publishPost.isHidden = true
        } else {
            publishPost.isHidden = false
        }
    }
}
