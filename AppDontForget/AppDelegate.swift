//
//  AppDelegate.swift
//  AppDontForget
//
//  Created by Prang on 12/18/2559 BE.
//  Copyright © 2559 Prang. All rights reserved.
//

import UIKit

import FirebaseAuth
import Firebase
import FirebaseInstanceID
import FirebaseMessaging
import UserNotifications



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    let gcmMessageIDKey = "gcm.message_id"
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        application.statusBarStyle = .lightContent
        FIRApp.configure()
        FIRDatabase.database().persistenceEnabled = true
        
        // Register for remote notifications
        if #available(iOS 8.0, *) {
            let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
            application.registerForRemoteNotifications()
        } else {
            // Fallback
            let types: UIRemoteNotificationType = [.alert, .badge, .sound]
            application.registerForRemoteNotifications(matching: types)
        }
        
        // Add observer for InstanceID token refresh callback.
        NotificationCenter.default.addObserver(self, selector: #selector(self.tokenRefreshNotification),
                                               name: NSNotification.Name.firInstanceIDTokenRefresh, object: nil)
        
        return true
    }
    
    
    //เอาuserเข้ามา
    func logUser(){
        if FIRAuth.auth()!.currentUser != nil {
            
            let tabBar = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Home") as! UITabBarController
            
            self.window?.rootViewController = tabBar
        }
        
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        // Sent APNs token from Apple to FCM Server
        FIRInstanceID.instanceID().setAPNSToken(deviceToken as Data, type: .sandbox) // for production use .Prod for type
    }
    
    // [START receive_message]
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    
    
    // [END receive_message]
    
    // [START refresh_token]
    func tokenRefreshNotification(notification: NSNotification) {
        if let refreshedToken = FIRInstanceID.instanceID().token() {
            print("InstanceID token: \(refreshedToken)")
            
            // Subscribe to a topic after got a FCM Registration token
            FIRMessaging.messaging().subscribe(toTopic: "/topics/coffee")
        }
        
        // Connect to FCM since connection may have failed when attempted before having a token.
        connectToFCM()
    }
    // [END refresh_token]
    
    // [START connect_to_fcm]
    func connectToFCM() {
        FIRMessaging.messaging().connect { (error) in
            if (error != nil) {
                print("Unable to connect with FCM. \(error)")
            } else {
                print("Connected to FCM.")
            }
        }
    }
    // [END connect_to_fcm]
    
    func applicationDidBecomeActive(application: UIApplication) {
        connectToFCM()
    }
    
    // [START disconnect_from_fcm]
    func applicationDidEnterBackground(application: UIApplication) {
        FIRMessaging.messaging().disconnect()
        print("Disconnected from FCM.")
    }
    // [END disconnect_from_fcm]
    
}
