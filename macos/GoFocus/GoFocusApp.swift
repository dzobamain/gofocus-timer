//
//  macos/MacosApp.swift
//

import SwiftUI

@main
struct GoFocusApp: App
{
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene
    {
        WindowGroup
        {
            ContentView()
        }
    }
}
