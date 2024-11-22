//
//  ThemeFont.swift
//  TipCalculator
//
//  Created by Andrii Klykavka on 14.11.2024.
//

import UIKit

struct ThemeFont {
    static func regular(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-Regular", size: size) ?? .systemFont(ofSize: 21)
    }
    
    static func bold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-Bold", size: size) ?? .systemFont(ofSize: 21)
    }
    
    static func demibold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-Demibold", size: size) ?? .systemFont(ofSize: 21)
    }
}
