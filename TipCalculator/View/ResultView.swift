//
//  ResultView.swift
//  TipCalculator
//
//  Created by Andrii Klykavka on 14.11.2024.
//

import UIKit
import SnapKit

class ResultView: UIView {
    
    private let headerLabel: UILabel = {
        LabelFactory.build(
            text: "Total p/person",
            font: ThemeFont.demibold(ofSize: 18))
    }()
    
    private let amountPerPersonLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        let text = NSMutableAttributedString(
            string: "$000",
            attributes: [
                .font: ThemeFont.bold(ofSize: 48)
            ])
        text.addAttributes(
            [
                .font: ThemeFont.bold(ofSize: 24)
            ],
            range: NSMakeRange(0, 1))
        label.attributedText = text
        return label
    }()
    
    private let horizontalLineView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.separator
        return view
    }()
    
    private lazy var hStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            AmountView(title: "Total bill", textAlignment: .left),
            UIView(),
            AmountView(title: "Total tip", textAlignment: .right)
        ])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var vStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            headerLabel,
            amountPerPersonLabel,
            horizontalLineView,
            buildSpacerView(height: 0),
            hStackView
        ])
        stack.axis = .vertical
        stack.spacing = 8
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
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(vStackView)
        
        vStackView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview().inset(24)
        }
        
        horizontalLineView.snp.makeConstraints {
            $0.height.equalTo(2)
        }
        
        addShadow(
            offset: CGSize(width: 0, height: 3),
            color: .black,
            radius: 12.0,
            opacity: 0.1)
    }
    
    private func buildSpacerView(height: CGFloat) -> UIView {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: height).isActive = true
        return view
    }
}
