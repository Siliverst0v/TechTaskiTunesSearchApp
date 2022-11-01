//
//  AuthViewController.swift
//  iTunesSearchApp
//
//  Created by Анатолий Силиверстов on 01.11.2022.
//

import Foundation
import UIKit

final class AuthViewController: UIViewController, UITextFieldDelegate {
    
    private let warningLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "User with such data is not registered"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .red
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.isHidden = true
        return label
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "E-MAIL"
        textField.textAlignment = .left
        textField.font = .systemFont(ofSize: 17)
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 50))
        textField.leftViewMode = .always
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Password"
        textField.textAlignment = .left
        textField.font = .systemFont(ofSize: 17)
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 50))
        textField.leftViewMode = .always
        return textField
    }()
    
    private let registrationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Registration", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        return button
    }()
    
    private let continueButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Continue", for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configureUI()
        setDelegates()
    }
    
    @objc func getToRegistrationScreen() {
        self.navigationController?.pushViewController(RegConfigurator.configure(), animated: true)
    }
    
    @objc func checkProfileInfo() {
        if let data = UserDefaults.standard.data(forKey: "profile") {
            do {
                let decoder = JSONDecoder()
                let profile = try decoder.decode(Profile.self, from: data)
                guard profile.email == emailTextField.text, profile.password == passwordTextField.text else {
                    warningLabel.isHidden = false
                    return
                }
                let vc = AlbumsConfigurator.configure()
                vc.modalPresentationStyle = .fullScreen
                self.navigationController?.present(vc, animated: true)
            } catch {
                print("Unable to Decode Profile (\(error))")
            }
        } else {
            warningLabel.isHidden = false
        }
    }
    
    private func setDelegates() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        continueButton.addTarget(self, action: #selector(checkProfileInfo), for: .touchUpInside)
        registrationButton.addTarget(self, action: #selector(getToRegistrationScreen), for: .touchUpInside)
    }
    
    private func setupLayout() {
        view.addSubview(warningLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(continueButton)
        view.addSubview(registrationButton)
        
        NSLayoutConstraint.activate([
            
            warningLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            warningLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            warningLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            passwordTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
        
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emailTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -30),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            registrationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            registrationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            registrationButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 4),
            
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            continueButton.heightAnchor.constraint(equalToConstant: 50),
            
        ])
    }
    
    //MARK: - TextField Delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string == "\n") {
            textField.resignFirstResponder()
        }
        return true
    }
}
