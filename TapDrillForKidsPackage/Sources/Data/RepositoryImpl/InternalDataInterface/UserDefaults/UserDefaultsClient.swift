//
//  UserDefaultsClient.swift
//  
//
//  Created by 若江照仁 on 2023/03/19.
//

import Foundation

enum UserDefaultsClient {
    static var effectVolume: Float {
        get {
            UserDefaults.standard.register(defaults: [#function: 1])
            return UserDefaults.standard.float(forKey: #function)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: #function)
        }
    }
    
    static var utteranceVolume: Float {
        get {
            UserDefaults.standard.register(defaults: [#function: 1])
            return UserDefaults.standard.float(forKey: #function)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: #function)
        }
    }
    
    static var utteranceLanguage: String {
        get {
            UserDefaults.standard.register(defaults: [#function: "system"])
            return UserDefaults.standard.string(forKey: #function) ?? "system"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: #function)
        }
    }
    
    // MARK: - Config
    static var drillPanelLeadingPadding: CGFloat {
        get {
            UserDefaults.standard.register(defaults: [#function: 0])
            return .init(UserDefaults.standard.double(forKey: #function))
        }
        set {
            UserDefaults.standard.set(newValue, forKey: #function)
        }
    }
    
    static var drillPanelTrailingPadding: CGFloat {
        get {
            UserDefaults.standard.register(defaults: [#function: 0])
            return .init(UserDefaults.standard.double(forKey: #function))
        }
        set {
            UserDefaults.standard.set(newValue, forKey: #function)
        }
    }
}
