//
//  UIApplication.swift
//  akin
//
//  Created by Scott Lydon on 8/1/19.
//  Copyright © 2019 ElevatedUnderdogs. All rights reserved.
//

import UIKit
import PushKit


public extension UIApplication.State {
    var isNotActive: Bool {
        return self != .active
    }
}

public extension UIApplication {
    
    func open(url: URL) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    ///3 places this is called: login, startup, and after giving permission.
    /// Requiring this user id ensures that it is not nil even though it is not expressly used in the function.
    @available(iOS 10.0, *)
    static func registerAPNSIfAuthorized(
        thisUserID: Int,
        notificationCenter: UNUserNotificationCenter = UNUserNotificationCenter.current()
    )  {
        notificationCenter.getNotificationSettings { settings in
            guard settings.authorizationStatus == .authorized else {
                return
            }
            DispatchQueue.main.async {
                UIApplication.finalRegisterForAPNS()
            }
        }
    }
    
    static func finalRegisterForAPNS() {
        UIApplication.shared.registerForRemoteNotifications()
        guard #available(iOS 10.0, *) else {
            UIApplication.shared.registerUserNotificationSettings(
                UIUserNotificationSettings(types: [.sound, .alert, .badge], categories: nil)
            )
            return
        }
    }
    
    @available(iOS 10.0, *)
    func deeplinkToSettings() {
        guard let appSettings = URL(string: UIApplication.openSettingsURLString) else { return }
        open(appSettings)
    }
    
    static var topMostViewController: UIViewController? {
        var topController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController
        while topController?.presentedViewController != nil {
            topController = topController?.presentedViewController
        }
        if topController == nil {

        }
        return topController
    }
}
