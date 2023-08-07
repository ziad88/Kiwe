//
//  TextInput.swift
//  Foursquare
//
//  Created by Ziad Alfakharany on 05/08/2023.
//

import UIKit
import Combine
import SnapKit

public final class TextInput: UIView {
    
    public enum Status: Equatable {
        case enabled, disabled, active, error(String?), notActive
        
        public static func == (lhs: Status, rhs: Status) -> Bool {
            switch (lhs, rhs) {
            case (.enabled, .enabled),
                (.disabled, .disabled),
                (.active, .active),
                (.error, .error),
                (.notActive, .notActive):
                return true
            default:
                return false
            }
        }
    }
        
    // MARK: - Properties
    
    @Published public var status: Status = .notActive
    @Published public private(set) var isValid: Bool = false
    
    @Published public var samePhoneNumber: Bool = false
        
    // Views
    public private(set) lazy var textField: UITextField = {
        $0.backgroundColor = .clear
        $0.textColor = textColor ?? .darkGray
        $0.placeholder = placeholder
        $0.tintColor = .gray
        return $0
    }(UITextField())
    
    private lazy var errorLabel: UILabel = {
        $0.textColor = .red
        $0.text = error
        $0.isHidden = true
        $0.numberOfLines = 2
        return $0
    }(UILabel())

    
    private lazy var hintLabel: UILabel = {
        $0.textColor = .lightGray
        $0.text = hint
        $0.isHidden = hint == nil
        $0.numberOfLines = 0
        return $0
    }(UILabel())
        
    private lazy var inputTextContentStack: UIStackView = {
        $0.alignment = .center
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.spacing = 12
        $0.addArrangedSubview(textField)
        if let rightButton = rightButton {
            $0.addArrangedSubview(rightButton)
        }
        return $0
    }(UIStackView())
    
    private lazy var inputTextContainer: UIView = {
        $0.layer.borderWidth = borderWidth ?? 1.5
        $0.layer.cornerRadius = 10 
        $0.backgroundColor = self.background ?? .clear
        $0.addSubview(inputTextContentStack)
        return $0
    }(UIView())
    
    private lazy var contentStack: UIStackView = {
        $0.alignment = .fill
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 2
        $0.addArrangedSubview(inputTextContainer)
        $0.addArrangedSubview(hintLabel)
        $0.addArrangedSubview(errorLabel)
         return $0
    }(UIStackView())
    
