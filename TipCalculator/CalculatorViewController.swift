//
//  ViewController.swift
//  TipCalculator
//
//  Created by Andrii Klykavka on 14.11.2024.
//

import UIKit
import Combine
import SnapKit

class CalculatorViewController: UIViewController {
    private let logoView = LogoView()
    private let resultView = ResultView()
    private let billInputView = BillInputView()
    private let tipInputView = TipInputView()
    private let splitInputView = SplitInputView()
    
    lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            logoView, resultView, billInputView, tipInputView, splitInputView, UIView()
        ])
        stackView.axis = .vertical
        stackView.spacing = 36
        return stackView
    }()
    
    private let viewModel: CalculatorViewModel
    private var cancellables: Set<AnyCancellable> = []

    
    init(viewModel: CalculatorViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ThemeColor.background
        setupLayout()
        addDismissKeyboardWhenTappedRecognizer()
        setupBindings()
    }
    
    private func setupBindings() {
        
        billInputView.valuePublisher
            .sink { value in
                print("Bill: >>>> \(value)")
            }
            .store(in: &cancellables)
        
        let input = CalculatorViewModel.ViewModelInput(
            billPublisher: billInputView.valuePublisher,
            tipPublisher: Just(.tenPercent).eraseToAnyPublisher(),
            splitPublisher: Just(5).eraseToAnyPublisher())
        
        let output = viewModel.transform(input: input)
        
        output.updateViewPublisher
            .sink { value in
            print(">>>>>>>", value)
        }
        .store(in: &cancellables)

    }
    
    private func setupLayout() {
        view.addSubview(vStackView)
        vStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        logoView.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        resultView.snp.makeConstraints {
            $0.height.equalTo(224)
        }
        
        billInputView.snp.makeConstraints {
            $0.height.equalTo(56)
        }
        
        tipInputView.snp.makeConstraints {
            $0.height.equalTo(56+56+15)
        }
        
        splitInputView.snp.makeConstraints {
            $0.height.equalTo(56)
        }
    }
}

