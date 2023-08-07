//
//  AppDependencyContainer.swift
//  Foursquare
//
//  Created by Ziad Alfakharany on 05/08/2023.
//

import Foundation

class MainAppDependencyContainer {
    
    public let sharedMainViewModel = MainAppViewModel()
    
    // Controllers
    public func makeRegisterViewController() -> RegisterViewController {
        return RegisterViewController(view: RegisterView(),
                                      viewModel: makeRegisterViewModel())
    }
    
    public func makeSignInViewController() -> SigninViewController {
        return SigninViewController(view: SignInView(), viewModel: makeSignInViewModel())
    }
    
    public func makeHomeViewController() -> HomeViewController {
        return HomeViewController(view: HomeView(), viewModel: makeHomeViewModel())
    }
    
    
    public func makeMainViewController() -> MainAppViewController {
        
        return MainAppViewController(viewModel: sharedMainViewModel,
                                     makeRegisterViewController: makeRegisterViewController,
                                     makeSignInViewController: makeSignInViewController,
                                     makeHomeViewViewController: makeHomeViewController)
    }
    
    // ViewModels
    private func makeRegisterViewModel() -> RegisterViewModel {
        return RegisterViewModel(gotoHomeNavigator: sharedMainViewModel)
    }
    private func makeSignInViewModel() -> SignInViewModel {
        return SignInViewModel(gotoRegisterNavigator: sharedMainViewModel, gotoHomeNavigator: sharedMainViewModel)
    }
    private func makeHomeViewModel() -> HomeViewModel {
        return HomeViewModel()
    }
}
    
