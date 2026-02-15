//
//  SignupViewController.swift
//  DogWalk
//
//  Created by MacBook on 06.02.2026.
//

import UIKit

class SignupViewController: UIViewController {
    
    // MARK: - UI Elements
    // MARK: Header Stack (стрелка + 2 лейбла
    private let contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 22 // ← GAP между элементами как в дизайне
        stack.alignment = .leading
        stack.distribution = .fill // элементы заполняют доступное пространство
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Arrow - Left 2"), for: .normal)
        button.tintColor = .black
        
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 28),
            button.heightAnchor.constraint(equalToConstant: 28)
        ])
        
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Let’s start here"
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        
        // 1. Загружаем шрифт Poppins Bold (вес 700)
        guard let font = UIFont(name: "Poppins-Bold", size: 34) else {
            // Запасной вариант: системный шрифт
            label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }
        
        // 2. Рассчитываем межбуквенный интервал: -0.41% от 34 = -0.1394
        let letterSpacing: CGFloat = -0.1394
        
        // 3. Создаём атрибутированный текст
        let attributedString = NSMutableAttributedString(string: label.text!)
        
        // Применяем шрифт
        attributedString.addAttribute(
            .font,
            value: font,
            range: NSRange(location: 0, length: label.text!.count)
        )
        
        // Применяем межбуквенный интервал
        attributedString.addAttribute(
            .kern,
            value: letterSpacing,
            range: NSRange(location: 0, length: label.text!.count)
        )
        
        // 4. Настройка межстрочного интервала (line-height: 100%)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 0 // 100% = нет дополнительного интервала
        paragraphStyle.alignment = .center
        attributedString.addAttribute(
            .paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: label.text!.count)
        )
        
        // 5. Устанавливаем атрибутированный текст
        label.attributedText = attributedString
        label.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            label.widthAnchor.constraint(equalToConstant: 264),
//            label.heightAnchor.constraint(equalToConstant: 51)
//        ])
        
        return label
    }()
    
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Fill in your details to begin"
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textAlignment = .left
        label.textColor = UIColor(named: "iconColor")
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        let letterSpacing: CGFloat = -0.0697
        
        let attributedString = NSMutableAttributedString(string: label.text!)
        attributedString.addAttribute(.kern, value: letterSpacing, range: NSRange(location: 0, length: label.text!.count))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 0
        paragraphStyle.alignment = .center
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: label.text!.count))
        
        label.attributedText = attributedString
        
