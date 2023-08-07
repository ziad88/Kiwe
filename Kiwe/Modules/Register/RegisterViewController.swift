//
//  RegisterViewController.swift
//  Foursquare
//
//  Created by Ziad Alfakharany on 05/08/2023.
//


import UIKit
import Combine
import CombineCocoa

final class RegisterViewController: UIViewController {

    // MARK: - Properties

    private let viewModel: RegisterViewModel
    private let customView: RegisterView
    
    
    // State
    private var subscriptions = Set<AnyCancellable>()

    // MARK: - Methods
    init(view: RegisterView, viewModel: RegisterViewModel) {
        self.customView = view
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.getStartedButton.addTarget(viewModel, action: #selector(RegisterViewModel.getStarted), for: .touchUpInside)
        
        subscribeToBackButton()
        subscribeToPasswordRightButton()
    }
 
    private func subscribeToBackButton() {
        customView.backButton.tapPublisher
            .sink {
                self.navigationController?.popViewController(animated: true)
            }.store(in: &subscriptions)
    }
    
    private func subscribeToPasswordRightButton() {
        customView.passwordFieldRightButton.tapPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.customView.passwordField.textField.isSecureTextEntry.toggle()
                let value = strongSelf.customView.passwordField.textField.isSecureTextEntry
                strongSelf.customView.passwordFieldRightButton.setImage(UIImage(systemName: "eye\(!value ? "" : ".slash").fill")?.withRenderingMode(.alwaysOriginal), for: .normal)
            }.store(in: &subscriptions)
    }
}
