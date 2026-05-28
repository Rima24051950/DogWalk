//
//  PaymentViewController.swift
//  DogWalk
//
//  Created by MacBook on 27.05.2026.
//
import UIKit

final class PaymentViewController: UIViewController {
    
    // MARK: - UI Elements
    private let titleLabel: UILabel = {
        let l = UILabel()
        l.text = "Payment"
        l.font = UIFont(name: "Poppins-Bold", size: 32)
        l.textColor = .black
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let subtitleLabel: UILabel = {
        let l = UILabel()
        l.text = "Just before your dog walk starts"
        l.font = UIFont(name: "Poppins-Regular", size: 14)
        l.textColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    // Контейнер для банковской карты
    private let cardContainer: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 24
        v.clipsToBounds = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let cardNameLabel: UILabel = {
        let l = UILabel()
        l.text = "Cristian Downey"
        l.font = UIFont(name: "Poppins-Regular", size: 13)
        l.textColor = .white.withAlphaComponent(0.9)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let cardBalanceLabel: UILabel = {
        let l = UILabel()
        l.text = "$3,265.23"
        l.font = UIFont(name: "Poppins-Bold", size: 30)
        l.textColor = .white
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let cardNumberLabel: UILabel = {
        let l = UILabel()
        l.text = "5282 3456 7890 1289"
        l.font = UIFont(name: "Poppins-Regular", size: 14)
        l.textColor = .white.withAlphaComponent(0.9)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let cardExpiryLabel: UILabel = {
        let l = UILabel()
        l.text = "09/25"
        l.font = UIFont(name: "Poppins-Regular", size: 14)
        l.textColor = .white.withAlphaComponent(0.9)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let mastercardImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "circle.fill")
        iv.tintColor = UIColor(red: 0.9, green: 0.3, blue: 0.2, alpha: 1.0)
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
  
    private let cardButtonAdd: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 12)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.numberOfLines = 2
        button.setTitleColor(UIColor(red: 0.8, green: 0.3, blue: 0.3, alpha: 1.0), for: .normal)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let totalSpendLabel: UILabel = {
        let label = UILabel()
        label.text = "Total Spend"
        label.font = UIFont(name: "Poppins-SemiBold", size: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let totalAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "$488"
        label.font = UIFont(name: "Poppins-Bold", size: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
   
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        table.rowHeight = 56
        table.showsVerticalScrollIndicator = false
        table.backgroundColor = .clear
        table.allowsSelection = true
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(PaymentCell.self, forCellReuseIdentifier: PaymentCell.identifier)
        table.rowHeight = 78
        return table
    }()
    
   
    private let bottomButtonsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 12
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0), for: .normal)
        button.layer.cornerRadius = 16
        button.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let payButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Pay", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 16
        button.backgroundColor = .orange
        button.titleLabel?.font = UIFont(name: "Poppins-Bold", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // Данные
    private let transactions = [
        PaymentTx(icon: "🍎", title: "Groceries", amount: "-$12", isNegative: true),
        PaymentTx(icon: "🎮", title: "Gaming Console", amount: "+$12", isNegative: false),
        PaymentTx(icon: "👨", title: "Sameer", amount: "+$12", isNegative: false),
        PaymentTx(icon: "🍎", title: "Groceries", amount: "-$12", isNegative: true)
    ]
    
    private var selectedIndex: IndexPath?
    
    // MARK: - Gradient Layers
    private var cardGradLayer: CAGradientLayer!
    private var payGradLayer: CAGradientLayer!
    private var cardButtonAddGradLayer: CAGradientLayer!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.0)
        setupGradients()
        setupUI()
        setupConstraints()
        setupActions()
    }
    
    private func setupGradients() {
        // 1. Градиент карты
        let cardGrad = CAGradientLayer()
        cardGrad.colors = [
            UIColor(red: 0.6, green: 0.2, blue: 1.0, alpha: 1.0).cgColor,
            UIColor(red: 1.0, green: 0.4, blue: 0.4, alpha: 1.0).cgColor
        ]
        cardGrad.startPoint = CGPoint(x: 0, y: 0.5)
        cardGrad.endPoint = CGPoint(x: 1, y: 0.5)
        cardGrad.cornerRadius = 24
        cardContainer.layer.insertSublayer(cardGrad, at: 0)
        self.cardGradLayer = cardGrad
        
        // 2. Градиент кнопки Pay
        let payGrad = CAGradientLayer()
        payGrad.colors = [
            UIColor(red: 1.0, green: 0.55, blue: 0.3, alpha: 1.0).cgColor,
            UIColor(red: 1.0, green: 0.7, blue: 0.3, alpha: 1.0).cgColor
        ]
        payGrad.startPoint = CGPoint(x: 0, y: 0)
        payGrad.endPoint = CGPoint(x: 1, y: 1)
        payGrad.cornerRadius = 16
        payButton.layer.insertSublayer(payGrad, at: 0)
        self.payGradLayer = payGrad
        
        // 3. Градиент кнопки Add card
        let addCardGrad = CAGradientLayer()
        addCardGrad.colors = [
            UIColor(red: 1.0, green: 0.85, blue: 0.85, alpha: 1.0).cgColor,
            UIColor(red: 0.9, green: 0.8, blue: 1.0, alpha: 1.0).cgColor
        ]
        addCardGrad.startPoint = CGPoint(x: 0.5, y: 0)
        addCardGrad.endPoint = CGPoint(x: 0.5, y: 1)
        addCardGrad.cornerRadius = 20
        cardButtonAdd.layer.insertSublayer(addCardGrad, at: 0)
        self.cardButtonAddGradLayer = addCardGrad
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        cardGradLayer?.frame = cardContainer.bounds
        payGradLayer?.frame = payButton.bounds
        cardButtonAddGradLayer?.frame = cardButtonAdd.bounds
    }
    
    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(cardContainer)
        cardContainer.addSubview(cardNameLabel)
        cardContainer.addSubview(cardBalanceLabel)
        cardContainer.addSubview(cardNumberLabel)
        cardContainer.addSubview(cardExpiryLabel)
        cardContainer.addSubview(mastercardImageView)
        
        view.addSubview(cardButtonAdd)
        
        view.addSubview(totalSpendLabel)
        view.addSubview(totalAmountLabel)
        view.addSubview(tableView)
        
        // 🔥 Добавляем контейнер с кнопками
        view.addSubview(bottomButtonsStack)
        bottomButtonsStack.addArrangedSubview(cancelButton)
        bottomButtonsStack.addArrangedSubview(payButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Заголовки
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            // Карта
            cardContainer.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 20),
            cardContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            cardContainer.heightAnchor.constraint(equalToConstant: 170),
            
            // Кнопка "Add card" справа от карты
            cardButtonAdd.centerYAnchor.constraint(equalTo: cardContainer.centerYAnchor),
            cardButtonAdd.leadingAnchor.constraint(equalTo: cardContainer.trailingAnchor, constant: 12),
            cardButtonAdd.widthAnchor.constraint(equalToConstant: 49),
            cardButtonAdd.heightAnchor.constraint(equalToConstant: 197),
            cardButtonAdd.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            cardContainer.trailingAnchor.constraint(equalTo: cardButtonAdd.leadingAnchor, constant: -12),
            
            // Элементы карты
            cardNameLabel.topAnchor.constraint(equalTo: cardContainer.topAnchor, constant: 16),
            cardNameLabel.leadingAnchor.constraint(equalTo: cardContainer.leadingAnchor, constant: 16),
            
            cardBalanceLabel.topAnchor.constraint(equalTo: cardNameLabel.bottomAnchor, constant: 6),
            cardBalanceLabel.leadingAnchor.constraint(equalTo: cardNameLabel.leadingAnchor),
            
            cardNumberLabel.bottomAnchor.constraint(equalTo: cardContainer.bottomAnchor, constant: -16),
            cardNumberLabel.leadingAnchor.constraint(equalTo: cardContainer.leadingAnchor, constant: 16),
            
            cardExpiryLabel.centerYAnchor.constraint(equalTo: cardNumberLabel.centerYAnchor),
            cardExpiryLabel.trailingAnchor.constraint(equalTo: cardContainer.trailingAnchor, constant: -16),
            
            mastercardImageView.topAnchor.constraint(equalTo: cardContainer.topAnchor, constant: 16),
            mastercardImageView.trailingAnchor.constraint(equalTo: cardContainer.trailingAnchor, constant: -16),
            mastercardImageView.widthAnchor.constraint(equalToConstant: 36),
            mastercardImageView.heightAnchor.constraint(equalToConstant: 36),
            
            // Total Spend
            totalSpendLabel.topAnchor.constraint(equalTo: cardContainer.bottomAnchor, constant: 24),
            totalSpendLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            totalAmountLabel.centerYAnchor.constraint(equalTo: totalSpendLabel.centerYAnchor),
            totalAmountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            // Таблица
            tableView.topAnchor.constraint(equalTo: totalSpendLabel.bottomAnchor, constant: 12),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 280),
            
            // 🔥 Кнопки внизу (через StackView)
            bottomButtonsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            bottomButtonsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            bottomButtonsStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            bottomButtonsStack.heightAnchor.constraint(equalToConstant: 56) // Высота кнопок
        ])
    }
    
    private func setupActions() {
        cardButtonAdd.addTarget(self, action: #selector(addCardTapped), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        payButton.addTarget(self, action: #selector(payTapped), for: .touchUpInside)
    }
    
    @objc private func cancelTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func payTapped() {
        let alert = UIAlertController(title: "✅ Success", message: "Payment processed.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Done", style: .default) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        })
        present(alert, animated: true)
    }
    
    @objc private func addCardTapped() {
        print("➕ Add card tapped")
    }
}

