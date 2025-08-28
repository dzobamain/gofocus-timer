//
//  GoFocus/MacosApp.swift
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
            ContentView().frame(minWidth: 800, maxWidth: .infinity, minHeight: 500, maxHeight: .infinity)
        }
    }
}
