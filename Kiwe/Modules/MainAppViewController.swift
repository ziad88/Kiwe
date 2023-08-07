//
//  MainAppViewController.swift
//  Kiwe
//
//  Created by Ziad Alfakharany on 06/08/2023.
//

import UIKit
import Combine

final class MainAppViewController: UINavigationController {

    // View Model
    let viewModel: MainAppViewModel
    var subscriptions = Set<AnyCancellable>()
    
    let makeRegisterViewController: (() -> RegisterViewController)
    let makeHomeViewController: (() -> HomeViewController)
    var signInViewController: SigninViewController
    
    
    init(viewModel: MainAppViewModel,
         makeRegisterViewController: @escaping () -> RegisterViewController,
         makeSignInViewController: @escaping () -> SigninViewController,
         makeHomeViewViewController: @escaping () -> HomeViewController) {
        self.viewModel = viewModel
        self.makeRegisterViewController = makeRegisterViewController
        self.signInViewController = makeSignInViewController()
        self.makeHomeViewController = makeHomeViewViewController
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isHidden = true
        let navigationActionPublisher = viewModel.$navigationAction.eraseToAnyPublisher()
        subscribe(to: navigationActionPublisher)
    }
    
    func subscribe(to publisher: AnyPublisher<OnboardingNavigationAction, Never>) {
        publisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] action in
                guard let strongSelf = self else { return }
                strongSelf.respond(to: action)
            }.store(in: &subscriptions)
    }

    func respond(to navigationAction: OnboardingNavigationAction) {
        switch navigationAction {
        case .present(let view):
            present(view: view)
        case .presented:
            break
        }
    }
    
    func present(view: MainView) {
        switch view {
        case .root: presentRoot()
        case .register:
            presentRegister()
        case .home:
            presentHome()
        }
    }
        
    private func presentRoot() {
        pushViewController(signInViewController, animated: true)
    }
    
    private func presentRegister() {
        pushViewController(makeRegisterViewController(), animated: true)
    }
    
    private func presentHome() {
        pushViewController(makeHomeViewController(), animated: true)
    }
}
