//
//  TIFASoccerApp.swift
//  TIFASoccer
//
//  Created by Burak Dinç on 8.06.2022.
//

import SwiftUI

@main
struct TIFASoccerApp: App {
    
    // Register app delegate for Firebase setup.
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            BaseView()
        }
    }
}
