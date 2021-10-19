//
//  UITextView+Layout.swift
//  Chiff
//
//  Created by Zakirov Tahir on 19.10.2021.
//

import UIKit

extension UITextView {
    func adjustUITextViewHeight() {
        self.translatesAutoresizingMaskIntoConstraints = true
        self.sizeToFit()
        self.isScrollEnabled = false
    }
}
