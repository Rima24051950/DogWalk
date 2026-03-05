//
//  ViewController.swift
//  DogWalk
//
//  Created by MacBook on 30.01.2026.
//
import UIKit


final class OnboardingViewController: UIViewController {
    
    // MARK: - Types (Private nested types)
    
    private enum StepStyle {
        case first
        case other
        
        var backgroundColor: UIColor {
            switch self {
            case .first: return .white
            case .other: return .black
            }
        }
        
        var borderColor: CGColor? {
            switch self {
            case .first: return UIColor.systemOrange.cgColor
            case .other: return nil
            }
        }
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
    
    private let pawsImageView: UIImageView = {
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
    
    // Steps (using factory methods)
    private lazy var step1View = createStepView(style: .first)
    private lazy var step2View = createStepView(style: .other)
    private lazy var step3View = createStepView(style: .other)
    
    // Step labels (using factory methods)
    private lazy var step1Label = createStepLabel(text: "1", textColor: .black)
    private lazy var step2Label = createStepLabel(text: "2", textColor: .white)
    private lazy var step3Label = createStepLabel(text: "3", textColor: .white)
    
    // Dash labels (using factory methods)
    private lazy var dash1Label = createDashLabel()
    private lazy var dash2Label = createDashLabel()
    
    // Title label (using factory method)
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = createTitleAttributedString()
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Buttons
    private let joinButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Join our community", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.layer.cornerRadius = 14
        button.backgroundColor = .systemOrange
        
        return button
    }()
    
    private lazy var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setAttributedTitle(createSignInAttributedString(), for: .normal)
        button.backgroundColor = UIColor(white: 1, alpha: 0.1)
        button.layer.cornerRadius = 12
        return button
    }()
    
    // MARK: - Constraints
    
    private var bottomOffsetConstraint: NSLayoutConstraint!
    private var joinButtonHeightConstraint: NSLayoutConstraint!
    private var signInButtonHeightConstraint: NSLayoutConstraint!
    private var joinButtonWidthConstraint: NSLayoutConstraint!
    private var signInButtonWidthConstraint: NSLayoutConstraint!
    
    // MARK: - Stack Views
    
