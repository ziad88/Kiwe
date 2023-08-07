//
//  SigninViewController.swift
//  Kiwe
//
//  Created by Ziad Alfakharany on 06/08/2023.
//

import UIKit
import Combine

final class SigninViewController: UIViewController {
    
    // MARK: - Properties
    
    let viewModel: SignInViewModel
    let customView: SignInView
    
    // State
    private var subscriptions = Set<AnyCancellable>()
    
    
    // MARK: - Methods
    
    init(view: SignInView, viewModel: SignInViewModel) {
        self.customView = view
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        subscribeToKeyboardAppear(NotificationCenter.default.publisher(for: UITextField.keyboardWillChangeFrameNotification))
//        subscribeToKeyboardDisappear(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification))
//
//
//        subscribeToBackButton()
//
        subscribeToPasswordRightButton()
//
//
//        customView.emailTextField.textPublisher.receive(subscriber: viewModel.emailSubjectSubscriber)
//        customView.passwordField.textPublisher.receive(subscriber: viewModel.passwordSubjectSubscriber)
        customView.signUpBtn.addTarget(viewModel, action: #selector(SignInViewModel.createAccount), for: .touchUpInside)
        customView.getStartedButton.addTarget(viewModel, action: #selector(SignInViewModel.getStarted), for: .touchUpInside)
//        customView.emailTextField.$isValid.eraseToAnyPublisher().receive(subscriber: viewModel.emailInputStatus)
//        customView.passwordField.$isValid.eraseToAnyPublisher().receive(subscriber: viewModel.passwordInputStatus)
//
//        customView.signUpBtn.delegate = self
        
    }
    // MARK: - Methods
    // back button tapped
//    private func subscribeToBackButton() {
//        customView.backButton.tapPublisher
//            .receive(on: DispatchQueue.main)
//            .sink { [weak self] in
//                guard let strongSelf = self else { return }
//                strongSelf.navigationController?.popViewController(animated: true)
//            }.store(in: &subscriptions)
//    }
//
    // SHOW PASSWORD THAT HIDDEN
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
//
//
//
//
//
//    private func subscribeToKeyboardAppear(_ keyboardAppearNotificationPublisher: NotificationCenter.Publisher) {
//        keyboardAppearNotificationPublisher
//            .compactMap { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue }
//            .map { $0.cgRectValue.height }
//            .receive(on: DispatchQueue.main)
//            .sink { [weak self] keyboardHight in
//                guard let strongSelf = self else { return }
//                UIView.animate(withDuration: 0.5) {
//                    strongSelf.customView.ctaStackView.snp.updateConstraints { make in
//                        make.bottom.equalTo(strongSelf.customView.safeAreaLayoutGuide.snp.bottom).inset(keyboardHight)
//                    }
//                    strongSelf.customView.signUpBtn.snp.updateConstraints { make in
//                        make.top.equalTo(strongSelf.customView.forgetPassword.snp.bottom) // .inset(-28)
//                    }
//                }
//            }.store(in: &subscriptions)
//    }
//
//    private func subscribeToKeyboardDisappear(_ keyboardDisappearNotificationPublisher: NotificationCenter.Publisher) {
//        keyboardDisappearNotificationPublisher
//            .receive(on: DispatchQueue.main)
//            .sink { [weak self] _ in
//                guard let strongSelf = self else { return }
//                UIView.animate(withDuration: 0.5) {
//                    strongSelf.customView.ctaStackView.snp.updateConstraints { make in
//                        make.bottom.equalTo(strongSelf.customView.safeAreaLayoutGuide.snp.bottom).inset(20)
//                    }
//                    strongSelf.customView.signUpBtn.snp.updateConstraints { make in
//                        make.top.equalTo(strongSelf.customView.forgetPassword.snp.bottom).inset(-38)
//                    }
//                }
//            }.store(in: &subscriptions)
//    }
}
    
    // MARK: - textView delegate to open URL
//    extension SigninViewController: UITextViewDelegate {
//
//        func textView(_ textView: UITextView,
//                      shouldInteractWith URL: URL,
//                      in characterRange: NSRange,
//                      interaction: UITextItemInteraction) -> Bool {
//            viewModel.userDidTapToSignUpSubject.send()
//            //        let svc = SFSafariViewController(url: URL)
//            //        present(svc, animated: true, completion: nil)
//            return false
//        }
//
//    }
