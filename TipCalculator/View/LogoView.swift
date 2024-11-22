//
//  LogoView.swift
//  TipCalculator
//
//  Created by Andrii Klykavka on 14.11.2024.
//

import UIKit
import SnapKit

class LogoView: UIView {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "icCalculatorBW"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let topLabel: UILabel = {
        let label = UILabel()
        let text = NSMutableAttributedString(
            string: "Mr TIP",
            attributes: [.font: ThemeFont.demibold(ofSize: 16)])
        text.addAttributes([.font: ThemeFont.bold(ofSize: 24)], range: NSMakeRange(3, 3))
        label.attributedText = text
        return label
    }()
    
    private let bottomLabel: UILabel = {
        LabelFactory.build(
            text: "Calculator",
            font: ThemeFont.demibold(ofSize: 20),
            textAlignment: .left)
    }()
    
    private lazy var vStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            topLabel,
            bottomLabel
        ])
        view.axis = .vertical
        view.spacing = -4
        view.alignment = .leading
        return view
    }()
    
    private lazy var hStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            imageView,
            vStackView
        ])
        view.axis = .horizontal
        view.spacing = 8
        view.alignment = .center
        return view
    }()

    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(hStackView)
        
        hStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.height.equalTo(imageView.snp.width)
        }
    }
}
