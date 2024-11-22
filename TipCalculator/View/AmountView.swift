//
//  AmountView.swift
//  TipCalculator
//
//  Created by Andrii Klykavka on 21.11.2024.
//

import UIKit

class AmountView: UIView {
    
    private let title: String
    private let textAlignment: NSTextAlignment
    
    private lazy var titleLabel: UILabel = {
        LabelFactory.build(
            text: self.title,
            font: ThemeFont.regular(ofSize: 18),
            textColor: ThemeColor.text,
            textAlignment: self.textAlignment)
    }()

    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = self.textAlignment
        label.textColor = ThemeColor.primary
        let text = NSMutableAttributedString(
            string: "$000",
            attributes: [
                .font: ThemeFont.bold(ofSize: 24)
            ])
        text.addAttributes([
            .font: ThemeFont.bold(ofSize: 16)
        ],
        range: NSMakeRange(0, 1))
        label.attributedText = text
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            titleLabel,
            amountLabel
        ])
        stack.axis = .vertical
        return stack
    }()
    
    init(title: String, textAlignment: NSTextAlignment) {
        self.title = title
        self.textAlignment = textAlignment
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}
