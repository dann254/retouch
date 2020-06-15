//
//  AppDelegate.swift
//  retouch
//
//  Created by Daniel Kipkemei on 15/06/2020.
//  Copyright © 2020 Daniel Kipkemei. All rights reserved.
//

import Cocoa
import Foundation

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var statusBarItem: NSStatusItem!
    let process = Process()
    let menu = NSMenu()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        // Create the status item
        self.statusBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
        
        if let button = self.statusBarItem.button {
            button.image = NSImage(named: "Icon")
//            button.action = #selector(restartControlstrip(_:))
        }
        menu.addItem(NSMenuItem(title: "Refresh TouchBar", action: #selector(restartControlstrip(_:)), keyEquivalent: "r"))
        menu.addItem(NSMenuItem(title: "Quit", action: Selector("terminate:"), keyEquivalent: "q"))
        
        statusBarItem.menu = menu
    }
    
    @objc func restartControlstrip(_ sender: AnyObject?) {
        @discardableResult
        func shell(_ command: String) -> String {
            let task = Process()
            let pipe = Pipe()

            task.standardOutput = pipe
            task.arguments = ["-c", command]
            task.launchPath = "/bin/bash"
            task.launch()

            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            let output = String(data: data, encoding: .utf8)!

            return output
        }
        
        shell("pkill \"Touch Bar agent\"")
        shell("killall \"ControlStrip\"")
    }


}

