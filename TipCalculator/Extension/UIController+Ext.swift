//
//  UIController+Ext.swift
//  TipCalculator
//
//  Created by Andrii Klykavka on 21.11.2024.
//

import UIKit

extension UIViewController {
    func addDismissKeyboardWhenTappedRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
