//
//  SwiftUITutorialApp.swift
//  SwiftUITutorial
//
//  Created by Jinyung Yoon on 2021/12/01.
//

import SwiftUI

@main
struct SwiftUITutorialApp: App {
    
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
        
        #if os(watchOS)
        WKNotificationScene(controller: NotificationController.self, category: "LandmarkNear")
        #endif
    }
}
