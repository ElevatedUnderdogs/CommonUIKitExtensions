//
//  UIViewController.swift
//  akin
//
//  Created by Scott Lydon on 8/1/19.
//  Copyright © 2019 ElevatedUnderdogs. All rights reserved.
//

import Foundation
import UIKit

public typealias ViewControllerAction = (UIViewController) -> Void
public typealias Action = () -> Void

public extension UIViewController {

    // MARK - computed property
    
    func the(_ firstView: UIView?,  isAbove second: UIView?) -> Bool {
        guard let cellArrowPoint = firstView?.frame.origin,
            let vcHolderPoint = second?.frame.origin,
            let cellArrowPointinView = firstView?.convert(cellArrowPoint, to: view),
            let vcHolderPointinView = second?.convert(vcHolderPoint, to: view) else { return false }
        var top: CGFloat = 0
        if #available(iOS 11.0, *),
            let safeAreaTopHeight = UIApplication.shared.keyWindow?.safeAreaInsets.top {
            top = safeAreaTopHeight
        }
        return cellArrowPointinView.y < vcHolderPointinView.y - top
    }
    
    static var showedBadConnection: Bool = false
    
    var isVisible: Bool {
        return viewIfLoaded?.window != nil
    }
    
    static var storyboardID: String {
        return String(describing: self)
    }
    
    var topMostViewController: UIViewController {
        if let presentedViewController = self.presentedViewController {
            return presentedViewController.topMostViewController
        } else {
            for view in self.view.subviews where view.next is UIViewController {
                return (view.next as? UIViewController)?.topMostViewController ?? self
            }
            return self
        }
    }
    
    // MARK - lock
    
    func synced(_ lock: Any, closure: Action) {
        objc_sync_enter(lock)
        closure()
        objc_sync_exit(lock)
    }
    
    // MARK - navigation
    
    func safelyPerformSegue(with identifier: String, sender: Any?) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: identifier, sender: sender)
        }
    }

    func safelyDissmiss(animated flag: Bool = true, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            self.dismiss(animated: flag, completion: completion)
        }
    }
    
    func safelyPresent(_ viewController: UIViewController, animated: Bool = true, completion: Action? = nil) {
        DispatchQueue.main.async {
            self.present(viewController, animated: animated, completion: completion)
        }
    }
}

// local

public extension UIViewController {
    
    // MARK -  alert
    
//    func safelyAlert(with alertContents: AlertViewController<Any>.Contents) {
//        safelyAlert(
//            controllerTitle: alertContents.title,
//            message: alertContents.message,
//            actionTitle: alertContents.confirmationButtonText,
//            style: .default
//        )
//    }
    
//    func safelyGenericErrorAlert() {
//        safelyAlert(
//            controllerTitle: "Oops",
//            message: "Some@objc @objc thing went wrong.  We will work to fix it.",
//            actionTitle: "Ok.",
//            style: .default
//        )
//    }
    
//    func safelyAlert(
//        controllerTitle: String,
//        message: String,
//        actionTitle: String,
//        style: UIAlertAction.Style,
//        actionClosure: Action? = nil,
//        actionTitle2: String? = nil,
//        action2: Action? = nil
//        ) {
//        guard !AkinCommon.shared.isPresentingAnAlert else { return }
//        DispatchQueue.main.async {
//            let alertViewController = AlertViewController<Any>()
//            let models = [UIButton.SimpleModel(title: actionTitle, action: actionClosure)]
//            let new = models.appendIfNonNil(title: actionTitle2, action: action2)
//            
//            alertViewController.styleRegular(regularContentsModel: RegularContentsView.Model(title: controllerTitle, message: message), models: new)
//            AkinCommon.shared.isPresentingAnAlert = true
//            self.topMostViewController.safelyPresent(alertViewController) {
//                AkinCommon.shared.isPresentingAnAlert = false
//            }
//            
//        }
//    }
//    
//    func safelyPresentAlertWithCheck(_ viewControllerToPresent: UIViewController, completion: Action? = nil) {
//        guard !AkinCommon.shared.isPresentingAnAlert else { return }
//        AkinCommon.shared.isPresentingAnAlert = true
//        present(viewControllerToPresent, animated: false) {
//            AkinCommon.shared.isPresentingAnAlert = false
//            completion?()
//        }
//    }
}
