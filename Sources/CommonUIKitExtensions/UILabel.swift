//
//  UILabel.swift
//  akin
//
//  Created by Scott Lydon on 8/1/19.
//  Copyright © 2019 ElevatedUnderdogs. All rights reserved.
//

import Foundation
import UIKit

public extension UILabel {
    
    enum AlignmentStyle {
        case basic(NSTextAlignment)
        case designerAlignment
    }
    
    func appearFadeOut(text newText: NSAttributedString) {
        attributedText = newText
        alpha = 1
        UIView.animate(withDuration: 6) {
            self.alpha = 0
        }
    }
    
    // MARK - line counts
    
    var actualLineCount: Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(Float.infinity))
        let charSize = font.lineHeight
        let text = (self.text ?? "") as NSString
        let textSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font as Any], context: nil)
        let lines = Int(textSize.height/charSize)
        return lines
    }
    
    var numberOfVisibleLines: Int {
        let textSize = CGSize(width: CGFloat(self.frame.size.width), height: CGFloat(MAXFLOAT))
        let rHeight: Int = lroundf(Float(self.sizeThatFits(textSize).height))
        let charSize: Int = lroundf(Float(self.font.pointSize))
        return rHeight / charSize
    }
    
    // MARK - set alignment
    
    func alignArtistically() {
        self.setAlighnment(with: .designerAlignment)
    }
    
    func setAlighnment(with alignmentStyle: AlignmentStyle) {
        switch alignmentStyle {
        case .designerAlignment:
            textAlignment = numberOfVisibleLines <= 3 ? .center : .left
        case .basic(let alignment):
            textAlignment = alignment
        }
    }
    
    func set(text: String?, with alignmentStyle: AlignmentStyle = .designerAlignment) {
        self.text = text
        setAlighnment(with: alignmentStyle)
    }
    
    func set(attributed: NSAttributedString?, with alignmentStyle: AlignmentStyle = .designerAlignment) {
        self.attributedText = attributed
        setAlighnment(with: alignmentStyle)
    }
    
    func set(font new: UIFont?) {
        font = new?.withSize(font.pointSize)
    }

    func safelySet(text: String) {
        DispatchQueue.main.async {
            self.text = text
        }
    }

    func with(text: String) -> Self {
        self.text = text
        return self
    }

    func with(lineCount: Int) -> Self {
        self.numberOfLines = lineCount
        return self
    }

    /// Call this no more than once per UILabel instance.
    @available(iOS 11.0, *)
    func setDynamicText() {
        font = font.dynamic
        adjustsFontForContentSizeCategory = true
        setContentCompressionResistancePriority(.required, for: .horizontal)
        setContentCompressionResistancePriority(.required, for: .vertical)
    }
}
