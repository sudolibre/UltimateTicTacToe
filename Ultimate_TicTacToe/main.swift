//
//  main.swift
//  Ultimate_TicTacToe
//
//  Created by Jonathon Day on 1/1/17.
//  Copyright © 2017 dayj. All rights reserved.
//

import Foundation
import AppKit

private func isTestRun() -> Bool {
    return NSClassFromString("XCTest") != nil
}

private func runApplication(
    application: NSApplication = NSApplication.shared(),
    delegate: NSObject.Type?   = nil,
    bundle: Bundle?          = nil,
    nibName: String            = "MainMenu") {
    
    var topLevelObjects: NSArray?
    
    // Actual initialization of the delegate is deferred until here:
    application.delegate = delegate?.init() as? NSApplicationDelegate
    
    guard bundle != nil else {
        application.run()
        return
    }
    
    if bundle!.loadNibNamed(nibName, owner: application, topLevelObjects: nil ) {
        application.run()
    } else {
        print("An error was encountered while starting the application.")
    }
}

if isTestRun() {
    let mockDelegateClass = NSClassFromString("TestingAppDelegate") as? NSObject.Type
    runApplication(delegate: mockDelegateClass)
} else {
    runApplication(delegate: AppDelegate.self, bundle: Bundle.main)
}