// MARK: - TableView DataSource & Delegate
extension PaymentViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PaymentCell.identifier, for: indexPath) as! PaymentCell
        cell.configure(with: transactions[indexPath.row])
        cell.isSelected = (selectedIndex == indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath
        tableView.reloadData()
    }
}

// MARK: - Models & Cell
struct PaymentTx {
    let icon: String
    let title: String
    let amount: String
    let isNegative: Bool
}

class PaymentCell: UITableViewCell {
    static let identifier = "PaymentCell"
    private let iconLbl = UILabel()
    private let titleLbl = UILabel()
    private let amountLbl = UILabel()
    private let separator = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        selectionStyle = .none
        [iconLbl, titleLbl, amountLbl, separator].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        iconLbl.font = UIFont.systemFont(ofSize: 22)
        titleLbl.font = UIFont(name: "Poppins-Regular", size: 15)
        titleLbl.textColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1.0)
        amountLbl.font = UIFont(name: "Poppins-SemiBold", size: 15)
        separator.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        
        NSLayoutConstraint.activate([
            iconLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            iconLbl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLbl.leadingAnchor.constraint(equalTo: iconLbl.trailingAnchor, constant: 10),
            titleLbl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            amountLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            amountLbl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func configure(with tx: PaymentTx) {
        iconLbl.text = tx.icon
        titleLbl.text = tx.title
        amountLbl.text = tx.amount
        amountLbl.textColor = tx.isNegative ? UIColor(red: 1.0, green: 0.4, blue: 0.3, alpha: 1.0) : UIColor(red: 0.3, green: 0.6, blue: 0.3, alpha: 1.0)
    }
    
    override var isSelected: Bool {
        didSet {
            contentView.backgroundColor = isSelected ? UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1.0) : .clear
        }
    }
}
