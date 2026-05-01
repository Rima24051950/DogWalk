//
//  ViewController.swift
//  DogWalk
//
//  Created by MacBook on 30.01.2026.
//
import UIKit


final class OnboardingViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBAction func buttonTaped(_ sender: Any) {
        print("Кнопка нажата ✅")
        
        
        
    }
    private var currentStep: Int = 1
    private var gradientlayer = CAGradientLayer()
    private var isDragging = false
    private var dragStartPoint: CGPoint = .zero
    private let dragThreshold: CGFloat = 100
    
    // MARK: - Swipe Gestures
    private lazy var swipeLeft: UISwipeGestureRecognizer = {
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(swiped(_:)))
        gesture.direction = .left
        return gesture
    }()
    
    private lazy var swipeRight: UISwipeGestureRecognizer = {
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(swiped(_:)))
        gesture.direction = .right
        return gesture
    }()
    
    private lazy var panGesture: UIPanGestureRecognizer = {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        gesture.delegate = self
        return gesture
    }()
    
    
    
    
    // MARK: - Types (Private nested types)
    
    private enum StepStyle {
        case first
        case other
        
        var backgroundColor: UIColor {
            switch self {
            case .first: return .surfase
            case .other: return .colorblack
            }
        }
        
        var borderColor: CGColor? {
            switch self {
            case .first: return UIColor.primary.cgColor
            case .other: return nil
            }
        }
    }
    
    
    enum SwipeDirection {
        case left, right
    }
    
    // MARK: - UI Elements
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.onboardingBackground.image
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let gradientOverlayView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    private let pawsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.paws.image
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let wooDogImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.wooDog.image
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // Steps (using factory methods)
    private lazy var step1View = createStepView(style: .first,tag: 1)
    private lazy var step2View = createStepView(style: .other,tag: 2)
    private lazy var step3View = createStepView(style: .other,tag: 3)
    
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
        button.titleLabel?.font = AppFont.interSemibold18()
        button.layer.cornerRadius = 14
        button.backgroundColor = AppColor.primary
        
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
        
        
        view.layoutIfNeeded()
        setupGestures()
        setupGradient()
        
        navigationItem.hidesBackButton = true
        
    }
    
    private func setupGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = gradientOverlayView.bounds
        gradient.colors = [
            UIColor(red: 32/255, green: 32/255, blue: 32/255, alpha: 1.0).cgColor,
            UIColor(red: 32/255, green: 32/255, blue: 32/255, alpha: 0.95).cgColor,
            UIColor(red: 32/255, green: 32/255, blue: 32/255, alpha: 0.90).cgColor,
            UIColor(red: 60/255, green: 60/255, blue: 60/255, alpha: 0.85).cgColor,
            UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.0).cgColor
            
            
        ]
        gradient.locations = [0.0, 0.1326, 0.2019, 0.3036, 1.0].map { NSNumber(value: $0) }
        
        gradient.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 0.0)
        
        gradientOverlayView.layer.insertSublayer(gradient, at: 0)
        
        self.gradientlayer = gradient
    }
    
    
    
    private func setupGestures() {
        
        view.addGestureRecognizer(swipeLeft)
        view.addGestureRecognizer(swipeRight)
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(screenTapped))
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Override Methods
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        let isLandscape = size.width > size.height
        
        coordinator.animate(alongsideTransition: { _ in
            self.updateLayoutForOrientation(isLandscape: isLandscape)
            //  Обновляем фрейм градиента при повороте
            self.gradientlayer.frame = self.gradientOverlayView.bounds
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
        signInButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        
    }
    
    
    
    private func setupBackground() {
        view.insertSubview(backgroundImageView, at: 0)
        view.insertSubview(gradientOverlayView,aboveSubview: backgroundImageView)
        
        view.addSubview(pawsImageView)
        view.addSubview(wooDogImageView)
        
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            gradientOverlayView.topAnchor.constraint(equalTo: view.topAnchor),
            gradientOverlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradientOverlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gradientOverlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
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
            .forEach { ($0 as AnyObject).addSubview($1) }
        
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
    
    private func createStepView(style: StepStyle, tag: Int) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.backgroundColor = style.backgroundColor
        view.tag = tag
        
        if let borderColor = style.borderColor {
            view.layer.borderWidth = 1
            view.layer.borderColor = borderColor
        }
        
        //  Делаем кликабельным
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(stepTapped(_:)))
        view.addGestureRecognizer(tap)
        
        return view
        
    }
    
    private func createStepLabel(text: String, textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = AppFont.interSemibold18()
        label.textAlignment = .center
        label.textColor = textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func createDashLabel() -> UILabel {
        let label = UILabel()
        label.text = "—"
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = AppColor.textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func createTitleAttributedString() -> NSAttributedString {
        let text = "Too tired to walk your dog?\nLet's help you!"
        
        guard let font = UIFont(name: "Poppins-Bold", size: 22) else {
            return NSAttributedString(string: text, attributes: [
                .font: UIFont.systemFont(ofSize: 22, weight: .bold),
                .foregroundColor: AppColor.surfase
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
    
    
    @objc private func signUpTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let signInVC = storyboard.instantiateViewController(withIdentifier: "SignInVC") as? SignInViewController else {
            return
        }
        
        let navController = UINavigationController(rootViewController: signInVC)
        navController.modalPresentationStyle = .fullScreen
        
        present(navController, animated: true)
    }
    
    
    // MARK: - Step Tap
    
    @objc private func stepTapped(_ gesture: UITapGestureRecognizer) {
        guard let step = gesture.view?.tag else { return }
        guard step != currentStep else { return }
        
        currentStep = step
        updateUIForStep(step)
    }
    
    private func updateUIForStep(_ step: Int) {
        
        let imageName = step == 1 ? "onbordingImage" : (step == 2 ? "onbordingimage1" : "onbordingimage2")
        backgroundImageView.image = UIImage(named: imageName)
        
        //  Обновляем стили шагов
        let steps = [(step1View, step1Label), (step2View, step2Label), (step3View, step3Label)]
        
        for (index, (view, label)) in steps.enumerated() {
            let num = index + 1
            if num == currentStep {
                view.backgroundColor = .surfase
                view.layer.borderColor = UIColor.primary.cgColor
                view.layer.borderWidth = 1
                label.textColor = .black
            } else {
                view.backgroundColor = .colorblack
                view.layer.borderColor = nil
                view.layer.borderWidth = 0
                label.textColor = .white
            }
        }
    }
    @objc private func screenTapped() {
        goToNextStep()
    }
    
    
    
    private func goToNextStep() {
        guard currentStep < 3 else {
            // Последний шаг — можно показать финальное действие
            
            return
        }
        currentStep += 1
        updateUIForStep(currentStep)
    }
    
    //  Обработчик свайпа
    @objc private func swiped(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            
            guard currentStep < 3 else { return }
            currentStep += 1
            updateUIForStep(currentStep)
        } else if gesture.direction == .right {
            
            guard currentStep > 1 else { return }
            currentStep -= 1
            updateUIForStep(currentStep)
        }
    }
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        
        switch gesture.state {
        case .began:
            isDragging = true
            dragStartPoint = backgroundImageView.center
            view.bringSubviewToFront(backgroundImageView)
            
        case .changed:
            backgroundImageView.center = CGPoint(
                x: dragStartPoint.x + translation.x,
                y: dragStartPoint.y + translation.y
            )
            
            let progress = min(abs(translation.x) / dragThreshold, 1.0)
            backgroundImageView.alpha = 1 - progress * 0.3
            
            let rotation = translation.x * 0.005
            backgroundImageView.transform = CGAffineTransform(rotationAngle: rotation)
            
        case .ended, .cancelled:
            isDragging = false
            
            if abs(translation.x) > dragThreshold {
                let direction: SwipeDirection = translation.x > 0 ? .right : .left
                swipeToNextStep(direction: direction, velocity: gesture.velocity(in: view).x)
            } else {
                returnBackgroundToCenter()
            }
            
        default:
            break
        }
    }
    
    private func swipeToNextStep(direction: SwipeDirection, velocity: CGFloat) {
        let offScreenX: CGFloat = direction == .right ? view.bounds.width + 100 : -view.bounds.width - 100
        
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        
        UIView.animate(withDuration: 0.25, animations: {
            self.backgroundImageView.center.x = offScreenX
            self.backgroundImageView.transform = CGAffineTransform(rotationAngle: direction == .right ? 0.4 : -0.4)
            self.backgroundImageView.alpha = 0
        }) { _ in
            if direction == .left, self.currentStep < 3 {
                self.currentStep += 1
            } else if direction == .right, self.currentStep > 1 {
                self.currentStep -= 1
            }
            self.updateUIForStep(self.currentStep)
            
            self.backgroundImageView.alpha = 0
            self.backgroundImageView.center.x = offScreenX
            self.backgroundImageView.transform = CGAffineTransform(rotationAngle: direction == .right ? 0.4 : -0.4)
            
            UIView.animate(withDuration: 0.25) {
                self.backgroundImageView.alpha = 1
                self.backgroundImageView.center = self.view.center
                self.backgroundImageView.transform = .identity
            }
        }
    }
    
    private func returnBackgroundToCenter() {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5) {
            self.backgroundImageView.center = self.view.center
            self.backgroundImageView.transform = .identity
            self.backgroundImageView.alpha = 1
        }
    }
    
    
    
    // MARK: - UIGestureRecognizerDelegate
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer is UISwipeGestureRecognizer {
            return otherGestureRecognizer is UIPanGestureRecognizer
        }
        return false
    }
    
}
