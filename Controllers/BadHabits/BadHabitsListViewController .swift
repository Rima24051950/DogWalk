//
//  BadHabitsListViewController.swift
//  
//
//  Created by MacBook on 27.04.2026.
//
import UIKit

final class BadHabitsListViewController: UIViewController {
    
    // MARK: - Properties
    
    private var habits: [HabitItem] = HabitItem.allHabits
    private var selectedHabits: Set<Int> = []
    
    // MARK: - UI Elements
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsVerticalScrollIndicator = false
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "We'd love your pet"
        label.font = AppFont.interBold24()
        label.textColor = AppColor.textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Tell us something about your dog"
        label.font = AppFont.interRegular18()
        label.textColor = AppColor.textSecondary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let progressLabel: UILabel = {
        let label = UILabel()
        label.text = "4/10"
        label.font = AppFont.interBold24()
        label.textColor = AppColor.textSecondary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let progressBarBackground: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.disabled
        view.layer.cornerRadius = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let progressBarFill: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.primary  
        view.layer.cornerRadius = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let sectionTitleLabel: UILabel = {
        let label = UILabel()
       // label.text = "Bad habits"
        label.font = AppFont.interBold24()
        label.textColor = AppColor.textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
 
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        cv.allowsMultipleSelection = true
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    private let getStartedButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Get started", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = AppFont.interSemibold18()
        button.backgroundColor = AppColor.primary
        button.layer.cornerRadius = 14
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCollectionView()
        setupConstraints()
        setupActions()
    }
    
    // MARK: - Setup
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
   
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(progressLabel)
        contentView.addSubview(progressBarBackground)
        progressBarBackground.addSubview(progressBarFill)
        contentView.addSubview(sectionTitleLabel)
        contentView.addSubview(collectionView)
        
      
        view.addSubview(getStartedButton)
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HabitCell.self, forCellWithReuseIdentifier: HabitCell.identifier)
    }
    
    private func setupActions() {

        getStartedButton.addTarget(self, action: #selector(getStartedTapped), for: .touchUpInside)
    }
    
    // MARK: - Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            // ScrollView
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: getStartedButton.topAnchor),
            
            // ContentView
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
          
            // Title
            titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            // Subtitle
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            // Progress Label
            progressLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 24),
            progressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            // Progress Bar
            progressBarBackground.topAnchor.constraint(equalTo: progressLabel.bottomAnchor, constant: 8),
            progressBarBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            progressBarBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            progressBarBackground.heightAnchor.constraint(equalToConstant: 4),
            
            // Progress Fill (40%)
            progressBarFill.leadingAnchor.constraint(equalTo: progressBarBackground.leadingAnchor),
            progressBarFill.topAnchor.constraint(equalTo: progressBarBackground.topAnchor),
            progressBarFill.bottomAnchor.constraint(equalTo: progressBarBackground.bottomAnchor),
            progressBarFill.widthAnchor.constraint(equalTo: progressBarBackground.widthAnchor, multiplier: 0.4),
            
            // Section Title
            sectionTitleLabel.topAnchor.constraint(equalTo: progressBarBackground.bottomAnchor, constant: 24),
            sectionTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            // CollectionView
            collectionView.topAnchor.constraint(equalTo: sectionTitleLabel.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            collectionView.heightAnchor.constraint(equalToConstant: 524),  // 3 ряда × 162 + gaps
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40),
            
            // Get Started Button (внизу экрана)
            getStartedButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            getStartedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            getStartedButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            getStartedButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    // MARK: - Actions
    
    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func getStartedTapped() {
      
        // Переход на следующий экран
    }
}

// MARK: - UICollectionViewDataSource & Delegate

extension BadHabitsListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return habits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HabitCell.identifier, for: indexPath) as! HabitCell
        cell.configure(with: habits[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedHabits.insert(habits[indexPath.item].id)
      
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        selectedHabits.remove(habits[indexPath.item].id)
      
    }
    
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 10) / 2
        return CGSize(width: width, height: 162)
    }
}
