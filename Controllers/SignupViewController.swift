//
//  SignupViewController.swift
//  DogWalk
//
//  Created by MacBook on 06.02.2026.
//

import UIKit


import UIKit

final class SignupViewController: UIViewController {
    
    // MARK: - Properties
    
    private var isPasswordVisible = false
    
    // MARK: - UI Elements: Scroll & Containers
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.keyboardDismissMode = .interactive
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - UI Elements: Header
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Arrow - Left"), for: .normal)
        button.tintColor = AppColor.color
        return button
    }()
    
    private let skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.titleLabel?.font = AppFont.interSemibold18()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - UI Elements: Labels & Text
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Let's start here"
        label.font = AppFont.interBold24()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.attributedText = createTitleAttributedString()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Fill in your details to begin"
        label.textAlignment = .left
        label.font = AppFont.interRegular18()
        label.textColor = AppColor.textSecondary
        label.attributedText = createSubtitleAttributedString()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var termsLabel: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.backgroundColor = .clear
        textView.textAlignment = .center
        textView.font = AppFont.interRegular18()
        textView.attributedText = createTermsAttributedString()
        textView.linkTextAttributes = [
            .foregroundColor: AppColor.primary,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    // MARK: - UI Elements: Input Fields
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Full Name"
        textField.font = AppFont.interRegular18()
        textField.textColor = AppColor.textColor
        textField.backgroundColor = AppColor.backgroundInput
        textField.layer.cornerRadius = 14
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.leftViewMode = .always
        textField.autocapitalizationType = .words
        textField.autocorrectionType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email Address"
        textField.font = AppFont.interRegular18()
        textField.textColor = AppColor.textColor
        textField.backgroundColor = AppColor.backgroundInput
        textField.layer.cornerRadius = 14
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.leftViewMode = .always
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.keyboardType = .emailAddress
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.font = AppFont.interRegular18()
        textField.textColor = AppColor.textColor
        textField.backgroundColor = AppColor.backgroundInput
        textField.layer.cornerRadius = 14
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.leftViewMode = .always
        textField.isSecureTextEntry = true
        
        // Кнопка глаза
        let toggleButton = UIButton(type: .system)
        toggleButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        toggleButton.tintColor = AppColor.iconColor
        toggleButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        textField.rightView = toggleButton
        textField.rightViewMode = .always
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    // MARK: - UI Elements: Buttons
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = AppFont.interSemibold18()
        button.backgroundColor = AppColor.primary
        button.layer.cornerRadius = 14
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let orLabel: UILabel = {
        let label = UILabel()
        label.text = "or"
        label.font = AppFont.interMedium18()
        label.textColor = AppColor.textColor
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let facebookButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Connect with Facebook", for: .normal)
        button.setTitleColor(UIColor(named: "surfase"), for: .normal)
        button.titleLabel?.font = AppFont.interSemibold18()
        button.backgroundColor = AppColor.facebookround
        button.layer.cornerRadius = 14
        button.clipsToBounds = true
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 57, bottom: 0, right: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // Иконка
        let iconView = UIImageView(image: AppImage.facebook.image)
        iconView.contentMode = .scaleAspectFit
        iconView.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(iconView)
        
        NSLayoutConstraint.activate([
            iconView.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 21),
            iconView.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 24),
            iconView.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        return button
    }()
    
    private let googleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Connect with Google", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = AppFont.interSemibold18()
        button.backgroundColor = AppColor.backgroundInput
        button.layer.cornerRadius = 14
        button.clipsToBounds = true
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 57, bottom: 0, right: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // Иконка
        let iconView = UIImageView(image: AppImage.googleLogo.image)
        iconView.contentMode = .scaleAspectFit
        iconView.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(iconView)
        
        NSLayoutConstraint.activate([
            iconView.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 21),
            iconView.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 24),
            iconView.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        return button
    }()
    
    // MARK: - UI Elements: Stack Views
    
    private let contentStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [])
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let fieldsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 22
        stack.distribution = .fill
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let buttonsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fill
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupView()
        setupActions()
        setupConstraints()
        
        navigationItem.hidesBackButton = true
    }
    
    // MARK: - Setup Methods
    
    private func setupView() {
        // ScrollView setup
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        // Header
        contentView.addSubview(backButton)
        contentView.addSubview(skipButton)
        contentView.addSubview(contentStack)
        
        // Content
        contentStack.addArrangedSubview(titleLabel)
        contentStack.addArrangedSubview(subtitleLabel)
        
        contentView.addSubview(fieldsStackView)
        fieldsStackView.addArrangedSubview(nameTextField)
        fieldsStackView.addArrangedSubview(emailTextField)
        fieldsStackView.addArrangedSubview(passwordTextField)
        
        // Buttons
        contentView.addSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(signUpButton)
        buttonsStackView.addArrangedSubview(orLabel)
        buttonsStackView.addArrangedSubview(facebookButton)
        buttonsStackView.addArrangedSubview(googleButton)
        
        // Footer
        contentView.addSubview(termsLabel)
        
        // Toggle password
        if let toggleButton = passwordTextField.rightView as? UIButton {
            toggleButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        }
    }
    
    private func setupActions() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        skipButton.addTarget(self, action: #selector(skipTapped), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        facebookButton.addTarget(self, action: #selector(facebookTapped), for: .touchUpInside)
        googleButton.addTarget(self, action: #selector(googleTapped), for: .touchUpInside)
    }
    
    // MARK: - Constraints
    
    private func setupConstraints() {
        // ScrollView fills screen
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
       
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backButton.widthAnchor.constraint(equalToConstant: 28),
            backButton.heightAnchor.constraint(equalToConstant: 28),
            
            skipButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            skipButton.widthAnchor.constraint(equalToConstant: 60),
            skipButton.heightAnchor.constraint(equalToConstant: 44),
        
            
            contentStack.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 22),
            contentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            contentStack.trailingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            contentStack.widthAnchor.constraint(equalTo: view.widthAnchor),
        
            
            fieldsStackView.topAnchor.constraint(equalTo: contentStack.bottomAnchor, constant: 22),
            fieldsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            fieldsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            fieldsStackView.widthAnchor.constraint(equalToConstant: 343),
            
            
            nameTextField.widthAnchor.constraint(equalTo:fieldsStackView.widthAnchor),
            emailTextField.widthAnchor.constraint(equalTo:fieldsStackView.widthAnchor),
            passwordTextField.widthAnchor.constraint(equalTo:fieldsStackView.widthAnchor),
            
            nameTextField.heightAnchor.constraint(equalToConstant: 60),
            emailTextField.heightAnchor.constraint(equalToConstant: 60),
            passwordTextField.heightAnchor.constraint(equalToConstant: 60),
            
            
            
            // Высота определяется контентом (Auto Layout)
        
            
            buttonsStackView.topAnchor.constraint(equalTo: fieldsStackView.bottomAnchor, constant: 32),
            buttonsStackView.leadingAnchor.constraint(equalTo:view.leadingAnchor,constant: 16),
            buttonsStackView.trailingAnchor.constraint(equalTo:view.trailingAnchor,constant: -16),
            buttonsStackView.widthAnchor.constraint(equalToConstant: 343),
            
            signUpButton.widthAnchor.constraint(equalTo: buttonsStackView.widthAnchor),
            facebookButton.widthAnchor.constraint(equalTo: buttonsStackView.widthAnchor),
            googleButton.widthAnchor.constraint(equalTo: buttonsStackView.widthAnchor),
            
            signUpButton.heightAnchor.constraint(equalToConstant: 58),
            facebookButton.heightAnchor.constraint(equalToConstant: 60),
            googleButton.heightAnchor.constraint(equalToConstant: 58),
            
        
            
            termsLabel.topAnchor.constraint(equalTo: buttonsStackView.bottomAnchor, constant: 32),
            termsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 23),
            termsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -23),
            termsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    // MARK: - Factory Methods (AttributedString)
    
    private func createTitleAttributedString() -> NSAttributedString {
        let text = "Let's start here"
        let font = AppFont.interBold24()
        let letterSpacing: CGFloat = -0.1394
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        paragraphStyle.lineSpacing = 0
        
        return NSAttributedString(string: text, attributes: [
            .font: font,
            .kern: letterSpacing,
            .foregroundColor: AppColor.textColor,
            .paragraphStyle: paragraphStyle
        ])
    }
    
    private func createSubtitleAttributedString() -> NSAttributedString {
        let text = "Fill in your details to begin"
        let font = AppFont.interSemibold18()
        let letterSpacing: CGFloat = -0.0697
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        paragraphStyle.lineSpacing = 0
        
        return NSAttributedString(string: text, attributes: [
            .font: font,
            .kern: letterSpacing,
            .foregroundColor: AppColor.textSecondary,
            .paragraphStyle: paragraphStyle
        ])
    }
    
    private func createTermsAttributedString() -> NSAttributedString {
        let fullText = "Войти в систему означает мое согласие с Условиями использования и Политикой конфиденциальности."
        let attributedString = NSMutableAttributedString(string: fullText)
        
        // Базовый стиль
        attributedString.addAttribute(.foregroundColor, value: AppColor.iconColor, range: NSRange(location: 0, length: fullText.count))
        
        // Ссылки
        let links = ["Условиями использования", "Политикой конфиденциальности"]
        for link in links {
            if let range = fullText.range(of: link) {
                let nsRange = NSRange(range, in: fullText)
                attributedString.addAttributes([
                    .foregroundColor: AppColor.primary,
                    .underlineStyle: NSUnderlineStyle.single.rawValue,
                    .link: "https://example.com/terms"
                ], range: nsRange)
            }
        }
        
        return attributedString
    }
    
    // MARK: - Actions
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func skipTapped() {
        print("Skip tapped")
        let tabBarVC = MainTabBarController()
        tabBarVC.modalPresentationStyle = .fullScreen
        present(tabBarVC, animated: true)
    }
    
    @objc private func signUpTapped() {
        print("✅ Sign Up tapped — загружаем из Storyboard")
        
       
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let signInVC = storyboard.instantiateViewController(withIdentifier: "SignInVC") as? SignInViewController else {
            print(" Ошибка: не найден экран с Storyboard ID = 'SignInVC'")
            return
        }
        
        signInVC.modalPresentationStyle = .fullScreen
        present(signInVC, animated: true)
    }
    
    @objc private func facebookTapped() {
        print("Facebook tapped")
    }
    
    @objc private func googleTapped() {
        print("Google tapped")
    }
    
    @objc private func togglePasswordVisibility() {
        isPasswordVisible.toggle()
        passwordTextField.isSecureTextEntry = !isPasswordVisible
        
        if let toggleButton = passwordTextField.rightView as? UIButton {
            let imageName = isPasswordVisible ? "eye.fill" : "eye.slash"
            toggleButton.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
}
