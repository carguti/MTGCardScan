//
//  MTGCardScanApp.swift
//  MTGCardScan
//
//  Created by Carlos Gutiérrez Casado on 1/4/24.
//

import SwiftUI

@main
struct MTGCardScanApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
        }
    }
}
