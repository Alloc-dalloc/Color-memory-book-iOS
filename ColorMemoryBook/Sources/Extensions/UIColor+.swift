//
//  UIColor+.swift
//  ColorMemoryBook
//
//  Created by 임영준 on 2023/04/13.
//

import UIKit

extension UIColor {
    
    convenience init?(hex: String, alpha: CGFloat = 1.0) {
        var hexWithoutSymbol = hex
        if hexWithoutSymbol.hasPrefix("#") {
            hexWithoutSymbol = String(hexWithoutSymbol.dropFirst())
        }

        guard hexWithoutSymbol.count == 6 else {
            return nil
        }

        var rgb: UInt64 = 0
        Scanner(string: hexWithoutSymbol).scanHexInt64(&rgb)

        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    
    static let ohsogo_Blue = UIColor(hex: "#0182CB")
    static let ohsogo_Charcol = UIColor(hex: "222222")
    static let ohsogo_Gray = UIColor(hex: "F4F4F5")
    static let ohsogo_Gray2 = UIColor(hex: "4F4F4F")

}
