//
//  DetailController.swift
//  Chiff
//
//  Created by Zakirov Tahir on 22.10.2021.
//

import UIKit

class DetailController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private enum Items: Int {
        case imageItem = 0
        case titleItem = 1
        case locationItem = 2
        case descriptionItem = 3
        case contactsItem = 4
        case infoAuthorItem = 5
        case similarAdsItem = 6
        case paidAdsItem = 7
    }
    
    let networkService = NetworkService()
    var idPost: Int?
    var news = News(id: 0, date: nil, dateGmt: nil, guid: nil, modified: nil, modifiedGmt: nil, slug: nil, status: nil, type: nil, link: nil, title: nil, content: nil, excerpt: nil, author: nil, featuredMedia: 0, commentStatus: nil, pingStatus: nil, sticky: nil, template: nil, format: nil, categories: nil, links: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = false
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(DetailImageCell.self, forCellWithReuseIdentifier: "cell1")
        collectionView.register(DetailNameCell.self, forCellWithReuseIdentifier: "cell2")
        collectionView.register(DetailDescCell.self, forCellWithReuseIdentifier: "cell3")
        collectionView.register(ContactCell.self, forCellWithReuseIdentifier: "cell6")
        collectionView.register(InfoAuthorCell.self, forCellWithReuseIdentifier: "cell4")
        collectionView.register(PaidAdsCell.self, forCellWithReuseIdentifier: "cell5")
        
        collectionView.backgroundColor = .systemGroupedBackground
        
        networkService.getPost(idPost: idPost!) { result in
            switch result {
            case .success(let news):
                DispatchQueue.main.async {
                    self.news = news
                    self.collectionView.reloadData()
                }
            case .failure(_):
                print("Ошибка")
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let items = Items(rawValue: indexPath.item)
        
        switch items {
        case .imageItem:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! DetailImageCell
            
            networkService.getImagesFromPosts(idPost: news.featuredMedia ?? 0) { result in
                switch result {
                case .success(let media):
                    
                    DispatchQueue.global().async {
                        guard let imageUrl = URL(string: media.guid?.rendered ?? "") else { return }
                        guard let imageData = try? Data(contentsOf: imageUrl) else { return }
                        DispatchQueue.main.async {
//                            cell.imageView.image = UIImage(data: imageData)
                        }
                    }
                    
                case .failure(let error):
                    print("Ошибка \(error.localizedDescription)")
                }
            }
            
            return cell
        case .titleItem:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! DetailNameCell
            cell.titleLabel.text = news.title?.rendered
            cell.costLabel.text = "70 000 рублей"
            return cell
        case .locationItem:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            cell.backgroundColor = .yellow
            return cell
        case .descriptionItem:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell3", for: indexPath) as! DetailDescCell
            cell.descriptionLabel.text = news.content?.rendered
            return cell
        case .contactsItem:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell6", for: indexPath) as! ContactCell
            return cell
        case .infoAuthorItem:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell4", for: indexPath) as! InfoAuthorCell
            cell.backgroundColor = .systemGray5
            cell.layer.cornerRadius = 10
            return cell
        case .similarAdsItem:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            cell.backgroundColor = .brown
            return cell
        case .paidAdsItem:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell5", for: indexPath) as! PaidAdsCell
            return cell
        case .none:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            cell.backgroundColor = .gray
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 0
        var padding: CGFloat = 0
        
        let items = Items(rawValue: indexPath.item)
        
        switch items {
        case .imageItem:
            height = 300
            padding = 0
        case .titleItem:
            height = 50
            padding = 32
        case .locationItem:
            height = 50
            padding = 32
        case .descriptionItem:
            height = 200
            padding = 32
        case .contactsItem:
            height = 40
            padding = 32
        case .infoAuthorItem:
            height = 100
            padding = 32
        case .similarAdsItem:
            height = 400
            padding = 32
        case .paidAdsItem:
            height = 300
            padding = 32
        case .none:
            height = 100
            padding = 32
        }
        
        return .init(width: view.frame.width - padding, height: height)
    }
    
    
}
