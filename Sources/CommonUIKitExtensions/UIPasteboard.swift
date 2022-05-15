//
//  UIPasteBoard.swift
//  akin
//
//  Created by Scott Lydon on 2/7/20.
//  Copyright © 2020 ElevatedUnderdogs. All rights reserved.
//

import UIKit

public extension UIPasteboard {
    
    ///This is a safe alternative to UIPasteboard's string setter property.
    ///While the string property is optional, if you assign the value nil, it will crash.
    func safe(set new: String) {
        string = new
    }
    
//    ///Since the string property is a computed property, if you attempt to append to it, it won't silently fail when string returns nil, instead it will crash.
//    func safe(append new: String) {
//        if !hasStrings || string == nil {
//            safe(set: new)
//        } else {
//            string?.append(new)
//        }
//    }
}
