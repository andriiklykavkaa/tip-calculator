//
//  SplitInputView.swift
//  TipCalculator
//
//  Created by Andrii Klykavka on 14.11.2024.
//

import UIKit
import SnapKit

class SplitInputView: UIView {
    
    private let headerView: HeaderView = {
        HeaderView(
            topText: "Split",
            bottomText: "the total")
    }()
    
    private lazy var decrementButton: UIButton = {
        let button = buildButton(
            text: "-",
            corners: [.layerMinXMaxYCorner, .layerMinXMinYCorner])
        return button
    }()
    
    private lazy var incrementButton: UIButton = {
        let button = buildButton(
            text: "+",
            corners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner])
        return button
    }()
    
    private let quantityLabel: UILabel = {
        let label = LabelFactory.build(
            text: "1",
            font: ThemeFont.bold(ofSize: 20), backgroundColor: .white)
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            decrementButton,
            quantityLabel,
            incrementButton
        ])
        stack.axis = .horizontal
        stack.spacing = 0
        return stack
    }()
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        [headerView, stackView].forEach(addSubview(_:))
        
        stackView.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
        }
        
        [incrementButton, decrementButton].forEach { button in
            button.snp.makeConstraints {
                $0.width.equalTo(button.snp.height)
            }
        }
        
        headerView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalTo(stackView)
            $0.trailing.equalTo(stackView.snp.leading).offset(-18)
            $0.width.equalTo(68)
        }
    }
    
    private func buildButton(text: String, corners: CACornerMask) -> UIButton {
        let button = UIButton()
        button.setTitle(text, for: .normal)
        button.backgroundColor = ThemeColor.primary
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = ThemeFont.bold(ofSize: 20)
        button.addRoundedCorners(corners: corners, radius: 8.0)
        return button
    }
}
