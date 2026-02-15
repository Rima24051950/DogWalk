//
//  ViewController.swift
//  DogWalk
//
//  Created by MacBook on 30.01.2026.
//
import UIKit

class ViewController: UIViewController {
    
    // Добавьте этот метод в класс ViewController
    @objc private func joinTapped() {
       
        let signUpVC = SignupViewController()
        
        //  Переход через навигационный стек
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    
    // MARK: - UI Elements
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "onbordingImage")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    private let gradientLayer = CAGradientLayer()
      
        
    private let pawcImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "paws")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let wooDogImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "woo dog")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    
    // Шаги 1, 2, 3 (круги)
    private let step1View: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemOrange.cgColor
        return view
    }()
    
    private let step2View: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.backgroundColor = .background
        return view
    }()
    
    private let step3View: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.backgroundColor = .background
        return view
    }()
    
    // Цифры внутри кругов
    private let step1Label: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let step2Label: UILabel = {
        let label = UILabel()
        label.text = "2"
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let step3Label: UILabel = {
        let label = UILabel()
        label.text = "3"
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Дефисы между шагами
    private let dash1Label: UILabel = {
        let label = UILabel()
        label.text = "—"
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dash2Label: UILabel = {
        let label = UILabel()
        label.text = "—"
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
      //  label.text = "Too tired to walk your dog? Let's help you!"
      //  label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
      //  label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        //label.translatesAutoresizingMaskIntoConstraints = false
        

   // Полный текст из дизайна
        let text = "Too tired to walk your dog?\nLet's help you!"
            
            // 1. Загружаем шрифт Poppins-Bold (вес 700)
            guard let font = UIFont(name: "Poppins-Bold", size: 22) else {
                // Запасной вариант, если шрифт не загружен
                label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
                label.text = text
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }
            
            // 2. Рассчитываем межбуквенный интервал: -0.41% от 22pt
            // Формула: (значение в % / 100) * размер шрифта
            let letterSpacing: CGFloat = (-0.41 / 100) * 22 // = -0.0902
            
            // 3. Создаём атрибутированный текст
            let attributedString = NSMutableAttributedString(string: text)
            
            // Применяем шрифт ко всему тексту
            attributedString.addAttribute(
                .font,
                value: font,
                range: NSRange(location: 0, length: text.count)
            )
            
            // Применяем межбуквенный интервал (kerning)
            attributedString.addAttribute(
                .kern,
                value: letterSpacing, // Отрицательное значение = сжатие букв
                range: NSRange(location: 0, length: text.count)
            )
            
            // 4. Устанавливаем атрибутированный текст
            label.attributedText = attributedString
            label.translatesAutoresizingMaskIntoConstraints = false
        
        
            return label
        }()
        
    
    private let joinButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Join our community", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.layer.cornerRadius = 14
        button.backgroundColor = UIColor.systemOrange
        return button
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false

        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.backgroundColor = UIColor(white: 1, alpha: 0.1)
        button.layer.cornerRadius = 12
        
        
        // Создаём атрибутированный текст
            let fullText = "Already a member? Sign in"
            let attributedString = NSMutableAttributedString(string: fullText)
        
       // Применяем белый цвет ко всему тексту
        attributedString.addAttribute(
                .foregroundColor,
                value: UIColor.white,
                range: NSRange(location: 0, length: fullText.count)
            )
            
        if let signInRange = fullText.range(of: "Sign in") {
            let nsRange = NSRange(signInRange, in: fullText)
            attributedString.addAttribute(
                .foregroundColor,
                value: UIColor.systemOrange,
                range: nsRange
            )
            
        }
        
        button.setAttributedTitle(attributedString, for: .normal)
           // Фон и закругление
           button.backgroundColor = UIColor(white: 1, alpha: 0.1)
           button.layer.cornerRadius = 12
        
        return button
    }()
    
    // MARK: - Constraints to update on rotation
    private var bottomOffsetConstraint: NSLayoutConstraint!
    private var joinButtonHeightConstraint: NSLayoutConstraint!
    private var signInButtonHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        setupBackground()
        setupUI()
        setupConstraints()
        
        
        // Обработчики кнопок
        joinButton.addTarget(self, action: #selector(joinTapped), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
      //  signTapped.addTarget(self, action: #selector(signTapped), for: .touchUpInside)
       }
    
    
    // MARK: - Setup Background
    
    private func setupBackground() {
        view.insertSubview(backgroundImageView, at: 0)
        view.addSubview(pawcImageView)
        view.addSubview(wooDogImageView)
        
        // КОНСТРЕЙНТЫ ДЛЯ ФОНА (заполняет весь экран)
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        
            pawcImageView.widthAnchor.constraint(equalToConstant: 40),
             
            pawcImageView.heightAnchor.constraint(equalToConstant: 40),
                
            pawcImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 45),
                
                // Отступ слева = 16 (от безопасной зоны)
            pawcImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            wooDogImageView.widthAnchor.constraint(equalToConstant: 59),
                
                // Высота = 36
            wooDogImageView.heightAnchor.constraint(equalToConstant: 36),
                
                // Отступ сверху = 47 (от безопасной зоны!)
            wooDogImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 47),
                
                // Отступ слева = 58 (от безопасной зоны!)
            wooDogImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 58)
            ])
        
    }
    

    // MARK: - Setup UI
    
    private func setupUI() {
        // Добавляем цифры в круги
        [ (step1View, step1Label), (step2View, step2Label), (step3View, step3Label) ].forEach { view, label in
            view.addSubview(label)
        }
        
        // Стек шагов (1 — 2 — 3)
        let stepsStack = UIStackView(arrangedSubviews: [step1View, dash1Label, step2View, dash2Label, step3View])
        stepsStack.axis = .horizontal
        stepsStack.spacing = 8
        stepsStack.alignment = .center
        stepsStack.translatesAutoresizingMaskIntoConstraints = false
        
        // Сохраняем для изменения при повороте
        self.stepsStack = stepsStack
        
        // Текстовый стек
        let textStack = UIStackView(arrangedSubviews: [stepsStack, titleLabel])
        textStack.axis = .vertical
        textStack.spacing = 16
        textStack.alignment = .center
        textStack.translatesAutoresizingMaskIntoConstraints = false
        
        // Сохраняем для изменения при повороте
        self.textStack = textStack
        
        // Стек кнопок
        let buttonsStack = UIStackView(arrangedSubviews: [joinButton, signInButton])
        buttonsStack.axis = .vertical
        buttonsStack.spacing = 16
        buttonsStack.distribution = .fillEqually
        buttonsStack.translatesAutoresizingMaskIntoConstraints = false
        
        // Сохраняем для изменения при повороте
        self.buttonsStack = buttonsStack
        
        // Основной контейнер
        let bottomContainer = UIStackView(arrangedSubviews: [textStack, buttonsStack])
        bottomContainer.axis = .vertical
        bottomContainer.spacing = 32
        bottomContainer.alignment = .center
        bottomContainer.translatesAutoresizingMaskIntoConstraints = false
        
        // Сохраняем для изменения при повороте
        self.bottomContainer = bottomContainer
        
        // Добавляем в иерархию
        view.addSubview(bottomContainer)
    }
    
    // MARK: - Constraints
    
    private var bottomContainer: UIStackView!
    private var stepsStack: UIStackView!
    private var textStack: UIStackView!
    private var buttonsStack: UIStackView!
    
    private func setupConstraints() {
        // Констрейнты для кругов
        [step1View, step2View, step3View].forEach { view in
            NSLayoutConstraint.activate([
                view.widthAnchor.constraint(equalToConstant: 32),
                view.heightAnchor.constraint(equalToConstant: 32)
            ])
        }
        
        // Констрейнты для цифр внутри кругов
        [ (step1View, step1Label), (step2View, step2Label), (step3View, step3Label) ].forEach { parent, label in
            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: parent.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: parent.centerYAnchor)
            ])
        }
        
        //  СОХРАНЯЕМ КОНСТРЕЙНТЫ ДЛЯ ИЗМЕНЕНИЯ ПРИ ПОВОРОТЕ
        bottomOffsetConstraint = bottomContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        joinButtonHeightConstraint = joinButton.heightAnchor.constraint(equalToConstant: 58)
        signInButtonHeightConstraint = signInButton.heightAnchor.constraint(equalToConstant: 20)
        joinButtonHeightConstraint = joinButton.widthAnchor.constraint(equalToConstant: 324)
        signInButtonHeightConstraint = signInButton.widthAnchor.constraint(equalToConstant: 332)
        
        // Активируем все констрейнты
        NSLayoutConstraint.activate([
            // Фон уже настроен в setupBackground()
            
            // Центрирование по горизонтали
            bottomContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Отступ снизу (сохранённый для изменения)
            bottomOffsetConstraint,
            
            // Боковые отступы
            bottomContainer.leadingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            bottomContainer.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            
            // Максимальная ширина
            bottomContainer.widthAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            
            // Высота кнопок (сохранённые для изменения)
            joinButtonHeightConstraint,
            signInButtonHeightConstraint
        ])
    }
    
    // MARK: - Rotation Handling
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        let isLandscape = size.width > size.height
        
        coordinator.animate(alongsideTransition: { _ in
            self.updateLayoutForOrientation(isLandscape: isLandscape)
        }, completion: nil)
    }
    
    private func updateLayoutForOrientation(isLandscape: Bool) {
        // 1. Изменяем отступ снизу
        bottomOffsetConstraint.constant = isLandscape ? -32 : -40
        
        // 2. Изменяем высоту кнопок
        let buttonHeight: CGFloat = isLandscape ? 48 : 56
        joinButtonHeightConstraint.constant = buttonHeight
        signInButtonHeightConstraint.constant = buttonHeight
        
        // 3. Изменяем размер шрифта заголовка
        titleLabel.font = UIFont.systemFont(ofSize: isLandscape ? 18 : 20, weight: .bold)
        //subtitleLabel.font = UIFont.systemFont(ofSize: isLandscape ? 16 : 18, weight: .semibold)
        
        // 4. Изменяем размер шрифта кнопок
        joinButton.titleLabel?.font = UIFont.systemFont(ofSize: isLandscape ? 16 : 18, weight: .semibold)
        signInButton.titleLabel?.font = UIFont.systemFont(ofSize: isLandscape ? 14 : 16, weight: .regular)
        
        // 5. Изменяем отступы в стеках
        stepsStack.spacing = isLandscape ? 12 : 8
        textStack.spacing = isLandscape ? 12 : 16
        buttonsStack.spacing = isLandscape ? 12 : 16
        bottomContainer.spacing = isLandscape ? 24 : 32
        
        // 6. Обновляем макет
        view.layoutIfNeeded()
    }
    
    // MARK: - Actions
 
    
    @objc private func signInTapped() {
        print("Sign In tapped")
    }
}
