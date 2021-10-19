//
//  CreatePostController.swift
//  Chiff
//
//  Created by admin on 19.10.2021.
//

import UIKit

class CreatePostController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let networkService = NetworkService()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white

        collectionView.register(CreatePostCell.self, forCellWithReuseIdentifier: "cell")
        
        networkService.postNewPost(title: "jlkjkljkljkl", content: "kdkdkdk", status: "publish") { result in
            switch result {
            
            case .success(let post):
                print("LOG: CREATE POST SUCCESSFUL \(post)")
            case .failure(let error):
                print("LOG: ERROR CREATING POST: \(error)")
                
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CreatePostCell
                
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 32, height: 100)
    }
    
}