    // Status
    private var subscriptions = Set<AnyCancellable>()
    private var beginTypingPublisher: AnyPublisher<Bool, Never> {
        NotificationCenter.default.publisher(for: UITextField.textDidBeginEditingNotification, object: textField)
            .map { ($0.object as? UITextField)?.isFirstResponder ?? false }
            .eraseToAnyPublisher()
    }
    private var endTypingPublisher: AnyPublisher<Bool, Never> {
        NotificationCenter.default.publisher(for: UITextField.textDidEndEditingNotification, object: textField)
            .map { ($0.object as? UITextField)?.isFirstResponder ?? false }
            .eraseToAnyPublisher()
    }
    public var textPublisher: AnyPublisher<String?, Never> {
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: textField)
            .map { ($0.object as? UITextField)?.text }
            .eraseToAnyPublisher()
    }

    // Config
    private let rightButton: UIButton?
    private let title: String?
    public var placeholder: String?
    private let hint: String?
    private let validationRegex: String?
    private let error: String?
    private let success: String?
    private let background: UIColor?
    private let anotherValidates: Bool?
    private let borderWidth: CGFloat?
    private let textColor: UIColor?
    
    public init(placeholder: String? = nil,
                title: String? = nil,
                hint: String? = nil,
                rightButton: UIButton? = nil,
                validationRegex: String? = nil,
                anotherValidates: Bool? = nil,
                error: String? = nil,
                success: String? = nil,
                backgroundColor: UIColor? = nil,
                borderWidth: CGFloat = 1.5,
                textColor: UIColor? = nil) {
        self.borderWidth = borderWidth
        self.textColor = textColor
        self.rightButton = rightButton
        self.hint = hint
        self.title = title
        self.placeholder = placeholder
        self.validationRegex = validationRegex
        self.error = error
        self.success = success
        self.background = backgroundColor
        self.anotherValidates = anotherValidates
        super.init(frame: .zero)
        self.initialSetup()
    }
    public required init?(coder aDecoder: NSCoder) {
        self.rightButton = nil
        self.hint = nil
        self.placeholder = nil
        self.title = nil
        self.validationRegex = nil
        self.anotherValidates = nil
        self.error = nil
        self.success = nil
        self.background = nil
        self.borderWidth = nil
        self.textColor = nil
        super.init(coder: aDecoder)
        self.initialSetup()
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.initialSetup()
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func initialSetup() {
        constructHierarchy()
        activateConstraints()
        styleView()
        subscribeToStatusChanges()
        makeSubscription()
    }
    
    private func constructHierarchy() {
        addSubview(contentStack)
    }
    
    private func activateConstraints() {
        contentStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        inputTextContentStack.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(6)
            make.leading.trailing.equalToSuperview().inset(12)
        }
                
        if let rightButton = rightButton {
            rightButton.snp.makeConstraints { make in
                make.height.equalTo(rightButton.snp.width)
                make.width.equalTo(60)
            }
        }
        
        inputTextContainer.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        
        textField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
        }
    }
    
    private func styleView() {
        backgroundColor = .clear
    }
    
    private func makeSubscription() {
        beginTypingPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.status = $0 ? .active : .notActive
            }.store(in: &subscriptions)
        
        endTypingPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.status = $0 ? .active : .notActive
            }.store(in: &subscriptions)
        
        if anotherValidates != nil {
            textPublisher
                .receive(on: DispatchQueue.main)
                .sink { [weak self] in
                    guard let strongSelf = self else { return }
                    
                    if $0!.isEmpty || $0 == "" || $0 == " " {
                        strongSelf.status = .error(strongSelf.error)
                        strongSelf.isValid = false
                        return
                    }
                    
                    strongSelf.status = strongSelf.status == .notActive ? .notActive : .active
                    strongSelf.isValid = true
                }.store(in: &subscriptions)
        }

        guard let validationRegex = validationRegex else { return }

        textPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                if self?.placeholder == "0" {
                    if self?.textField.text != "" {
                        self?.textField.placeholder = ""
                    } else { self?.textField.placeholder = "0" }
                }
                guard $0 != "", let strongSelf = self else { return }
                guard $0?.range(of: validationRegex, options: .regularExpression) != nil else {
                    strongSelf.status = .error(strongSelf.error)
                    strongSelf.isValid = false
                    return
                }
                strongSelf.status = strongSelf.status == .notActive ? .notActive : .active
                strongSelf.isValid = true
            }.store(in: &subscriptions)
    }
    
    private func subscribeToStatusChanges() {
        $status
            .scan((status, status)) { ($0.1, $1) }
            .eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.errorLabel.isHidden = true
                strongSelf.hintLabel.isHidden = strongSelf.hint == nil
                switch $0 {
                case (.error, .notActive):
                    break
                case (_, .error(let error)):
                    strongSelf.inputTextContainer.layer.borderColor = UIColor.red.cgColor
                    strongSelf.errorLabel.isHidden = false //strongSelf.error == nil
                    strongSelf.hintLabel.isHidden = strongSelf.error != nil
                    strongSelf.errorLabel.text = error
                case (_, .active):
                    strongSelf.inputTextContainer.layer.borderColor = UIColor.darkGray.cgColor
                    strongSelf.hintLabel.isHidden = false
                case (_, .notActive):
                    strongSelf.inputTextContainer.layer.borderColor = UIColor.placeholderText.cgColor
                default: break
                }
            }.store(in: &subscriptions)

    }
}

extension UITextField {
    public var textPublisher: AnyPublisher<String?, Never> {
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: self)
            .map { ($0.object as? UITextField)?.text }
            .eraseToAnyPublisher()
    }
}
