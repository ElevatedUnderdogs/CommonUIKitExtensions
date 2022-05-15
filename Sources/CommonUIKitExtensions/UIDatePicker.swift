//
//  UIDatePicker.swift
//  akin
//
//  Created by Scott Lydon on 8/1/19.
//  Copyright © 2019 ElevatedUnderdogs. All rights reserved.
//

import UIKit

public extension UIDatePicker {
    
    func hideSelectionIndicator() {
        for i in [1, 2] {
            self.subviews[i].isHidden = true
        }
    }
}
