//
//  SignInViewModel.swift
//  Kiwe
//
//  Created by Ziad Alfakharany on 06/08/2023.
//

import Foundation
import Combine
import UIKit

public final class SignInViewModel {
   
    private var gotoRegisterNavigator: GotoRegisterNavigator
    private var gotoHomeNavigator: GotoHomeNavigator
    
    // State
    var subscriptions = Set<AnyCancellable>()
    
    
    init(gotoRegisterNavigator: GotoRegisterNavigator, gotoHomeNavigator: GotoHomeNavigator) {
        self.gotoRegisterNavigator = gotoRegisterNavigator
        self.gotoHomeNavigator = gotoHomeNavigator
    }
    
    @objc
    public func createAccount() {
        gotoRegisterNavigator.navigateToRegister()
    }
    
    @objc
    public func getStarted() {
        gotoHomeNavigator.navigateToHome()
    }
}

