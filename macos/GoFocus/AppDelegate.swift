//
//  macos/AppDelegate.swift
//

import SwiftUI
import AppKit

class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate
{
    func applicationDidFinishLaunching(_ notification: Notification)
    {
        if let window = NSApplication.shared.windows.first
        {
            window.setContentSize(NSSize(width: WINDOW_INITIAL_WIDTH, height: WINDOW_INITIAL_HEIGHT))
            window.title = WINDOW_TITLE
            window.center()
            
            window.delegate = self
        }
    }
}
