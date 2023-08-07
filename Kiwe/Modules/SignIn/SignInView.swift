//
//  SignInView.swift
//  Kiwe
//
//  Created by Ziad Alfakharany  on 06/08/2023.
//


import UIKit
import SnapKit

final class SignInView: UIView {
    
    // MARK: - Properties
    let emailTitle = UILabel().with {
        $0.text = "Please Enter Your Email And Password"
        $0.textColor = .gray
        $0.minimumScaleFactor = 0.8
        $0.numberOfLines = 2
    }
    
    let emailTextField = TextInput(
        placeholder: "Enter Your Email Address",
        title: "Email Address",
        validationRegex: #"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$"#,
        error: "Not Valid Email Address",
        success: "Email Address"
    ).with {
        $0.textField.keyboardType = .emailAddress
    }
    
    let passwordFieldRightButton = UIButton().with {
        $0.setImage(UIImage(systemName: "eye.slash.fill")?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    lazy var passwordField = TextInput(
        placeholder: "Your Password",
        title: "Your Password",
        rightButton: passwordFieldRightButton,
        anotherValidates: true,
        error: "Forgot Password",
        success: "Your Password"
    ).with {
        $0.textField.isSecureTextEntry = true
        $0.textField.keyboardType = .asciiCapable
    }
    
    
    let getStartedButton: UIButton = {
        $0.setTitle("Get Started", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.setTitleColor(.lightGray, for: .disabled)
        $0.backgroundColor = .systemBlue
        $0.layer.cornerRadius = 10
        return $0
    }(UIButton())
    
    public let signUpBtn: UIButton = {
        $0.setTitle("Create Account", for: .normal)
        $0.setTitleColor(.lightGray, for: .normal)
        $0.layer.cornerRadius = 10
        return $0
    }(UIButton())
    
    
    let backButton: UIButton = {
        $0.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        return $0
    }(UIButton())
    
    private(set) lazy var ctaStackView: UIStackView = {
        $0.addArrangedSubview(getStartedButton)
        $0.alignment = .fill
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.spacing = 20
        return $0
    }(UIStackView())
    
    lazy var phoneStack: UIStackView = {
        $0.addArrangedSubview(emailTitle)
        $0.addArrangedSubview(emailTextField)
        $0.addArrangedSubview(passwordField)
        $0.alignment = .fill
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 16
        $0.setCustomSpacing(10, after: emailTitle)
        return $0
    }(UIStackView())
    
    // MARK: - Methods
    
    init() {
        super.init(frame: .zero)
        constructHierarchy()
        activateConstraints()
        styleView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func constructHierarchy() {
        addSubview(phoneStack)
        addSubview(ctaStackView)
        addSubview(signUpBtn)
    }
    
    private func activateConstraints() {
        phoneStack.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.lessThanOrEqualTo(ctaStackView.snp.top).inset(10)
        }
        
        ctaStackView.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(phoneStack.snp.bottom).offset(20).priority(.medium)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(20)
            make.height.equalTo(self.snp.height).multipliedBy(0.066)
            make.left.right.equalToSuperview().inset(20)
        }
        
        signUpBtn.snp.makeConstraints { make in
            make.top.equalTo(phoneStack.snp.bottom).inset(-38)
            make.height.equalTo(30)
            make.width.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    private func styleView() {
        backgroundColor = .white
    }
}
