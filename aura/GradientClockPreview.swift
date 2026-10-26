//
//  GradientClockPreview.swift
//  aura
//
//  Created by Laura Calderon on 5/03/26.
//

import SwiftUI
import ScreenSaver

// Wraps the NSView-based screensaver so SwiftUI's canvas can render it live
struct GradientClockPreview: NSViewRepresentable {
    func makeNSView(context: Context) -> GradientClockView {
        // isPreview: true keeps it lightweight (same flag macOS passes in System Settings preview)
        GradientClockView(frame: .zero, isPreview: false)!
    }

    func updateNSView(_ nsView: GradientClockView, context: Context) {}
}

#Preview("GradientClock — 16:9", traits: .fixedLayout(width: 1280, height: 720)) {
    GradientClockPreview()
}

#Preview("GradientClock — Full 5K", traits: .fixedLayout(width: 1920, height: 1080)) {
    GradientClockPreview()
}
