//
//  SignInViewController.swift
//  DogWalk
//
//  Created by MacBook on 11.03.2026.
//

import UIKit

final class SignInViewController: UIViewController,UISearchTextFieldDelegate {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var letsStartsLabel: UILabel!
    @IBOutlet weak var fillYourDetailLabel: UILabel!
    
    
    @IBOutlet weak var privacyLabel: UILabel!
    
    
    
    override func viewDidLoad() {
            super.viewDidLoad()
            
            
        view.backgroundColor = AppColor.onSurfase
        nameField.layer.cornerRadius = 14
        nameField.clipsToBounds = true
        emailField.layer.cornerRadius = 14
        emailField.clipsToBounds = true
        passwordField.layer.cornerRadius = 14
        passwordField.clipsToBounds = true
       
        nameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
           
         
            
            // 3. Кнопка "Назад"
            navigationItem.leftBarButtonItem = UIBarButtonItem(
                title: "←",
                style: .plain,
                target: self,
                action: #selector(dismissSelf)
            )
        }
        
        @objc private func dismissSelf() {
            dismiss(animated: true)
           
        }
    }

    // MARK: - UITextFieldDelegate
    extension SignInViewController: UITextFieldDelegate {
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder() // Скрыть клавиатуру
            return true
        }
    }
