//
//  HomeViewController.swift
//  DogWalk
//
//  Created by MacBook on 14.03.2026.
//


import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = true
        scroll.showsHorizontalScrollIndicator = false
        scroll.keyboardDismissMode = .interactive
        return scroll
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "Your location..."
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "HOME"
        label.font = AppFont.interBold24()
        label.textColor = AppColor.textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Explore dog walkers"
        label.font = AppFont.interRegular18()
        label.textColor = AppColor.disabled
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let iconButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins-Bold", size: 10)
        
        button.tintColor = AppColor.onSurfase
        button.setTitle("Book a walk",for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins-Bold", size: 14)
        button.backgroundColor = AppColor.primary
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(bookWalkTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var contentStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.backgroundInput
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK - Баннер и картинка внутри баннера
    
    
    private let promoBanner: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.backgroundInput
        view.layer .cornerRadius = 24
       view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
        
    }()
    
    private let bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "BANNER")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    
    private let overlayImageView: UIImageView = {
        let imamgeView = UIImageView()
        imamgeView.image = UIImage(named: "illustration")
        imamgeView.contentMode = .scaleAspectFit
        imamgeView.alpha = 1.0
        imamgeView.transform = .identity
        imamgeView.translatesAutoresizingMaskIntoConstraints = false
        return imamgeView
        
    }()
    
    private let infoContainer: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.onSurfase
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    private let topwalkers: UILabel = {
        let label = UILabel()
        label.text = "Top walkers"
        label.font = AppFont.interBold24()
        label.textColor = AppColor.textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    private let viewall: UILabel = {
        let label = UILabel()
        label.text = "View all"
        label.font = AppFont.interSemibold18()
        label.textColor = AppColor.disabled
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    // MARK: - Top Suggested view
    
    private let suggestedContainer: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.onSurfase
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private let suggestedView: UILabel = {
        let label = UILabel()
        label.text = "Suggested"
        label.font = AppFont.interBold24()
        label.textColor = AppColor.textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    
    }()
    
    private let viewAllView: UILabel = {
        let label = UILabel()
        label.text = "View all"
        label.font = AppFont.interSemibold18()
        label.textColor = AppColor.disabled
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    
    }()
    

    // MARK: - Top Walkers Cards
    private let walkersStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 12
        stack.distribution = .fillEqually
        stack.alignment = .top
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
        
    }()
    
    private let suggestedViewStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 12
        stack.distribution = .fillEqually
        stack.alignment = .top
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    
    
    
    private let suggestedCard: WalkerCardView = {
        let card = WalkerCardView()
        card.configure(name: "Mark Creene",
                    location: "India,Guntur",
                    rating: "4.9",
                       price: "5/hr",
                    image: UIImage(named: "Triana Kain"))
        return card
    }()
    
    
    private let suggestedCard1: WalkerCardView = {
        let card = WalkerCardView()
        card.configure(
            name: "Jane Smith",
            location: "St. Petersburg",
            rating: "4.8",
            price: "7/hr",
            image: UIImage(named: "Mark Green")
        )
        return card
    }()
    
    
    
    private let walkerCard1: WalkerCardView = {
        let card = WalkerCardView()
        card.configure(name: "Mark Creene",
                    location: "India,Guntur",
                    rating: "4.9",
                       price: "5/hr",
                    image: UIImage(named: "Mark"))
        return card
    }()
    
    
    private let walkerCard2: WalkerCardView = {
        let card = WalkerCardView()
        card.configure(
            name: "Jane Smith",
            location: "St. Petersburg",
            rating: "4.8",
            price: "7/hr",
            image: UIImage(named: "Trina")
        )
        return card
    }()
    
    

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview (containerView)
        containerView.addSubview(contentStack)
        containerView.addSubview(iconButton)  
        contentView.addSubview(searchBar)
        setupSearchIcon()
        
        // MARK: БАННЕР
        
        contentView.addSubview(promoBanner)
        promoBanner.addSubview(bannerImageView)
        promoBanner.addSubview(overlayImageView)
        
       //  MARK: Top walkers - контейнер
        contentView.addSubview(infoContainer)
        infoContainer.addSubview(topwalkers)
        infoContainer.addSubview(viewall)
        
        
        //  MARK: Top Suggested - контейнер
        contentView.addSubview(suggestedContainer)
        suggestedContainer.addSubview(suggestedView)
        suggestedContainer.addSubview(viewAllView)
        
        contentView.addSubview(suggestedViewStack)
        suggestedViewStack.addArrangedSubview(suggestedCard)
        suggestedViewStack.addArrangedSubview(suggestedCard1)
        
        
        
//        MARK: Карточки walkers
        contentView.addSubview(walkersStackView)
        walkersStackView.addArrangedSubview(walkerCard1)
        walkersStackView.addArrangedSubview(walkerCard2)
       
        

        setupConstraints()
        setupActions()
    
       
        searchBar.delegate = self
    }
    
    private func setupSearchIcon() {
        //  Контейнер для иконки с точными размерами
        let iconContainer = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        
        let icon = UIImageView(image: UIImage(named: "Type"))
        icon.tintColor = AppColor.iconColor
        icon.frame = CGRect(x: 3.75, y: 1.18, width: 12.5, height: 15) 
        icon.layer.borderWidth = 1.3
        icon.layer.borderColor = AppColor.iconColor.cgColor
        icon.layer.cornerRadius = 6.25
        icon.clipsToBounds = true
        
        iconContainer.addSubview(icon)
        
        searchBar.searchTextField.leftView = iconContainer
        searchBar.searchTextField.leftViewMode = .always
    }

    // MARK: - Constraints ✅ ВСЕ КОНСТРЕЙНТЫ ЗДЕСЬ
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            // scrollView на весь экран
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // contentView внутри scrollView
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            
            //  containerView
            containerView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 16),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.heightAnchor.constraint(equalToConstant: 77),
            
            //  contentStack (текст внутри контейнера)
            contentStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            contentStack.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            //  iconButton (иконка справа внутри контейнера)
            iconButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            iconButton.leadingAnchor.constraint(equalTo: contentStack.leadingAnchor, constant: 200),
            iconButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            iconButton.widthAnchor.constraint(equalToConstant: 104),
            iconButton.heightAnchor.constraint(equalToConstant: 41),
            
            //  searchBar (под контейнером)
            searchBar.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 16),
            searchBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            searchBar.heightAnchor.constraint(equalToConstant: 42),
        
            // promoBanner (констрейнты)
            
            //promoBanner.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 203),
            promoBanner.topAnchor.constraint(equalTo: searchBar.bottomAnchor,constant: 16),
            promoBanner.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            promoBanner.widthAnchor.constraint(equalToConstant: 343),
            promoBanner.heightAnchor.constraint(equalToConstant: 132),
            
            // bannerImageView (констрейнты)
            
            bannerImageView.topAnchor.constraint(equalTo: promoBanner.topAnchor),
            
            bannerImageView.leadingAnchor.constraint(equalTo: promoBanner.leadingAnchor),
            bannerImageView.trailingAnchor.constraint(equalTo: promoBanner.trailingAnchor),
            bannerImageView.bottomAnchor.constraint(equalTo: promoBanner.bottomAnchor),
            
            
            // MARK: картинка внутри картинки
            overlayImageView.topAnchor.constraint(equalTo: promoBanner.topAnchor,constant: 13),
            overlayImageView.leadingAnchor.constraint(equalTo: promoBanner.leadingAnchor,constant: 222),
            overlayImageView.widthAnchor.constraint(equalToConstant: 135),
            overlayImageView.heightAnchor.constraint(equalToConstant: 106),
            
            // MARK: Top walkers (контейнер)
            
           // infoContainer.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor,constant: 357),
            infoContainer.topAnchor.constraint(equalTo: promoBanner.bottomAnchor,constant: 16),
            infoContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            infoContainer.widthAnchor.constraint(equalToConstant: 342),
            infoContainer.heightAnchor.constraint(equalToConstant: 51),
            infoContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -500),
            // MARK: левый лейбл
            
            topwalkers.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor),
            topwalkers.centerYAnchor.constraint(equalTo: infoContainer.centerYAnchor),
            
            viewall.leadingAnchor.constraint(equalTo: topwalkers.trailingAnchor, constant: 76),
            viewall.trailingAnchor.constraint(equalTo: infoContainer.trailingAnchor),
            viewall.centerYAnchor.constraint(equalTo: infoContainer.centerYAnchor),
            infoContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            
            // MARK: Top Suggested (контейнер)
            suggestedContainer.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor,constant: 600),
            suggestedContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
            suggestedContainer.widthAnchor.constraint(equalToConstant: 342),
            suggestedContainer.heightAnchor.constraint(equalToConstant: 51),
         //   suggestedContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -16),
            
            
            // ✅ Левый лейбл
            
            suggestedView.leadingAnchor.constraint(equalTo: suggestedContainer.leadingAnchor),
            suggestedView.centerYAnchor.constraint(equalTo: suggestedContainer.centerYAnchor),
            suggestedView.widthAnchor.constraint(equalToConstant: 187),
            suggestedView.heightAnchor.constraint(equalToConstant: 51),
            
            // ✅Правый лейбл
            
            viewAllView.leadingAnchor.constraint(equalTo: suggestedView.leadingAnchor,constant: 97),
            viewAllView.trailingAnchor.constraint(equalTo: suggestedContainer.trailingAnchor),
            viewAllView.centerYAnchor.constraint(equalTo: suggestedContainer.centerYAnchor),
            viewAllView.widthAnchor.constraint(equalToConstant: 58),
            viewAllView.heightAnchor.constraint(equalToConstant: 23),
            
            
            suggestedViewStack.topAnchor.constraint(equalTo: suggestedContainer.bottomAnchor, constant: 16),
            
            suggestedViewStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            suggestedViewStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            suggestedViewStack.heightAnchor.constraint(equalToConstant: 200),
            
            
            
            
            walkersStackView.topAnchor.constraint(equalTo: infoContainer.bottomAnchor, constant: 24),
                   walkersStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                   walkersStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                   
            walkerCard1.widthAnchor.constraint(equalToConstant: 179),  // ✅ Фиксированная ширина
            walkerCard2.widthAnchor.constraint(equalToConstant: 179),
            
            
            
        ])
        
    }
    
    // MARK: - Actions
    
    private func setupActions() {
        iconButton.addTarget(self, action: #selector(iconTapped), for: .touchUpInside)
    }
    
    @objc private func iconTapped() {
        
    }
    
    @objc private func bookWalkTapped() {
        let badHabitsVC = BadHabitsListViewController()
        badHabitsVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(badHabitsVC, animated: true)
    }
}

// MARK: - UISearchBarDelegate

extension HomeViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("🔍 Search: \(searchBar.text ?? "")")
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}
