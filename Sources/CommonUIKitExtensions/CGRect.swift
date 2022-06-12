//
//  File.swift
//  
//
//  Created by Scott Lydon on 6/12/22.
//

import UIKit

extension CGRect {
    func increasedWidth(by amount: CGFloat) -> CGRect {
        .init(
            x: self.minX,
            y: self.minY,
            width: self.width + amount,
            height: self.height
        )
    }
}
