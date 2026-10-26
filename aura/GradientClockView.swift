//
//  GradientClockView.swift
//  aura
//
//  Created by Laura Calderon on 5/03/26.
//
 
import ScreenSaver
import AppKit
 
private func srgb(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> NSColor {
    NSColor(srgbRed: r / 255, green: g / 255, blue: b / 255, alpha: 1)
}
 
class GradientClockView: ScreenSaverView {
    
    // MARK: - Prefs keys
    private let kAutoTheme  = "aura_autoTheme"
    private let kThemeIndex = "aura_themeIndex"
    private let kShowClock  = "aura_showClock"
    
    // MARK: - Theme
    private struct Theme {
        let name: String
        let colors: [NSColor]
        let timeFontName: String
        let dateFontName: String
    }
    
    private let themes: [Theme] = [
        Theme(
            name: "Pink Orchid", //0
            colors: [
                srgb(22, 0, 9),
                srgb(152, 0, 152),
                srgb(255, 210, 251)
            ],
            timeFontName: "Outfit-Bold",
            dateFontName: "InstrumentSerif-Regular"
        ),
        Theme(
            name: "Blues", //1
            colors: [
                srgb(4, 0, 53),//edge
                srgb(56, 165, 255),//middle
                srgb(40, 255, 229) //center
            ],
            timeFontName: "Outfit-Bold",
            dateFontName: "InstrumentSerif-Regular"
        ),
        Theme(
            name: "Nebula", //2
            colors: [
                srgb(31, 0, 59),//edge
                srgb(122, 0, 180),//middle
                srgb(254, 177, 255) //center
            ],
            timeFontName: "Outfit-Bold",
            dateFontName: "InstrumentSerif-Regular"
        ),
        Theme(
            name: "Aqua", //3
            colors: [
                srgb(0, 31, 37),//edge
                srgb(0, 127, 129),//middle
                srgb(30, 222, 209) //center
            ],
            timeFontName: "Outfit-Bold",
            dateFontName: "InstrumentSerif-Regular"
        ),
        
        // 5. Orange
        Theme(
            name: "Magma", //4
            colors: [
                srgb(72, 12, 0),//edge
                srgb(255, 66, 0),//middle
                srgb(255, 169, 95) //center
            ],
            timeFontName: "Outfit-Bold",
            dateFontName: "InstrumentSerif-Regular"
        ),
        
        // 6. Sage green
        Theme(
            name: "Matcha", //5
            colors: [
                srgb(0, 47, 4),//edge
                srgb(112, 137, 46),//middle
                srgb(198, 233, 159) //center
            ],
            timeFontName: "Outfit-Bold",
            dateFontName: "InstrumentSerif-Regular"
        ),
        // 7. Brown
        Theme(
            name: "Coffee", //6
            colors: [
                srgb(38, 15, 5),//edge
                srgb(85, 44, 27),//middle
                srgb(205, 180, 158) //center
            ],
            timeFontName: "Outfit-Bold",
            dateFontName: "InstrumentSerif-Regular"
        ),
        // 8. Neon lime
        Theme(
            name: "Citrus", //7
            colors: [
                srgb(50, 108, 2),//edge
                srgb(195, 241, 5),//middle
                srgb(255, 251, 158) //center
            ],
            timeFontName: "Outfit-Bold",
            dateFontName: "InstrumentSerif-Regular"
        ),
        // 9. Neon purple
        Theme(
            name: "Electric Lilac", //8
            colors: [
                srgb(49, 6, 135),//edge
                srgb(170, 97, 254),//middle
                srgb(187, 248, 241) //center
            ],
            timeFontName: "Outfit-Bold",
            dateFontName: "InstrumentSerif-Regular"
        ),
        // 10. Neon pink
        Theme(
            name: "Blush Bloom", //9
            colors: [
                srgb(186, 5, 127),//edge
                srgb(246, 107, 247),//middle
                srgb(199, 238, 252) //center
            ],
            timeFontName: "Outfit-Bold",
            dateFontName: "InstrumentSerif-Regular"
        ),
        // 11. Indigo
        Theme(
            name: "Lunar Indigo", //10
            colors: [
                srgb(18, 20, 95),//edge
                srgb(50, 100, 158),//middle
                srgb(249, 221, 198) //center
            ],
            timeFontName: "Outfit-Bold",
            dateFontName: "InstrumentSerif-Regular"
        ),
        // 12. Dark warm
        Theme(
            name: "Dark Sun", //10
            colors: [
                srgb(19, 6, 0),//edge
                srgb(171, 86, 47),//middle
                srgb(255, 220, 117) //center
            ],
            timeFontName: "Outfit-Bold",
            dateFontName: "InstrumentSerif-Regular"
        ),
        // 13. Dark Blue
        Theme(
            name: "Dark Night", //10
            colors: [
                srgb(2, 0, 14),//edge
                srgb(0, 4, 86),//middle
                srgb(107, 115, 137) //center
            ],
            timeFontName: "Outfit-Bold",
            dateFontName: "InstrumentSerif-Regular"
        ),
        // 14. Dark Greyscale
        Theme(
            name: "Dark Grey", //10
            colors: [
                srgb(0, 0, 0),//edge
                srgb(70, 70, 70),//middle
                srgb(204, 204, 204) //center
            ],
            timeFontName: "Outfit-Bold",
            dateFontName: "InstrumentSerif-Regular"
        ),
        // 15. Dark Blue
        Theme(
            name: "Dark Denim", //10
            colors: [
                srgb(1, 27, 42),//edge
                srgb(27, 81, 117),//middle
                srgb(127, 170, 191) //center
            ],
            timeFontName: "Outfit-Bold",
            dateFontName: "InstrumentSerif-Regular"
        ),
        Theme(
            name: "Cosmic",
            colors: [
                srgb(0, 0, 0),//edge
                srgb(0, 0, 0),//middle
                srgb(0, 0, 0) //center
            ],
            timeFontName: "Outfit-Bold",
            dateFontName: "InstrumentSerif-Regular"
        ),
    ]
    
    // MARK: - Prefs
    private var autoTheme       = true
    private var fixedThemeIndex = 0
    private var showClock       = true
    
    private func defaults() -> UserDefaults {
        ScreenSaverDefaults(forModuleWithName: "com.michelle.aura") ?? UserDefaults.standard
    }
    
    private func loadPrefs() {
        let d = defaults()
        autoTheme       = d.object(forKey: kAutoTheme)  == nil ? true : d.bool(forKey: kAutoTheme)
        fixedThemeIndex = d.object(forKey: kThemeIndex) == nil ? 0    : d.integer(forKey: kThemeIndex)
        showClock       = d.object(forKey: kShowClock)  == nil ? true : d.bool(forKey: kShowClock)
        // clamp in case themes array shrank
        fixedThemeIndex = min(fixedThemeIndex, themes.count - 1)
    }
    
    private func savePrefs() {
        let d = defaults()
        d.set(autoTheme,       forKey: kAutoTheme)
        d.set(fixedThemeIndex, forKey: kThemeIndex)
        d.set(showClock,       forKey: kShowClock)
        d.synchronize()
    }
    
 
    
    // MARK: - State
    private var currentThemeIndex = 0
    private var nextThemeIndex    = 1
    private var transitionProgress: CGFloat = 1.0
    private var animationTime: CGFloat      = 0.0
    private var animationTimer: Timer?
    private var isTransitioning             = false
    private var transitionStartTime         = Date()
    private let transitionDuration: TimeInterval = 8.0
    private let holdDuration:       TimeInterval = 20.0
    private var holdTimer: Timer?
    
    // MARK: - Config sheet
    // Always return nil from the stored var; build fresh each time macOS asks
    override var hasConfigureSheet: Bool { true }
    override var configureSheet: NSWindow? { buildConfigSheet() }
 
    override func startAnimation() {
        super.startAnimation()
    }
    
    // MARK: - Init
    override init?(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
        loadPrefs()
        currentThemeIndex = Int.random(in: 0..<themes.count)
        nextThemeIndex    = (currentThemeIndex + 1) % themes.count
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadPrefs()
        currentThemeIndex = Int.random(in: 0..<themes.count)
        nextThemeIndex    = (currentThemeIndex + 1) % themes.count
        setup()
    }
    
    private func setup() {
        animationTimeInterval = 1.0 / 60.0
        
        animationTimer = Timer(timeInterval: 1.0/60.0, target: self,
                               selector: #selector(tick), userInfo: nil, repeats: true)
        RunLoop.main.add(animationTimer!, forMode: .common)
        
        holdTimer = Timer(timeInterval: holdDuration, target: self,
                          selector: #selector(hold), userInfo: nil, repeats: true)
        RunLoop.main.add(holdTimer!, forMode: .common)
    }
    
    @objc private func tick() { animationTime += 0.050 }
    
    @objc private func hold() {
        guard autoTheme else { return }
        guard !isTransitioning else { return }
        nextThemeIndex    = (currentThemeIndex + 1) % themes.count
        isTransitioning   = true
        transitionProgress = 0.0
        transitionStartTime = Date()
    }
    
    // MARK: - Drawing
    override func draw(_ rect: NSRect) {
        guard let ctx = NSGraphicsContext.current?.cgContext else { return }
        
        if isTransitioning {
            let elapsed = Date().timeIntervalSince(transitionStartTime)
            transitionProgress = CGFloat(min(elapsed / transitionDuration, 1.0))
            if transitionProgress >= 1.0 {
                currentThemeIndex  = nextThemeIndex
                transitionProgress = 1.0
                isTransitioning    = false
            }
        }
        
        let ci = autoTheme ? currentThemeIndex : fixedThemeIndex
        let ni = autoTheme ? nextThemeIndex    : fixedThemeIndex
        
        drawBackground(ctx: ctx, rect: rect, ci: ci, ni: ni)
        if showClock { drawClock(ctx: ctx, rect: rect, themeIndex: ci) }
    }
    
    // MARK: - Background
    private func cosmicColors() -> [NSColor] {
        let hue = CGFloat(animationTime.truncatingRemainder(dividingBy: 200.0)) / 200.0
 
        func hsbToSRGB(_ h: CGFloat, _ s: CGFloat, _ b: CGFloat) -> NSColor {
            let temp = NSColor(hue: h, saturation: s, brightness: b, alpha: 1)
            var r: CGFloat = 0, g: CGFloat = 0, bl: CGFloat = 0
            temp.getRed(&r, green: &g, blue: &bl, alpha: nil)
            return NSColor(srgbRed: r, green: g, blue: bl, alpha: 1)
        }
 
        return [
            hsbToSRGB(hue,0.95, 0.12),
            hsbToSRGB((hue + 0.08).truncatingRemainder(dividingBy: 1), 0.90, 0.55),
            hsbToSRGB((hue + 0.18).truncatingRemainder(dividingBy: 1), 0.60, 0.95)
        ]
    }
    
    private func drawBackground(ctx: CGContext, rect: CGRect, ci: Int, ni: Int) {
        var current = themes[ci]
        var next    = themes[ni]
 
        if current.name == "Cosmic" {
            let c = cosmicColors()
            current = Theme(name: "Cosmic", colors: c, timeFontName: current.timeFontName, dateFontName: current.dateFontName)
        }
        if next.name == "Cosmic" {
            let c = cosmicColors()
            next = Theme(name: "Cosmic", colors: c, timeFontName: next.timeFontName, dateFontName: next.dateFontName)
        }
 
        func blend(_ a: NSColor, _ b: NSColor, _ t: CGFloat) -> NSColor {
            NSColor(srgbRed: a.redComponent   + (b.redComponent   - a.redComponent)   * t,
                    green:   a.greenComponent + (b.greenComponent - a.greenComponent) * t,
                    blue:    a.blueComponent  + (b.blueComponent  - a.blueComponent)  * t,
                    alpha: 1)
        }
 
        let t       = isTransitioning ? transitionProgress : 0.0
        let blended = zip(current.colors, next.colors).map { blend($0, $1, t) }
 
        // Fill solid base with the darkest (edge) color
        ctx.setFillColor(blended[0].cgColor)
        ctx.fill(rect)
 
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let ax = rect.width  * 0.30
        let ay = rect.height * 0.26
 
        // Build blob gradient that fades to transparent at edge — matches web version
        func makeGradient(center: NSColor, mid: NSColor) -> CGGradient? {
            let colors: [CGColor] = [
                center.cgColor,
                mid.withAlphaComponent(0.85).cgColor,
                mid.withAlphaComponent(0.30).cgColor,
                NSColor.clear.cgColor
            ]
            let locs: [CGFloat] = [0.0, 0.35, 0.65, 1.0]
            return CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: locs)
        }
 
        // Blob 1 — main, full opacity
        let dx1 = sin(animationTime*0.055+0.9)*ax*0.85 + sin(animationTime*0.028+1.7)*ax*0.42 + sin(animationTime*0.017+2.85)*ax*0.26
        let dy1 = cos(animationTime*0.048+0.3)*ay*0.80 + sin(animationTime*0.031+2.2)*ay*0.40 + cos(animationTime*0.020+1.45)*ay*0.30
        let c1  = CGPoint(x: rect.midX + dx1, y: rect.midY + dy1)
        let r1  = max(rect.width, rect.height) * (0.85 + sin(animationTime*0.13)*0.06)
 
        if let grad1 = makeGradient(center: blended[2], mid: blended[1]) {
            ctx.saveGState()
            ctx.drawRadialGradient(grad1, startCenter: c1, startRadius: 0,
                                   endCenter: c1, endRadius: r1,
                                   options: [.drawsBeforeStartLocation, .drawsAfterEndLocation])
            ctx.restoreGState()
        }
 
        // Blob 2 — opposite phase, 55% opacity, slightly shifted hue
        let dx2 = sin(animationTime*0.041+(.pi)+1.1)*ax*0.75 + cos(animationTime*0.022+(.pi)+0.4)*ax*0.38 + sin(animationTime*0.014+(.pi)+3.1)*ax*0.22
        let dy2 = cos(animationTime*0.035+(.pi)+2.0)*ay*0.70 + sin(animationTime*0.019+(.pi)+0.8)*ay*0.32 + cos(animationTime*0.012+(.pi)+1.9)*ay*0.24
        let c2  = CGPoint(x: rect.midX + dx2, y: rect.midY + dy2)
        let r2  = max(rect.width, rect.height) * (0.70 + cos(animationTime*0.09)*0.05)
 
        let center2 = NSColor(hue: (blended[2].hueComponent + 0.06).truncatingRemainder(dividingBy: 1),
                              saturation: min(1, blended[2].saturationComponent + 0.05),
                              brightness: min(1, blended[2].brightnessComponent + 0.05), alpha: 1)
        let mid2    = NSColor(hue: (blended[1].hueComponent + 0.04).truncatingRemainder(dividingBy: 1),
                              saturation: min(1, blended[1].saturationComponent + 0.04),
                              brightness: min(1, blended[1].brightnessComponent + 0.04), alpha: 1)
 
        if let grad2 = makeGradient(center: center2, mid: mid2) {
            ctx.saveGState()
            ctx.setAlpha(0.55)
            ctx.drawRadialGradient(grad2, startCenter: c2, startRadius: 0,
                                   endCenter: c2, endRadius: r2,
                                   options: [.drawsBeforeStartLocation, .drawsAfterEndLocation])
            ctx.restoreGState()
        }
    }
    
    // MARK: - Clock
    private func resolveFont(preferred: String, size: CGFloat, isSerif: Bool) -> NSFont {
        if let f = NSFont(name: preferred, size: size) { return f }
        for name in (isSerif ? ["Georgia","Palatino-Roman"] : ["HelveticaNeue-Light","Helvetica"]) {
            if let f = NSFont(name: name, size: size) { return f }
        }
        return NSFont.systemFont(ofSize: size, weight: isSerif ? .regular : .light)
    }
    
    private func drawClock(ctx: CGContext, rect: CGRect, themeIndex: Int) {
        let now = Date()
        var hour = Calendar.current.component(.hour, from: now)
        let min  = Calendar.current.component(.minute, from: now)
        if hour == 0 { hour = 12 } else if hour > 12 { hour -= 12 }
        
        let theme    = themes[themeIndex]
        let fontSize = rect.width * 0.12
        let font     = resolveFont(preferred: theme.timeFontName, size: fontSize, isSerif: false)
        let para     = NSMutableParagraphStyle(); para.alignment = .center
        
        let timeStr = NSAttributedString(string: "\(hour):\(String(format:"%02d",min))",
                                         attributes: [.font: font,
                                                      .foregroundColor: NSColor.white.withAlphaComponent(0.92),
                                                      .paragraphStyle: para,
                                                      .kern: fontSize * 0.02])
        let ts = timeStr.size()
        timeStr.draw(at: CGPoint(x: (rect.width-ts.width)/2,
                                 y: (rect.height-ts.height)/2 + rect.height*0.04))
        
        let formatter = DateFormatter(); formatter.dateFormat = "EEEE · MMMM d"
        let dfs  = rect.width * 0.014
        let dfnt = resolveFont(preferred: theme.dateFontName, size: dfs, isSerif: true)
        let dpara = NSMutableParagraphStyle(); dpara.alignment = .center
        let dateStr = NSAttributedString(string: formatter.string(from: now).lowercased(),
                                         attributes: [.font: dfnt,
                                                      .foregroundColor: NSColor.white.withAlphaComponent(0.50),
                                                      .paragraphStyle: dpara,
                                                      .kern: dfs * 0.3])
        let ds   = dateStr.size()
        let timeY = (rect.height-ts.height)/2 + rect.height*0.04
        dateStr.draw(at: CGPoint(x: (rect.width-ds.width)/2,
                                 y: timeY - ds.height - rect.height*0.025))
    }
    
    // MARK: - Animate
    override func animateOneFrame() { needsDisplay = true }
    
    override func stopAnimation() {
        super.stopAnimation()
        animationTimer?.invalidate(); animationTimer = nil
        holdTimer?.invalidate();      holdTimer      = nil
    }
    
    // MARK: - Config sheet
    // Build a fresh panel every time — never cache it
    private func buildConfigSheet() -> NSWindow {
        loadPrefs()   // always reflect latest saved values
        
        let panel = NSPanel(contentRect: NSRect(x:0, y:0, width:320, height:220),
                            styleMask: [.titled, .nonactivatingPanel], backing: .buffered, defer: false)
        panel.title = "Aura Settings"
        panel.isReleasedWhenClosed = false
        
        let v = NSView(frame: NSRect(x:0, y:0, width:320, height:220))
        
        // Theme mode
        v.addSubview(label("Theme", NSRect(x:20, y:170, width:100, height:22)))
        let modeBtn = NSPopUpButton(frame: NSRect(x:130, y:168, width:170, height:26))
        modeBtn.addItems(withTitles: ["Auto-cycle all themes", "Pick one theme"])
        modeBtn.selectItem(at: autoTheme ? 0 : 1)
        modeBtn.tag = 10
        modeBtn.target = self; modeBtn.action = #selector(modeChanged(_:))
        v.addSubview(modeBtn)
        
        // Gradient picker
        v.addSubview(label("Gradient", NSRect(x:20, y:128, width:100, height:22)))
        let picker = NSPopUpButton(frame: NSRect(x:130, y:126, width:170, height:26))
        picker.addItems(withTitles: themes.map { $0.name })
        picker.selectItem(at: min(fixedThemeIndex, themes.count-1))
        picker.isEnabled = !autoTheme
        picker.tag = 11
        picker.target = self; picker.action = #selector(pickerChanged(_:))
        v.addSubview(picker)
        
        // Clock
        v.addSubview(label("Clock", NSRect(x:20, y:86, width:100, height:22)))
        let clockBox = NSButton(checkboxWithTitle: "Show time & date",
                                target: self, action: #selector(clockChanged(_:)))
        clockBox.frame = NSRect(x:130, y:86, width:170, height:22)
        clockBox.state = showClock ? .on : .off
        v.addSubview(clockBox)
        
        // Done
        let done = NSButton(title: "Done", target: self, action: #selector(donePressed(_:)))
        done.frame = NSRect(x:220, y:20, width:80, height:32)
        done.bezelStyle = .rounded
        done.keyEquivalent = "\r"
        v.addSubview(done)
        
        panel.contentView = v
        return panel
    }
    
    private func label(_ s: String, _ r: NSRect) -> NSTextField {
        let f = NSTextField(labelWithString: s)
        f.frame = r; f.font = .systemFont(ofSize: 13, weight: .medium)
        return f
    }
    
    @objc private func modeChanged(_ sender: NSPopUpButton) {
        autoTheme = sender.indexOfSelectedItem == 0
        savePrefs()
        if let p = sender.window?.contentView?.viewWithTag(11) as? NSPopUpButton {
            p.isEnabled = !autoTheme
        }
    }
    
    @objc private func pickerChanged(_ sender: NSPopUpButton) {
        fixedThemeIndex = sender.indexOfSelectedItem
        savePrefs()
    }
    
    @objc private func clockChanged(_ sender: NSButton) {
        showClock = sender.state == .on
        savePrefs()
    }
    
    // Use the sender's window to dismiss — avoids any NSApp sheet confusion
    @objc private func donePressed(_ sender: NSButton) {
        guard let w = sender.window else { return }
        w.sheetParent?.endSheet(w, returnCode: .OK)
    }
    
    
}
