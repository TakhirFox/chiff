//
//  SplashAnimationView.swift
//  Chiff
//
//  Created by Zakirov Tahir on 17.10.2021.
//

import UIKit
import SwiftyGif

class SplashAnimationView: UIView {
    let logoGifImageView: UIImageView = {
            guard let gifImage = try? UIImage(gifName: "logoAnim.gif") else {
                return UIImageView()
            }
            return UIImageView(gifImage: gifImage, loopCount: 1)
        }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    
    private func commonInit() {
        backgroundColor = UIColor(white: 246.0 / 255.0, alpha: 1)
        addSubview(logoGifImageView)
        logoGifImageView.translatesAutoresizingMaskIntoConstraints = false
        logoGifImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        logoGifImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        logoGifImageView.widthAnchor.constraint(equalToConstant: 280).isActive = true
        logoGifImageView.heightAnchor.constraint(equalToConstant: 108).isActive = true
    }
}


