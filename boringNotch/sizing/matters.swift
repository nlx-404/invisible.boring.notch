    //
    //  sizeMatters.swift
    //  boringNotch
    //
    //  Created by Harsh Vardhan  Goswami  on 05/08/24.
    //

import SwiftUI
import Foundation
import Defaults

let playerWidth: CGFloat = 440

let downloadSneakSize: CGSize = .init(width: 65, height: 1)
let batterySneakSize: CGSize = .init(width: 160, height: 1)

let openNotchSize: CGSize = .init(width: 580, height: 175)
let cornerRadiusInsets:  (opened: CGFloat, closed: CGFloat) = (opened: 24, closed: 10)

struct MusicPlayerImageSizes {
    static let cornerRadiusInset: (opened: CGFloat, closed: CGFloat) = (opened: 13.0, closed: 4.0)
    static let size = (opened: CGSize(width: 90, height: 90), closed: CGSize(width: 20, height: 20))
}

func getClosedNotchSize(screen: String? = nil) -> CGSize {
    // Default notch size, to avoid using optionals
    var notchHeight: CGFloat = 0.3
    var notchWidth: CGFloat = 200
    
    var selectedScreen = NSScreen.main
    
    if let customScreen = screen {
        selectedScreen = NSScreen.screens.first(where: {$0.localizedName == customScreen})
    }
    
    // Check if the screen is available
    if let screen = selectedScreen {
        // Calculate and set the exact width of the notch
        if let topLeftNotchpadding: CGFloat = screen.auxiliaryTopLeftArea?.width,
           let topRightNotchpadding: CGFloat = screen.auxiliaryTopRightArea?.width
        {
            notchWidth = screen.frame.width - topLeftNotchpadding - topRightNotchpadding + 10
        }
        
        // Use MenuBar height as notch height if there is no notch
        if Defaults[.nonNotchHeightMode] == .matchMenuBar {
            notchHeight = screen.frame.maxY - screen.visibleFrame.maxY
        }
        
        // Check if the Mac has a notch
        if screen.safeAreaInsets.top > 0 {
            notchHeight = Defaults[.notchHeight]
            if Defaults[.notchHeightMode] == .matchRealNotchSize {
                notchHeight = screen.safeAreaInsets.top
            } else if Defaults[.notchHeightMode] == .matchMenuBar {
                notchHeight = screen.frame.maxY - screen.visibleFrame.maxY
            }
        }
        print("height", notchHeight)
    }
    
    return .init(width: notchWidth, height: notchHeight)
}
