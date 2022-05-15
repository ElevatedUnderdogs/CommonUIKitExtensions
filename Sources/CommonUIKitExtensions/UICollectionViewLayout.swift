//
//  UICollectionViewLayout.swift
//  QRCodeTarot
//
//  Created by Scott Lydon on 5/4/22.
//

import UIKit

public extension UICollectionViewLayout {

    var asFlowLayout: UICollectionViewFlowLayout? {
        self as? UICollectionViewFlowLayout
    }

    var isPortrait: Bool {
        collectionView!.frame.height > collectionView!.frame.width
    }
}