    private var bottomContainer: UIStackView!
    private var stepsStack: UIStackView!
    private var textStack: UIStackView!
    private var buttonsStack: UIStackView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupActions()
    }
    
    // MARK: - Override Methods
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        let isLandscape = size.width > size.height
        
        coordinator.animate(alongsideTransition: { _ in
            self.updateLayoutForOrientation(isLandscape: isLandscape)
        }, completion: nil)
    }
    
    // MARK: - Setup Methods (Private)
    
    private func setupView() {
        view.backgroundColor = .black
        setupBackground()
        setupUI()
        setupConstraints()
    }
    
    private func setupActions() {
        joinButton.addTarget(self, action: #selector(joinTapped), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
    }
    
    private func setupBackground() {
        view.insertSubview(backgroundImageView, at: 0)
        view.addSubview(pawsImageView)
        view.addSubview(wooDogImageView)
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            pawsImageView.widthAnchor.constraint(equalToConstant: 40),
            pawsImageView.heightAnchor.constraint(equalToConstant: 40),
            pawsImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 45),
            pawsImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            wooDogImageView.widthAnchor.constraint(equalToConstant: 59),
            wooDogImageView.heightAnchor.constraint(equalToConstant: 36),
            wooDogImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 47),
            wooDogImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 58)
        ])
    }
    
    private func setupUI() {
        // Add labels to step views
        zip([step1View, step2View, step3View], [step1Label, step2Label, step3Label])
            .forEach { $0.addSubview($1) }
        
        // Steps stack: 1 — 2 — 3
        stepsStack = UIStackView(arrangedSubviews: [step1View, dash1Label, step2View, dash2Label, step3View])
        stepsStack.axis = .horizontal
        stepsStack.spacing = 8
        stepsStack.alignment = .center
        stepsStack.translatesAutoresizingMaskIntoConstraints = false
        
        // Text stack: steps + title
        textStack = UIStackView(arrangedSubviews: [stepsStack, titleLabel])
        textStack.axis = .vertical
        textStack.spacing = 22
        textStack.alignment = .center
        textStack.translatesAutoresizingMaskIntoConstraints = false
        
        // Buttons stack
        buttonsStack = UIStackView(arrangedSubviews: [joinButton, signInButton])
        buttonsStack.axis = .vertical
        buttonsStack.spacing = 16
        buttonsStack.distribution = .fill
        buttonsStack.alignment = .fill
        buttonsStack.translatesAutoresizingMaskIntoConstraints = false
        
        // Main bottom container
        bottomContainer = UIStackView(arrangedSubviews: [textStack, buttonsStack])
        bottomContainer.axis = .vertical
        bottomContainer.spacing = 32
        bottomContainer.alignment = .center
        bottomContainer.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(bottomContainer)
    }
    
    private func setupConstraints() {
        // Step views constraints
        [step1View, step2View, step3View].forEach { view in
            NSLayoutConstraint.activate([
                view.widthAnchor.constraint(equalToConstant: 32),
                view.heightAnchor.constraint(equalToConstant: 32)
            ])
        }
        
        // Labels centered in step views
        zip([step1View, step2View, step3View], [step1Label, step2Label, step3Label])
            .forEach { parent, label in
                NSLayoutConstraint.activate([
                    label.centerXAnchor.constraint(equalTo: parent.centerXAnchor),
                    label.centerYAnchor.constraint(equalTo: parent.centerYAnchor)
                ])
            }
        
        // Store constraints for orientation changes
        bottomOffsetConstraint = bottomContainer.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor,
            constant: -40
        )
        joinButtonHeightConstraint = joinButton.heightAnchor.constraint(equalToConstant: 58)
        signInButtonHeightConstraint = signInButton.heightAnchor.constraint(equalToConstant: 20)
        joinButtonWidthConstraint = joinButton.widthAnchor.constraint(equalToConstant: 324)
        signInButtonWidthConstraint = signInButton.widthAnchor.constraint(equalToConstant: 332)
        
        NSLayoutConstraint.activate([
            bottomContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomOffsetConstraint,
            bottomContainer.leadingAnchor.constraint(
                greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 24
            ),
            bottomContainer.trailingAnchor.constraint(
                lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -24
            ),
            bottomContainer.widthAnchor.constraint(
                lessThanOrEqualTo: view.safeAreaLayoutGuide.widthAnchor,
                multiplier: 0.9
            ),
            joinButtonHeightConstraint,
            signInButtonHeightConstraint,
            joinButtonWidthConstraint,
            signInButtonWidthConstraint
        ])
    }
    
    // MARK: - Factory Methods (Private)
    
    private func createStepView(style: StepStyle) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.backgroundColor = style.backgroundColor
        if let borderColor = style.borderColor {
            view.layer.borderWidth = 1
            view.layer.borderColor = borderColor
        }
        return view
    }
    
    private func createStepLabel(text: String, textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.textAlignment = .center
        label.textColor = textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func createDashLabel() -> UILabel {
        let label = UILabel()
        label.text = "—"
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func createTitleAttributedString() -> NSAttributedString {
        let text = "Too tired to walk your dog?\nLet's help you!"
        
        guard let font = UIFont(name: "Poppins-Bold", size: 22) else {
            return NSAttributedString(string: text, attributes: [
                .font: UIFont.systemFont(ofSize: 22, weight: .bold),
                .foregroundColor: UIColor.white
            ])
        }
        
        let letterSpacing: CGFloat = (-0.41 / 100) * 22
        
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttributes([
            .font: font,
            .kern: letterSpacing,
            .foregroundColor: UIColor.white
        ], range: NSRange(location: 0, length: text.count))
        
        return attributedString
    }
    
    private func createSignInAttributedString() -> NSAttributedString {
        let fullText = "Already a member? Sign in"
        let attributedString = NSMutableAttributedString(string: fullText)
        
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
        
        return attributedString
    }
    
    // MARK: - Layout Helpers (Private)
    
    private func updateLayoutForOrientation(isLandscape: Bool) {
        bottomOffsetConstraint.constant = isLandscape ? -32 : -40
        
        let buttonHeight: CGFloat = isLandscape ? 48 : 56
        joinButtonHeightConstraint.constant = buttonHeight
        signInButtonHeightConstraint.constant = buttonHeight
        
        titleLabel.font = UIFont.systemFont(ofSize: isLandscape ? 18 : 20, weight: .bold)
        joinButton.titleLabel?.font = UIFont.systemFont(ofSize: isLandscape ? 16 : 18, weight: .semibold)
        signInButton.titleLabel?.font = UIFont.systemFont(ofSize: isLandscape ? 14 : 16, weight: .regular)
        
        stepsStack.spacing = isLandscape ? 12 : 8
        textStack.spacing = isLandscape ? 12 : 16
        buttonsStack.spacing = isLandscape ? 12 : 16
        bottomContainer.spacing = isLandscape ? 24 : 32
        
        view.layoutIfNeeded()
    }
    
    // MARK: - Actions
    
    @objc private func joinTapped() {
        let signUpVC = SignupViewController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @objc private func signInTapped() {
        print("Sign In tapped")
    }
}

