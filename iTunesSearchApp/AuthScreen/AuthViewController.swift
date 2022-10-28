//
//  AuthViewController.swift
//  iTunesSearchApp
//
//  Created by Анатолий Силиверстов on 28.10.2022.
//

import Foundation
import UIKit

final class AuthViewController: UIViewController, UITextFieldDelegate {
    
    let viewModel: AuthViewModelProtocol
    
    private let nameTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textAlignment = .left
        tf.font = .systemFont(ofSize: 17)
        tf.placeholder = "Name"
        tf.layer.cornerRadius = 10
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.gray.cgColor
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 40))
        tf.leftViewMode = .always
        return tf
    }()
    
    private let secondNameTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textAlignment = .left
        tf.font = .systemFont(ofSize: 17)
        tf.placeholder = "Second Name"
        tf.layer.cornerRadius = 10
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.gray.cgColor
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 40))
        tf.leftViewMode = .always
        return tf
    }()
    
    private let birthDateTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textAlignment = .left
        tf.font = .systemFont(ofSize: 17)
        tf.placeholder = "Date of birth"
        tf.layer.cornerRadius = 10
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.gray.cgColor
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 40))
        tf.leftViewMode = .always
        return tf
    }()
    
    private let phoneNumberTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textAlignment = .left
        tf.font = .systemFont(ofSize: 17)
        tf.placeholder = "Phone number"
        tf.layer.cornerRadius = 10
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.gray.cgColor
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 40))
        tf.leftViewMode = .always
        tf.tag = 1
        return tf
    }()
    
    private let emailTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textAlignment = .left
        tf.font = .systemFont(ofSize: 17)
        tf.placeholder = "E-Mail"
        tf.layer.cornerRadius = 10
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.gray.cgColor
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 40))
        tf.leftViewMode = .always
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textAlignment = .left
        tf.font = .systemFont(ofSize: 17)
        tf.placeholder = "Password"
        tf.layer.cornerRadius = 10
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.gray.cgColor
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 40))
        tf.leftViewMode = .always
        tf.isSecureTextEntry = true
        tf.passwordRules = UITextInputPasswordRules(descriptor: "required: upper; required: lower; required: digit; minlength: 6;")
        return tf
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 143/255, green: 109/255, blue: 216/255, alpha: 1)
        button.setTitle("Сохранить", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        button.layer.cornerRadius = 10
        button.isHidden = false
        return button
    }()
    
    init(viewModel: AuthViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configureUI()
        setDelegates()
        createDatePicker()
        setTargets()
    }
    
    private func setTargets() {
        emailTextField.addTarget(self, action: #selector(validatingEmail), for: .editingDidEnd)
        passwordTextField.addTarget(self, action: #selector(validatingPassword), for: .editingDidEnd)
    }
    
    private func createDatePicker() {
        let datePicker = UIDatePicker()
        let toolBar = UIToolbar()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(dismissDatePicker))
        toolBar.setItems([doneButton], animated: true)
        toolBar.sizeToFit()
        datePicker.addTarget(self, action: #selector(changeDate(datePicker:)), for: .valueChanged)
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        birthDateTextField.inputAccessoryView = toolBar
        birthDateTextField.inputView = datePicker
    }
    
    @objc func changeDate(datePicker: UIDatePicker) {
        let age = Calendar.current.date(byAdding: .year, value: -18, to: Date())!
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        if datePicker.date < age {
            birthDateTextField.text = formatter.string(from: datePicker.date)
        } else {
            datePicker.date = Date()
        }
    }
    
    @objc func dismissDatePicker() {
        self.view.endEditing(true)
    }
    
    @objc func validatingEmail(textField: UITextField) {
        let emailValidationRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"
        let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)
        
        if emailValidationPredicate.evaluate(with: textField.text) {
            // save value
        } else {
            // alert
        }
    }
    
    @objc func validatingPassword(textField: UITextField) {
        let passwordValidationRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{6,16}$"
        let passwordValidationPredicate = NSPredicate(format: "SELF MATCHES %@", passwordValidationRegex)
        if passwordValidationPredicate.evaluate(with: textField.text) {
            // save value
            print(textField.text)
        } else {
            // alert
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .white
    }
    
    private func setDelegates() {
        nameTextField.delegate = self
        secondNameTextField.delegate = self
        birthDateTextField.delegate = self
        phoneNumberTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func setupLayout() {
        view.addSubview(nameTextField)
        view.addSubview(secondNameTextField)
        view.addSubview(birthDateTextField)
        view.addSubview(phoneNumberTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            secondNameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16),
            secondNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            secondNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            secondNameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            birthDateTextField.topAnchor.constraint(equalTo: secondNameTextField.bottomAnchor, constant: 16),
            birthDateTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            birthDateTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            birthDateTextField.heightAnchor.constraint(equalToConstant: 40),
            
            phoneNumberTextField.topAnchor.constraint(equalTo: birthDateTextField.bottomAnchor, constant: 16),
            phoneNumberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            phoneNumberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: 40),
            
            emailTextField.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 16),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
//MARK: - TextField Delegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string == "\n") {
            textField.resignFirstResponder()
        }
        if textField.tag == 1 {
            guard let text = textField.text else { return false }
            let newString = (text as NSString).replacingCharacters(in: range, with: string)
            textField.text = viewModel.formatInputPhoneNumber(with: "+X (XXX) XXX-XXXX", phone: newString)
            return false
        }
        return true
    }
}


