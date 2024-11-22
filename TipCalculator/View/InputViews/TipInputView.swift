//
//  TipInputView.swift
//  TipCalculator
//
//  Created by Andrii Klykavka on 14.11.2024.
//

import UIKit
import SnapKit

class TipInputView: UIView {
    
    private let headerView: HeaderView = {
        let view = HeaderView(
            topText: "Choose",
            bottomText: "your tip")
        return view
    }()
    
    private lazy var tenPercentTipButton: UIButton = {
        let button = buildTipButton(tip: .tenPercent)
        return button
    }()
    
    private lazy var fifteenPercentTipButton: UIButton = {
        let button = buildTipButton(tip: .fifteenPercent)
        return button
    }()
    
    private lazy var twentyPercentTipButton: UIButton = {
        let button = buildTipButton(tip: .twentyPercent)
        return button
    }()
    
    private let customTipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Custom tip", for: .normal)
        button.titleLabel?.font = ThemeFont.bold(ofSize: 20)
        button.backgroundColor = ThemeColor.primary
        button.tintColor = .white
        button.addCornerRadius(radius: 8.0)
        return button
    }()
    
    private lazy var hStackView: UIStackView =  {
        let stack = UIStackView(arrangedSubviews: [
            tenPercentTipButton,
            fifteenPercentTipButton,
            twentyPercentTipButton])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 12
        return stack
    }()
    
    private lazy var buttonVStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            hStackView,
            customTipButton
        ])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 12
        return stack
    }()
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        [headerView, buttonVStackView].forEach(addSubview(_:))
        buttonVStackView.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview()
        }
        headerView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(buttonVStackView.snp.leading).offset(-24)
            $0.width.equalTo(68)
            $0.centerY.equalTo(buttonVStackView.snp.centerY)
        }
    }
    
    private func buildTipButton(tip: Tip) -> UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = ThemeColor.primary
        button.tintColor = .white
        button.addCornerRadius(radius: 8.0)
        let text = NSMutableAttributedString(
            string: tip.stringValue,
            attributes: [
                .font: ThemeFont.bold(ofSize: 20),
                .foregroundColor: UIColor.white
        ])
        text.addAttributes(
            [
                .font: ThemeFont.demibold(ofSize: 14)
            ],
            range:  NSMakeRange(2, 1))
        button.setAttributedTitle(text, for: .normal)
        return button
    }
}
