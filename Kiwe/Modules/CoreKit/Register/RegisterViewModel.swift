//
//  RegisterViewModel.swift
//  Foursquare
//
//  Created by Ziad Alfakharany on 05/08/2023.
//
import Foundation
import Combine
public final class RegisterViewModel {
   
    private var gotoHomeNavigator: GotoHomeNavigator
    
    // State
    var subscriptions = Set<AnyCancellable>()
    
    
    init(gotoHomeNavigator: GotoHomeNavigator) {
        self.gotoHomeNavigator = gotoHomeNavigator
    }
    @objc
    public func getStarted() {
        gotoHomeNavigator.navigateToHome()
    }
}

