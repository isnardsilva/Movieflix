//
//  DeviceInfo.swift
//  Movieflix
//
//  Created by Isnard Silva on 20/12/20.
//

import Foundation

class DeviceInfo {
    // MARK: - Singleton
    static let shared = DeviceInfo()

    // MARK: - Initialization
    private init() { }
    
    // MARK: - Info Methods
    func getLanguage() -> String {
        return Locale.preferredLanguages[0]
    }
}
