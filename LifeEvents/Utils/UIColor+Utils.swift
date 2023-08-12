//
//  UIColor+Utils.swift
//  LifeEvents
//
//  Created by yihong wang on 2023/6/30.
//

import Foundation
import UIKit
import SwiftUI



public extension UIColor {
    convenience init?(hex: String) {
        let r, g, b: CGFloat
        
        if hex.hasPrefix("0x") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    b = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: 1)
                    return
                }
            }
        }
        return nil
    }
    
    convenience init(hex: UInt64) {
        let r, g, b: CGFloat
        
        r = CGFloat((hex & 0x00ff0000) >> 16) / 255
        g = CGFloat((hex & 0x0000ff00) >> 8) / 255
        b = CGFloat(hex & 0x000000ff) / 255

        self.init(red: r, green: g, blue: b, alpha: 1)
    }
}

extension UIColor {
    public static var textLevel1: UIColor { .init(hex: 0x333333) }
    
    public static var textLevel2: UIColor { .init(hex: 0x666666) }
    
    public static var textLevel3: UIColor { .init(hex: 0x999999) }
    
    public static var textLevel4: UIColor { .init(hex: 0xcccccc) }
}

extension Color {
    init(hex: UInt64) {
        self.init(.init(hex: hex))
    }
    
    public static var textLevel1: Color { .init(hex: 0x333333) }
    
    public static var textLevel2: Color { .init(hex: 0x666666) }
    
    public static var textLevel3: Color { .init(hex: 0x999999) }
    
    public static var textLevel4: Color { .init(hex: 0xcccccc) }
    
    /// 0xACDF41
    public static var theme1: Color { .init(hex: 0xACDF41) }
    
    /// 0x87CA2D
    public static var theme2: Color { .init(hex: 0x87CA2D) }
    
    /// 0xEDFFE3
    public static var gradient1: Color { .init(hex: 0xEDFFE3) }
    /// 0xFFF4DF
    public static var gradient2: Color { .init(hex: 0xFFF4DF) }
    
    public static var green1: Color { .init(hex: 0xACDF41) }
    
    public static var green2: Color { .init(hex: 0x87CA2D) }
    
    public static var whitePatch1: Color { .init(hex: 0xF7F9FC) }
}

extension Gradient {
    public static var theme: Gradient {
        .init(colors: [.gradient1, .gradient2])
    }
}

extension LinearGradient {
    public static var green: LinearGradient {
        LinearGradient(colors: [.green1, .green2],startPoint: .leading,endPoint: .trailing)
    }
}

extension CGFloat {
    static var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    static var screenHeight: CGFloat {
        UIScreen.main.bounds.height
    }
    
    static var safeTop: CGFloat {
        UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0
    }
}
