//
//  FeedController.swift
//  Chiff
//
//  Created by Zakirov Tahir on 06.04.2021.
//

import UIKit

class FeedController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    var news: [News] = []
    var auth: Auth?
    var networkService = NetworkService()
    var login: String?
    var password: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        
        networkService.getAuth(login: "winzero", password: "zasazasa") { (auth) in
            
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.auth = auth
            }
            
        }
   
        configureUI()
        
    }
    
    fileprivate func configureUI() {
        collectionView.backgroundColor = UIColor.gray
        collectionView.layer.cornerRadius = 20
        collectionView.layer.masksToBounds = true
        collectionView.layer.borderColor = UIColor.black.cgColor
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FeedCell
        cell.label.text = auth?.user_display_name
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 20, height: 400)
    }
    
    
    
}
