//
//  CalculatorViewModel.swift
//  TipCalculator
//
//  Created by Andrii Klykavka on 21.11.2024.
//

import Foundation
import Combine

class CalculatorViewModel {
    
    private var cancellables: Set<AnyCancellable> = []

    struct ViewModelInput {
        let billPublisher: AnyPublisher<Double, Never>
        let tipPublisher: AnyPublisher<Tip, Never>
        let splitPublisher: AnyPublisher<Int, Never>
        
    }
    
    struct ViewModelOutput {
        let updateViewPublisher: AnyPublisher<CalculationResult, Never>
    }
    
    func transform(input: ViewModelInput) -> ViewModelOutput {
        
        input.billPublisher.sink { bill in
            print("THE BILL IS: \(bill)")
        }
        .store(in: &cancellables)
        
        let result =  CalculationResult(
            amountPerPerson: 5,
            totalBill: 100,
            totalTip: 15)
        return ViewModelOutput(updateViewPublisher: Just(result).eraseToAnyPublisher())
    }
}
