//
//  NotificationService.swift
//  Notification Extension
//
//  Created by Adam Konečný on 13.03.2024.
//

import Smartsupp
import UserNotifications

/*
If you don't need to alter the content of your notifications, you can just make the NotificationService as a subclass of SmartsuppNotificationServiceExtension and don't do anyting else.
 
 https://docs.smartsupp.com/mobile-sdk/ios/communication-notifications/#add-notification-service-extension
*/

class NotificationService: UNNotificationServiceExtension {
    private var contentHandler: ((UNNotificationContent) -> Void)?
    private var bestAttemptContent: UNNotificationContent?
    
    private var contentManager: SmartsuppNotificationContentManager?
    
    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        if let contentManager = SmartsuppNotificationContentManager(request, withContentHandler: contentHandler) {
            self.contentManager = contentManager
        } else {
            self.contentHandler = contentHandler
            self.bestAttemptContent = request.content
            
            // ...
            // Do your modifications of the notification's content here
            // ...
            
            contentHandler(request.content)
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        
        if let contentManager {
            contentManager.serviceExtensionTimeWillExpire()
        } else if let content = bestAttemptContent {
            contentHandler?(content)
        }
    }

}
