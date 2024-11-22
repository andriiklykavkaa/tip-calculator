//
//  HeaderView.swift
//  TipCalculator
//
//  Created by Andrii Klykavka on 21.11.2024.
//

import UIKit

final class HeaderView: UIView {
    
    private let topText: String
    private let bottomText: String
    
    private lazy var topLabel: UILabel = {
        LabelFactory.build(
            text: self.topText,
            font: ThemeFont.bold(ofSize: 16))
    }()
    
    private lazy var bottomLabel: UILabel = {
        LabelFactory.build(
            text: self.bottomText,
            font: ThemeFont.regular(ofSize: 16))
    }()
    
    private let topSpacerView = UIView()
    private let bottomSpacerView = UIView()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        [topSpacerView, topLabel, bottomLabel, bottomSpacerView].forEach(stack.addArrangedSubview(_:))
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    init(topText: String, bottomText: String) {
        self.topText = topText
        self.bottomText = bottomText
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
        
        topSpacerView.snp.makeConstraints {
            $0.height.equalTo(bottomSpacerView)
        }
    }
}
