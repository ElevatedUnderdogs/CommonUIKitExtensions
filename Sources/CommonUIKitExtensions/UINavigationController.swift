//
//  UINavigationController.swift
//  QRCodeTarot
//
//  Created by Scott Lydon on 4/15/22.
//

import UIKit

public extension UINavigationController {

    //    func popToFirstOf<T: UIViewController>(type: T = .init()) {
    //        guard let t: T = viewControllers.firstOfType() else { return }
    //        print(String(describing: t))
    //        var last: UIViewController? = viewControllers.last
    //        while last as? T == nil {
    //            popViewController(animated: true)
    //            last = viewControllers.last
    //        }
    //    }

    // MARk - moving view Controllers

    func safelyPopViewController(animated: Bool = true) {
        DispatchQueue.main.async {
            self.popViewController(animated: animated)
        }
    }

    func safelyPush(_ viewController: UIViewController, animated: Bool = true) {
        DispatchQueue.main.async {
            self.pushViewController(viewController, animated: animated)
        }
    }

    /// Can't import CommonExtensions for some reason.
//    func popToFirstOf<T: UIViewController>(type: T = .init()) {
//        guard let t: T = viewControllers.firstOfType() else { return }
//        print(String(describing: t))
//        var last: UIViewController? = viewControllers.last
//        while last as? T == nil {
//            popViewController(animated: true)
//            last = viewControllers.last
//        }
//    }


    /// Must be used on the main thread because viewControllers is read.
    /// - Returns: The view controller you would like to pop to.
    @discardableResult func safelyPopTo<T: UIViewController>() -> T? {
        let lastIndex = viewControllers.count - 1
        for i in 0..<viewControllers.count {
            if let viewControllerToShow = viewControllers[lastIndex - i] as? T {
                return viewControllerToShow
            } else {
                safelyPopViewController()
            }
        }
        return nil
    }

    func add(viewController: UIViewController, animated: Bool = true) {
        if viewControllers.isEmpty {
            viewControllers = [viewController]
        } else {
            safelyPush(viewController, animated: animated)
        }
    }

    func remove(_ viewController: UIViewController?) {
        DispatchQueue.main.async {
            guard let vc = viewController,
                  let index = self.viewControllers.firstIndex(of: vc) else { return }
            self.viewControllers.remove(at: index)
        }
    }

    var safelyPopViewControllerAnd: UIViewController? {
        safelyPopViewController(animated: true)
        return secondTopMostViewController
    }


    ///Lets the last one be on the top.
    func safelyPush(_ inViewControllers: [UIViewController], animated: Bool = true) {
        DispatchQueue.main.async {
            var stack = self.viewControllers
            stack.append(contentsOf: inViewControllers)
            self.setViewControllers(stack, animated: animated)
        }
    }
    
    func insertUnderTop(viewControllersToInsert: [UIViewController], animated: Bool) {
        let controllers = viewControllers
        guard !controllers.isEmpty else { return }
        let last = self.viewControllers.removeLast()
        self.viewControllers.append(contentsOf: viewControllersToInsert)
        self.viewControllers.append(last)
        self.setViewControllers(self.viewControllers, animated: animated)

    }

    func backToViewController(vc: Any) {
        for element in viewControllers where "\(type(of: element)).Type" == "\(type(of: vc))" {
            popToViewController(element, animated: true)
        }
    }

    // MARK - view controller access

    var secondTopMostViewController: UIViewController? {
        let count = viewControllers.count
        if count > 1 {
            return viewControllers[count - 2]
        } else {
            return nil
        }
    }
}
