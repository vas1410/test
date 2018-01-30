//
//  Constants.swift
//  SG_PSI
//
//  Created by v.vajiravelu on 29/1/18.
//  Copyright © 2018 vas. All rights reserved.
//

import UIKit

let defaultNotificationCenter = NotificationCenter.default
// - MARK Notification.Name
extension Notification.Name {
    
    public struct App {
        public static let GeneralErrorMessage = Notification.Name(rawValue: "app.GeneralErrorMessage")
    }

    
}

extension String {
    public struct ErrorMessages {
        public static let http500 = "Our server encountered an internal error. Please try again later."
        public static let http408 = "Our server could not respond in time. Please try again later."
    }
}
