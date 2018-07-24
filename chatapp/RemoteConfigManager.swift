//
//  RemoteConfigManager.swift
//  chatapp
//
//  Created by Goel, Archit on 21/07/18.
//  Copyright © 2018 Goel, Archit. All rights reserved.
//

import UIKit
import FirebaseRemoteConfig

class RemoteConfigManager: NSObject {

    static var remoteConfigObj: [String: String] = [:]
    
    private enum remoteConfigValues: String {
        case loginButton
        case photoButtonUpdate
    }
    
    static func remoteConfigInit(firstControl: UIButton) {
        let remoteConfig = RemoteConfig.remoteConfig()
        
        RemoteConfigManager.remoteConfigObj[remoteConfigValues.loginButton.rawValue] = remoteConfig[remoteConfigValues.loginButton.rawValue].stringValue
        RemoteConfigManager.remoteConfigObj[remoteConfigValues.photoButtonUpdate.rawValue] = remoteConfig[remoteConfigValues.photoButtonUpdate.rawValue].stringValue
        
        
        let remoteConfigDefaults: [String: NSObject] = [
            remoteConfigValues.loginButton.rawValue : "login" as NSObject,
            remoteConfigValues.photoButtonUpdate.rawValue: "update" as NSObject
        ]
        
        RemoteConfig.remoteConfig().setDefaults(remoteConfigDefaults)
        
        let interval: TimeInterval =  10
        
        remoteConfigDebugMode()
        startFetching(interval: interval, firstControl: firstControl)
    }
    
    static func startFetching(interval: TimeInterval, firstControl: UIButton) {
        RemoteConfig.remoteConfig().fetch(withExpirationDuration: interval) { (status, error) in
            if let error = error {
                print("Error fetching remote config values \(error)")
                return
            }
            else {
                RemoteConfig.remoteConfig().activateFetched()
                print("login button value: \(RemoteConfigManager.remoteConfigObj[remoteConfigValues.loginButton.rawValue])")
                
                firstControl.setTitle(RemoteConfigManager.remoteConfigObj[remoteConfigValues.loginButton.rawValue], for: UIControlState.normal)
            }
        }
    }
    
    
    static func remoteConfigDebugMode() {
        let debugSettings = RemoteConfigSettings(developerModeEnabled: true)
        RemoteConfig.remoteConfig().configSettings = debugSettings
    }
}
