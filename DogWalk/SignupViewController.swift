//
//  SignupViewController.swift
//  DogWalk
//
//  Created by MacBook on 06.02.2026.
//

import UIKit


final class SignupViewController: UIViewController {
    
    // MARK: - UIScrollView & ContentView
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = true  // ✅ Показывать полосу прокрутки
        scrollView.keyboardDismissMode = .interactive
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - UI Elements
    
    private let contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 22
        stack.alignment = .leading
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Arrow - Left 2"), for: .normal)
        button.tintColor = AppColor.color
        
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 28),
            button.heightAnchor.constraint(equalToConstant: 28)
        ])
        
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Let's start here"
        label.textAlignment = .center
        label.textColor = AppColor.textColor
        label.numberOfLines = 0
        
        // ✅ Используем Inter Bold 34pt через AppFont
        let font = AppFont.interBold24()
        let letterSpacing: CGFloat = -0.1394
        
        let attributedString = NSMutableAttributedString(string: label.text!)
        attributedString.addAttributes([
            .font: font,
            .kern: letterSpacing,
            .foregroundColor: AppColor.textColor
        ], range: NSRange(location: 0, length: label.text!.count))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 0
        paragraphStyle.alignment = .center
        attributedString.addAttribute(
            .paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: label.text!.count)
        )
        
        label.attributedText = attributedString
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Fill in your details to begin"
        label.textAlignment = .center
        label.textColor = AppColor.textSecondary
        
        // ✅ Inter Semibold 18pt
        let font = AppFont.interSemibold18()
        let letterSpacing: CGFloat = -0.0697
        
        let attributedString = NSMutableAttributedString(string: label.text!)
        attributedString.addAttributes([
            .font: font,
            .kern: letterSpacing,
            .foregroundColor: AppColor.textSecondary
        ], range: NSRange(location: 0, length: label.text!.count))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 0
        paragraphStyle.alignment = .center
        attributedString.addAttribute(
            .paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: label.text!.count)
        )
        
        label.attributedText = attributedString
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .center
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Input Fields Stack
    
    private let fieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 22
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Full Name"
        textField.font = AppFont.interRegular18()  // ✅ 16pt Regular
        textField.textColor = AppColor.textColor
        textField.backgroundColor = AppColor.backgroundInput
        textField.layer.cornerRadius = 14
        textField.leftViewMode = .always
        textField.autocapitalizationType = .words
        textField.autocorrectionType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.widthAnchor.constraint(equalToConstant: 343),
            textField.heightAnchor.constraint(equalToConstant: 60)
        ])
        return textField
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email Address"
        textField.font = AppFont.interRegular18()  // ✅ 16pt Regular
        textField.textColor = AppColor.textColor  // ✅ Исправлено
        textField.backgroundColor = AppColor.backgroundInput
        textField.layer.cornerRadius = 14
        textField.leftViewMode = .always
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.keyboardType = .emailAddress
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.widthAnchor.constraint(equalToConstant: 343),
            textField.heightAnchor.constraint(equalToConstant: 60)
        ])
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.font = AppFont.interRegular18()  // ✅ 16pt Regular
        textField.textColor = AppColor.textColor
        textField.backgroundColor = AppColor.backgroundInput
        textField.layer.cornerRadius = 14
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.leftViewMode = .always
        textField.isSecureTextEntry = true
        textField.keyboardType = .default
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        let toggleButton = UIButton(type: .system)
        toggleButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        toggleButton.tintColor = AppColor.iconColor
        toggleButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        toggleButton.contentMode = .center
        
        textField.rightView = toggleButton
        textField.rightViewMode = .always
        
        toggleButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            textField.widthAnchor.constraint(equalToConstant: 343),
            textField.heightAnchor.constraint(equalToConstant: 58)
        ])
        return textField
    }()
    
    // MARK: - Buttons Stack
    
    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = AppFont.interSemibold18()  // ✅ 18pt Semibold
        button.backgroundColor = AppColor.primary
        button.layer.cornerRadius = 14
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 60)
        ])
        return button
    }()
    
    private let orLabel: UILabel = {
        let label = UILabel()
        label.text = "or"
        label.font = AppFont.interMedium18()  // ✅ 16pt Medium
        label.textColor = AppColor.textColor
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let facebookButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Connect with Facebook", for: .normal)
        button.setTitleColor(UIColor(named: "surfase"), for: .normal)
        button.titleLabel?.font = AppFont.interSemibold18()  // ✅ 18pt Semibold
        button.backgroundColor = AppColor.facebookround
        button.layer.cornerRadius = 14
        button.clipsToBounds = true
        
        let iconContainer = UIView()
        iconContainer.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(iconContainer)
        
        let iconView = UIImageView()
        iconView.image = AppImage.facebook.image
        iconView.contentMode = .scaleAspectFit
        iconView.clipsToBounds = true
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconContainer.addSubview(iconView)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 343),
            button.heightAnchor.constraint(equalToConstant: 60),
            
            iconContainer.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 21),
            iconContainer.topAnchor.constraint(equalTo: button.topAnchor, constant: 18),
            iconContainer.widthAnchor.constraint(equalToConstant: 24),
            iconContainer.heightAnchor.constraint(equalToConstant: 24),
            
            iconView.centerXAnchor.constraint(equalTo: iconContainer.centerXAnchor),
            iconView.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),
        ])
        
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 57, bottom: 0, right: 20)
        
        return button
    }()
    
    private let googleButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = AppColor.backgroundInput
        button.layer.cornerRadius = 14
        button.clipsToBounds = true
        
        let googleIcon = UIImageView()
        googleIcon.image = AppImage.googleLogo.image
        googleIcon.contentMode = .scaleAspectFit
        googleIcon.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(googleIcon)
        
        button.setTitle("Connect with Google", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = AppFont.interSemibold18()  // ✅ 18pt Semibold
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            googleIcon.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 21),
            googleIcon.topAnchor.constraint(equalTo: button.topAnchor, constant: 18),
            googleIcon.widthAnchor.constraint(equalToConstant: 24),
            googleIcon.heightAnchor.constraint(equalToConstant: 24),
            googleIcon.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            
            button.widthAnchor.constraint(equalToConstant: 343),
            button.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 57, bottom: 0, right: 20)
        
        return button
    }()
    
    // MARK: - Terms Label
    
    private let termsLabel: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.backgroundColor = .clear
        textView.textAlignment = .center
        textView.font = AppFont.interRegular18()  // ✅ 16pt Regular
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        let fullText = "Войти в систему означает мое согласие с Условиями использования и Политикой конфиденциальности."
        
        let termsRange = (fullText as NSString).range(of: "Условиями использования")
        let privacyRange = (fullText as NSString).range(of: "Политикой конфиденциальности")
        
        let attributedString = NSMutableAttributedString(string: fullText)
        
        attributedString.addAttribute(
            .foregroundColor,
            value: AppColor.iconColor,
            range: NSRange(location: 0, length: fullText.count)
        )
        
        [termsRange, privacyRange].forEach { range in
            attributedString.addAttribute(
                .foregroundColor,
                value: AppColor.primary,  // ✅ Оранжевый для ссылок
                range: range
            )
            attributedString.addAttribute(
                .underlineStyle,
                value: NSUnderlineStyle.single.rawValue,
                range: range
            )
            attributedString.addAttribute(
                .link,
                value: "https://example.com/terms",
                range: range
            )
        }
        
        textView.attributedText = attributedString
        textView.linkTextAttributes = [
            .foregroundColor: AppColor.primary,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        
        return textView
    }()
    
    // MARK: - Lifecycle
    
    
    
    // MARK: - Кнопка перехода
    
    private let skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.titleLabel?.font = AppFont.interSemibold18()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupScrollView()
        setupUI()
        setupConstraints()
        setupActions()
        navigationItem.hidesBackButton = true
        
    }
    
    // MARK: - Setup Methods
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        //contentView.addSubview(contentStack)
        
        // ✅ ВАЖНО: contentView должен быть прикреплён ко всем 4 сторонам scrollView
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            // ✅ ВАЖНО: ширина contentView = ширина view (чтобы скролл был только вертикальный)
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    private func setupUI() {
        // Добавляем back button в contentView (не в scrollView напрямую!)
        contentView.addSubview(backButton)
        contentView.addSubview(termsLabel)
        
        textStack.addArrangedSubview(titleLabel)
        textStack.addArrangedSubview(subtitleLabel)
        
        contentStack.addArrangedSubview(titleLabel)
        contentStack.addArrangedSubview(subtitleLabel)
        contentView.addSubview(contentStack)
        
        [nameTextField, emailTextField, passwordTextField].forEach {
            fieldsStackView.addArrangedSubview($0)
        }
        contentView.addSubview(fieldsStackView)
        
        buttonsStackView.addArrangedSubview(signUpButton)
        buttonsStackView.addArrangedSubview(orLabel)
        buttonsStackView.addArrangedSubview(facebookButton)
        buttonsStackView.addArrangedSubview(googleButton)
        contentView.addSubview(buttonsStackView)
        
        view.addSubview(skipButton)
    }
    
    private func setupConstraints() {
        // ✅ scrollView на весь экран
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // ✅ back button
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 16),
            backButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])
        
        // ✅ contentStack (заголовок + подзаголовок)
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 24),
            contentStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentStack.widthAnchor.constraint(equalToConstant: 264)
        ])
        
        // ✅ fieldsStackView (поля ввода)
        NSLayoutConstraint.activate([
            fieldsStackView.topAnchor.constraint(equalTo: contentStack.bottomAnchor, constant: 32),
            fieldsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 14),
            fieldsStackView.widthAnchor.constraint(equalToConstant: 343)
        ])
        
        // ✅ buttonsStackView (кнопки)
        NSLayoutConstraint.activate([
            buttonsStackView.topAnchor.constraint(equalTo: fieldsStackView.bottomAnchor, constant: 32),
            buttonsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            buttonsStackView.widthAnchor.constraint(equalToConstant: 343)
        ])
        
        // ✅ termsLabel (внизу)
        NSLayoutConstraint.activate([
            termsLabel.topAnchor.constraint(equalTo: buttonsStackView.bottomAnchor, constant: 32),
            termsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 23),
            termsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -23),
            termsLabel.widthAnchor.constraint(equalToConstant: 329),
            termsLabel.heightAnchor.constraint(equalToConstant: 55),
            termsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)  // ✅ Отступ снизу для скролла
        ])
        
        
        NSLayoutConstraint.activate([
            skipButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            skipButton.widthAnchor.constraint(equalToConstant: 60),
            skipButton.heightAnchor.constraint(equalToConstant: 44)
            
        ])
    }
    
    
    private func setupActions() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        facebookButton.addTarget(self, action: #selector(facebookTapped), for: .touchUpInside)
        googleButton.addTarget(self, action: #selector(googleTapped), for: .touchUpInside)
        skipButton.addTarget(self, action: #selector (skipTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func signUpTapped() {
        print("✅ Sign Up tapped")
    }
    
    @objc private func facebookTapped() {
        print("✅ Facebook tapped")
    }
    
    @objc private func googleTapped() {
        print("✅ Google tapped")
    }
    
    
    @objc private func skipTapped () {
        print ("Skip tapped")
        let tabBarVC = MainTabBarController()
        tabBarVC.modalPresentationStyle = .fullScreen
        tabBarVC.modalTransitionStyle = .coverVertical  // или .crossDissolve
        
        present(tabBarVC, animated: true)
        
        
        
        
    }
    
    @objc private func togglePasswordVisibility() {
        passwordTextField.isSecureTextEntry.toggle()
        
        if let toggleButton = passwordTextField.rightView as? UIButton {
            let imageName = passwordTextField.isSecureTextEntry ? "eye.slash" : "eye.fill"
            toggleButton.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
}
