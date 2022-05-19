//
//  File.swift
//  
//
//  Created by Scott Lydon on 5/18/22.
//

import UIKit

extension NSMutableAttributedString {

    /// Sets the whole color. 
    func set(color: UIColor) {
        addAttribute(.foregroundColor, value: color, range: NSRange(string.startIndex..., in: string))
    }
}
