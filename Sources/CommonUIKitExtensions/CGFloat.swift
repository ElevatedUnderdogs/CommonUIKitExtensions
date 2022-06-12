//
//  File.swift
//  
//
//  Created by Scott Lydon on 6/12/22.
//

import UIKit

extension CGFloat {

    func minus(_ number: Self) -> Self {
        self - number
    }

    func divided(by denominator: Self) -> Self {
        self / denominator
    }

    var square: CGSize {
        CGSize(width: self, height: self)
    }
}
