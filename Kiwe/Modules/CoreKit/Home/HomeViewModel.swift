//
//  HomeViewModel.swift
//  Kiwe
//
//  Created by Ziad Alfakharany on 07/08/2023.
//

import Foundation
import Combine

public final class HomeViewModel {
    
    private var foreSquare: Result?


    // State
    private var subscriptions = Set<AnyCancellable>()
  
    
    
    private func getData() {
//        remoteRepository.shipmentCalculator()
//            .sink(receiveCompletion: { [weak self] in
//                guard let strongSelf = self else { return }
//                switch $0 {
//                case .finished: break
//                case .failure(let error):
//                    print(error)
//                }
//            }, receiveValue: { [weak self] in
//                guard let strongSelf = self else { return }
//                strongSelf.foreSquare = $0
//            }).store(in: &subscriptions)
    }
    
    
}
