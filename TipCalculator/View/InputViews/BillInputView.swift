//
//  BillInputView.swift
//  TipCalculator
//
//  Created by Andrii Klykavka on 14.11.2024.
//

import UIKit
import Combine
import CombineCocoa
import SnapKit

class BillInputView: UIView {
    
    private let headerView: HeaderView = {
        let view = HeaderView(
            topText: "Enter",
            bottomText: "your bill")
        return view
    }()
    
    private let textFieldContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addCornerRadius(radius: 8.0)
        return view
    }()
    
    
    private let currencyDenomiationLabel: UILabel = {
        let label = LabelFactory.build(
            text: "$",
            font: ThemeFont.bold(ofSize: 24))
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private lazy var inputTextField: UITextField = {
        let field = UITextField()
        field.borderStyle = .none
        field.font = ThemeFont.demibold(ofSize: 28)
        field.keyboardType = .decimalPad
        field.setContentHuggingPriority(.defaultLow, for: .horizontal)
        field.tintColor = ThemeColor.text
        field.textColor = ThemeColor.text
        // Add toolbar
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 36))
        toolBar.barStyle = .default
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .plain,
            target: self,
            action: #selector(doneButtonTapped))
        toolBar.items = [
            UIBarButtonItem(
                barButtonSystemItem: .flexibleSpace,
                target: nil,
                action: nil),
            doneButton
        ]
        toolBar.isUserInteractionEnabled = true
        field.inputAccessoryView = toolBar
        return field
    }()
    
    private let billSubject: PassthroughSubject<Double, Never> = .init()
    var valuePublisher: AnyPublisher<Double, Never> {
        return billSubject.eraseToAnyPublisher()
    }
    
    private var cancellables: Set<AnyCancellable> = []

    init() {
        super.init(frame: .zero)
        layout()
        observe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func observe() {
        inputTextField.textPublisher.sink { [weak self] text in
            self?.billSubject.send(text?.doubleValue ?? 0)
            print("Text: \(text)")
        }.store(in: &cancellables)
    }
    
    private func layout() {
        [headerView, textFieldContainerView].forEach(addSubview(_:))
        
        headerView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalTo(textFieldContainerView.snp.centerY)
            $0.width.equalTo(68)
            $0.height.equalToSuperview()
            $0.trailing.equalTo(textFieldContainerView.snp.leading).offset(-18)
        }
        
        textFieldContainerView.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
        }
        
        [currencyDenomiationLabel, inputTextField].forEach(textFieldContainerView.addSubview(_:))
        
        currencyDenomiationLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(textFieldContainerView.snp.leading).offset(16)
        }
        
        inputTextField.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(currencyDenomiationLabel.snp.trailing).offset(8)
            $0.trailing.equalTo(textFieldContainerView.snp.trailing).offset(16)
        }
    }
    
    @objc private func doneButtonTapped() {
        textFieldContainerView.endEditing(true)
    }
}