//        // Фиксируем размер лейбла
//        NSLayoutConstraint.activate([
//            label.widthAnchor.constraint(equalToConstant: 249),
//            label.heightAnchor.constraint(equalToConstant: 26)
//        ])
        
        return label
    }()
    
    private let textStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8 // ← подобрано для общей высоты 77pt
        stack.alignment = .center
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: Input Fields Stack
    private let fieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 22 // gap между полями
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Full Name"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .black
        textField.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        textField.layer.cornerRadius = 14
        // textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 343, height: 60))
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
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .black
        textField.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        textField.layer.cornerRadius = 14
        //textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
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
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .black
        textField.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        textField.layer.cornerRadius = 14
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.leftViewMode = .always
        textField.isSecureTextEntry = true // Скрытие символов пароля
        textField.keyboardType = .default
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        let toggleButton = UIButton(type: .system)
        toggleButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        toggleButton.tintColor = UIColor(named: "iconColor")
        toggleButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        toggleButton.contentMode = .center
        
        // Добавляем кнопку как rightView
        textField.rightView = toggleButton
        textField.rightViewMode = .always
        
        toggleButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        NSLayoutConstraint.activate([
            textField.widthAnchor.constraint(equalToConstant: 343),
            textField.heightAnchor.constraint(equalToConstant: 58)
        ])
        return textField
    }()
    
    // MARK: Buttons Stack
    
    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10 // 🔑 gap: 10px между элементами
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.backgroundColor = UIColor.systemOrange
        button.layer.cornerRadius = 14
        button.clipsToBounds = true
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let orLabel: UILabel = {
        let label = UILabel()
        label.text = "or"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor(named: "textColor")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let facebookButton: UIButton = {
        let button = UIButton(type: .system)
        
        // 1. Настройка кнопки
        button.setTitle("Connect with Facebook", for: .normal) // ← Без лишнего пробела в начале!
        button.setTitleColor(UIColor(named: "surfase"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.backgroundColor = UIColor(named: "secodary")
        button.layer.cornerRadius = 14
        button.clipsToBounds = true
        
        // 2. Контейнер для иконки 24×24
        let iconContainer = UIView()
        iconContainer.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(iconContainer)
        
        // 3. Иконка внутри контейнера
        let iconView = UIImageView()
        iconView.image = UIImage(named: "facebook")
        iconView.contentMode = .scaleAspectFit
        iconView.clipsToBounds = true
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconContainer.addSubview(iconView)
        
        // 4.  КОНСТРЕЙНТЫ (без привязки к titleLabel!)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Размеры кнопки
            button.widthAnchor.constraint(equalToConstant: 343),
            button.heightAnchor.constraint(equalToConstant: 60),
            
            // Иконка: 24×24
            iconContainer.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 21),
            iconContainer.topAnchor.constraint(equalTo: button.topAnchor, constant: 18),
            iconContainer.widthAnchor.constraint(equalToConstant: 24),
            iconContainer.heightAnchor.constraint(equalToConstant: 24),
            
            // Центрирование иконки внутри контейнера
            iconView.centerXAnchor.constraint(equalTo: iconContainer.centerXAnchor),
            iconView.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),
            
        ])
        
        // 5.  ОТСТУП ТЕКСТА
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 57, bottom: 0, right: 20)
        
        return button
    }()
    
    
    private let googleButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        button.layer.cornerRadius = 14
        button.clipsToBounds = true
        
        // 1. Иконка Google (24×24)
        let googleIcon = UIImageView()
        googleIcon.image = UIImage(named: "google-logo")
        googleIcon.contentMode = .scaleAspectFit // Сохраняем пропорции иконки
        googleIcon.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(googleIcon)
        
        // 2. Текст кнопки
        button.setTitle("Connect with Google", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        
        //  констрейнты ДЛЯ САМОЙ КНОПКИ
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // 4. КОНСТРЕЙНТЫ ВНУТРИ КНОПКИ
        NSLayoutConstraint.activate([
            // Иконка: 24×24, отступы как в дизайне (top: 18px, left: 21px)
            googleIcon.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 21),
            googleIcon.topAnchor.constraint(equalTo: button.topAnchor, constant: 18), // ← Исправлено: 18 вместо 87!
            googleIcon.widthAnchor.constraint(equalToConstant: 24),
            googleIcon.heightAnchor.constraint(equalToConstant: 24),
            
            // Центрируем иконку по вертикали внутри кнопки
            googleIcon.centerYAnchor.constraint(equalTo: button.centerYAnchor)
        ])
        
        // 5. ОТСТУПЫ ДЛЯ ТЕКСТА (вместо прямого констрейнта на titleLabel)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 57, bottom: 0, right: 20)
        // 57 = 21 (левый отступ) + 24 (ширина иконки) + 12 (промежуток)
        
        // 6.  ФИКСИРОВАННЫЕ РАЗМЕРЫ КНОПКИ (343×60)
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 343),
            button.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        return button
    }()
    
    // MARK: By signing in
    
    private let termsLabel: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false // Отключаем скролл для компактности
        textView.isEditable = false // Делаем только для чтения
        textView.backgroundColor = .clear // Прозрачный фон
        textView.textAlignment = .center
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        // Создаём атрибутированный текст с кликабельными ссылками
        let fullText = "Войти в систему означает мое согласие с Условиями использования и Политикой конфиденциальности."
        
        // Диапазоны для кликабельных частей
        let termsRange = (fullText as NSString).range(of: "Условиями использования")
        let privacyRange = (fullText as NSString).range(of: "Политикой конфиденциальности")
        
        let attributedString = NSMutableAttributedString(string: fullText)
        
        // Обычный текст — серый цвет
        attributedString.addAttribute(
            .foregroundColor,
            value: UIColor(named: "iconColor"),
            range: NSRange(location: 0, length: fullText.count)
        )
        
        // Ссылки — оранжевый цвет + подчёркивание
        [termsRange, privacyRange].forEach { range in
            attributedString.addAttribute(
                .foregroundColor,
                value: UIColor(named: "textColor"),
                range: range
            )
            attributedString.addAttribute(
                .underlineStyle,
                value: NSUnderlineStyle.single.rawValue,
                range: range
            )
            // Добавляем атрибут ссылки для интерактивности
            attributedString.addAttribute(
                .link,
                value: "https://example.com/terms", // Замените на реальные URL
                range: range
            )
        }
        
        textView.attributedText = attributedString
        textView.linkTextAttributes = [
            .foregroundColor: UIColor(named: "textColor"),
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        
        return textView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(backButton)
        view.addSubview(termsLabel)
        
        textStack.addArrangedSubview(titleLabel)
        textStack.addArrangedSubview(subtitleLabel)
        
        
        [titleLabel, subtitleLabel].forEach {
            contentStack.addArrangedSubview($0)
        }
        view.addSubview(contentStack)
        
        
        [nameTextField, emailTextField, passwordTextField].forEach {
            fieldsStackView.addArrangedSubview($0)
        }
        
        view.addSubview(fieldsStackView)
        
        
        buttonsStackView.addArrangedSubview(signUpButton)
        buttonsStackView.addArrangedSubview(orLabel)
        buttonsStackView.addArrangedSubview(facebookButton)
        buttonsStackView.addArrangedSubview(googleButton)
        
        view.addSubview(buttonsStackView)
        
        
        NSLayoutConstraint.activate([
            
            // Фиксированные размеры стека: width: 264, height: 127
            contentStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 45),
            contentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            contentStack.widthAnchor.constraint(equalToConstant: 264),
            //contentStack.heightAnchor.constraint(equalToConstant: 77),
                          //   textStack.heightAnchor.constraint(equalToConstant: 77),
            
            fieldsStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 194),
            fieldsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            fieldsStackView.widthAnchor.constraint(equalToConstant: 343),
            
           // buttonsStackView.heightAnchor.constraint(equalToConstant: 222),
            buttonsStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 438),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonsStackView.widthAnchor.constraint(equalToConstant: 343),
           // buttonsStackView.heightAnchor.constraint(equalToConstant: 232),
            
            
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            
            termsLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 692),
            termsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 23),
            
            // Точные размеры: width: 329, height: 55
            termsLabel.widthAnchor.constraint(equalToConstant: 329),
            termsLabel.heightAnchor.constraint(equalToConstant: 55),
            termsLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
     
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        facebookButton.addTarget(self, action: #selector(facebookTapped), for: .touchUpInside)
        googleButton.addTarget(self, action: #selector(googleTapped), for: .touchUpInside)
    }
    
    
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
        
    }
    
    @objc private func signUpTapped() {
        print("✅ Sign Up tapped")
        // Логика подключения Google
    }
    
    @objc private func facebookTapped() {
        print("✅ Facebook tapped")
        // Логика подключения Facebook
    }
    
    @objc private func googleTapped() {
        print("✅ Google tapped")
    
    }

    @objc private func togglePasswordVisibility() {
        // Переключаем режим отображения
        passwordTextField.isSecureTextEntry.toggle()
        
        // смена иконки
        if let toggleButton = passwordTextField.rightView as? UIButton {
            let imageName = passwordTextField.isSecureTextEntry ? "eye.slash" : "eye.fill"
            toggleButton.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
}
