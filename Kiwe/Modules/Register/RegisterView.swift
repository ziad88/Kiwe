//
//  RegisterView.swift
//  Foursquare
//
//  Created by Ziad Alfakharany on 05/08/2023.
//

import UIKit
import SnapKit

final class RegisterView: UIView {
    
    // MARK: - Properties
    
    let createAccountLabel: UILabel = {
        $0.text = "Register"
        $0.textColor = .black
        $0.minimumScaleFactor = 0.8
        $0.numberOfLines = 2
        return $0
    }(UILabel())
    
    let nameField = TextInput(
    placeholder: "your name",
    title: "your name",
    hint: "first And LastName",
    validationRegex: #"(?:^[A-Za-z]{2,} [A-Za-z]{2,}\s?|^[\u0621-\u064A]{2,} [\u0621-\u064A]{2,})\s?$"#,
    error: "please Add Your First And Second Name",
    success: "please Add Your First And Second Name"
    ).with {
        $0.textField.autocapitalizationType = .words
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
    
    let phoneField = TextInput(
        placeholder: "Phone Number",
        title: "Phone Number",
        validationRegex: #"(^01[0125][0-9]{8}$)"#,
        error: "Phone Number Must Be 10 Digits",
        success: "Invalid Phone Number"
    ).with {
        $0.textField.keyboardType = .phonePad
    }
    
    let passwordFieldRightButton: UIButton = {
        $0.setImage(UIImage(systemName: "eye.slash.fill")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return $0
    }(UIButton())
    
    lazy var passwordField = TextInput(
        placeholder: "your password",
        title: "your password",
        rightButton: passwordFieldRightButton,
        validationRegex: #"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z])(?=.*[\\_`~$&+,:;=?@\[\]#{|}'<>.^*()%!-]).{8,}$"#
        ).with {
            $0.textField.isSecureTextEntry = true
            $0.textField.keyboardType = .asciiCapable
        }
    
    let getStartedButton: UIButton = {
        $0.setTitle("Get Started", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.setTitleColor(.lightGray, for: .disabled)
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .systemBlue
        return $0
    }(UIButton())
    
    let backButton: UIButton = {
        $0.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.setTitleColor(.lightGray, for: .disabled)
        $0.layer.cornerRadius = 10
        return $0
    }(UIButton())
    
    private(set) lazy var ctaStackView: UIStackView = {
        $0.addArrangedSubview(backButton)
        $0.addArrangedSubview(getStartedButton)
        $0.alignment = .fill
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.spacing = 20
        return $0
    }(UIStackView())
    
    private(set) lazy var contentStack: UIStackView = {
        $0.addArrangedSubview(createAccountLabel)
        $0.addArrangedSubview(nameField)
        $0.addArrangedSubview(emailTextField)
        $0.addArrangedSubview(phoneField)
        $0.addArrangedSubview(passwordField)
        $0.alignment = .fill
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 16
        $0.setCustomSpacing(20, after: createAccountLabel)
        return $0
    }(UIStackView())
    
    // MARK: - Methods
    
    init() {
        super.init(frame: .zero)
        constructHierarchy()
        activateConstraints()
        styleView()
    }
    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    private func constructHierarchy() {
        addSubview(contentStack)
        addSubview(ctaStackView)
    }
    
    private func activateConstraints() {
        contentStack.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(32)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.lessThanOrEqualTo(safeAreaLayoutGuide.snp.bottom).inset(10)
        }
        
        backButton.snp.makeConstraints { make in
            make.width.equalTo(60)
        }
        
        
        ctaStackView.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(contentStack.snp.bottom).offset(20).priority(.medium)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(10)
            make.height.equalTo(self.snp.height).multipliedBy(0.066)
            make.left.right.equalToSuperview().inset(20)
        }
    
    }
    
    private func styleView() {
        backgroundColor = .white
    }
}
