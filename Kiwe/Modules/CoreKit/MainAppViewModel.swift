//
//  MainAppViewModel.swift
//  Kiwe
//
//  Created by Ziad Alfakharany on 06/08/2023.
//

import Foundation
import Combine

public enum NavigationAction<ViewModelType>: Equatable where ViewModelType: Equatable {

  case present(view: ViewModelType)
  case presented(view: ViewModelType)
}

public typealias OnboardingNavigationAction = NavigationAction<MainView>

public class MainAppViewModel: GotoRegisterNavigator,
                               GotoHomeNavigator{
 
    @Published public private(set) var navigationAction: OnboardingNavigationAction = .present(view: .root)
    private var subscriptions = Set<AnyCancellable>()
    
    
    public func navigateToRegister() {
        navigationAction = .present(view: .register)
    }
    
    public func navigateToHome() {
        navigationAction = .present(view: .home)
    }
    
}

public protocol GotoRegisterNavigator {
    func navigateToRegister()
}

public protocol GotoHomeNavigator {
    func navigateToHome()
}
