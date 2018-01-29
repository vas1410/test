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
    /// Used as a namespace for all `app` related notifications.
    public struct App {
        public static let AppNeedUpdate = Notification.Name(rawValue: "app.AppNeedUpdate")
        public static let DidLogin = Notification.Name(rawValue: "app.DidLogin")
        public static let DidLogout = Notification.Name(rawValue: "app.DidLogout")
        public static let GeneralErrorMessage = Notification.Name(rawValue: "app.GeneralErrorMessage")
        public static let HasNewVersion = Notification.Name(rawValue: "app.HasNewVersion")
        public static let NetworkStatusChanged = Notification.Name(rawValue: "app.NetworkStatusChanged")
    }
    
    public struct User{
        public static let AvataDidChanged = Notification.Name(rawValue: "user.AvataDidChanged")
        public static let ProfileInfoChanged = Notification.Name(rawValue: "user.ProfileInfoChanged")
        public static let UserStatusChanged = Notification.Name(rawValue: "user.StatusChanged")
        public static let CompanyStatusChanged = Notification.Name(rawValue: "user.CompanyStatus")
    }
    
    public struct Chartering{
        public static let AvataDidChanged = Notification.Name(rawValue: "chartering.VesselDetailsChanged")
    }
    
    public struct Chat {
        
        public static let Connect = Notification.Name(rawValue: "chat.Connect")
        public static let DisConnect = Notification.Name(rawValue: "chat.disConnect")
        public static let LoginOK = Notification.Name(rawValue: "chat.login")
        
        public static let GetChatMessages = Notification.Name(rawValue: "GetChatMessages")
        public static let GetConversationList = Notification.Name(rawValue: "GetConversationList")
        public static let SendChatMessage = Notification.Name(rawValue: "SendChatMessage")
        public static let GetUnReadNoForTransactionId = Notification.Name(rawValue: "GetUnReadNoForTransactionId")
        public static let ProgressChanged = Notification.Name(rawValue: "ProgressChanged")
        
        
        public static let ChatErrorMessages = Notification.Name(rawValue: "chat.ErrorMessages")
        public static let LogicError = Notification.Name(rawValue: "chat.LogicError")
    }
}

extension String {
    public struct ErrorMessages {
        public static let http500 = "Our server encountered an internal error. Please try again later."
        public static let http408 = "Our server could not respond in time. Please try again later."
    }
}
