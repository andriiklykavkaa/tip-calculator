//
//  String+Ext.swift
//  TipCalculator
//
//  Created by Andrii Klykavka on 21.11.2024.
//

import Foundation

extension String {
    var doubleValue: Double? {
        let stringForDouble = self.replacingOccurrences(of: ",", with: ".")
        return Double(stringForDouble)
    }
}
