//
//  UIStackView.swift
//  akin
//
//  Created by Scott Lydon on 8/1/19.
//  Copyright © 2019 ElevatedUnderdogs. All rights reserved.
//

import Foundation
import UIKit

public extension UIStackView {
    func addArrangedSubViews(_ views: UIView...) {
        views.forEach { addArrangedSubview($0) }
    }
    
    func addArrangedSubViews(_ views: [UIView]) {
        views.forEach { addArrangedSubview($0) }
    }
    
    func removeAllArrangedSubViews() {
        let subviews = arrangedSubviews
        removeArrangedSubViews(subviews)
    }
    
    func removeArrangedSubViews(_ views: [UIView]) {
        views.forEach { self.removeArrangedSubview($0) }
    }
}
