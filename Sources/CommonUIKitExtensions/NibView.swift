//
//  NibView.swift
//  QRCodeTarot
//
//  Created by Scott Lydon on 4/14/22.
//

import UIKit

/// NibView is provided to reuse nib initialization code.
/// When this view is initisialized, it sets the background to clear color
/// then loads and adds the nib sub class as a subview.
/// **Steps to use:**
/// 1. Create a swift file for your custom view, make your custom view a sub class of NibView like so
/// ```
/// class MyCustomView: NibView {
/// ```
/// 2.  Create a corresponding  xib file for your custom View: `⌘ n  →  View  →  Next`
/// 3.  Open your xib, select the `file owner` under `PlaceHolders` in the second most left tab,
/// then once selected, click on the identity inspector, the 4th column in the right most tab, and type
/// the name of your custom view, it should autopopulate as you type.  You do not need the view to be
/// a subclass of `MyCustomView` in the identity inspector, only the file Owner.
/// 4. MAKE SURE THE `.xib` and `.swift` name match the class declaration.
@IBDesignable open class NibView: CommonInitView {
    
    var view: UIView!

    override func commonInit() {
        backgroundColor = .clear
        guard let nibView = loadNib() else {
            // assertionfailure("Could not load the nib")
            return
        }
        view = nibView
        inject(view: view)
    }

    private func loadNib() -> UIView? {

        // INFINITE LOOP RISK:
        // If you encounter an infinite loop here, you may have set a view
        // to the the view name, instead of or in addition to as the owner
        // in interface builder.
        type(of: self).description().components(separatedBy: ".").last.flatMap {
            UINib(nibName: $0, bundle: Bundle(for: type(of: self)))
                .instantiate(withOwner: self, options: nil).first as? UIView
        }
    }
}
