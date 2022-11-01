//
//  RegViewController.swift
//  iTunesSearchApp
//
//  Created by Анатолий Силиверстов on 28.10.2022.
//

import Foundation
import UIKit

final class RegViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    let viewModel: RegViewModelProtocol
    let regTableView = RegTableView(frame: .zero, style: .insetGrouped)
    var profileInfo: [String: String] = [:]
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Continue", for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        button.layer.cornerRadius = 10
        return button
    }()
    
    init(viewModel: RegViewModelProtocol) {
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
        saveButton.addTarget(self, action: #selector(saveProfileInfo), for: .touchUpInside)
    }
    
    private func createDatePicker() {
        let datePicker = UIDatePicker()
        let toolBar = UIToolbar()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(dismissDatePicker))
        toolBar.setItems([doneButton], animated: true)
        toolBar.sizeToFit()
        datePicker.addTarget(self, action: #selector(changeDate(_:)), for: .valueChanged)
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        if let textField = self.view.viewWithTag(2) as? UITextField {
            
            textField.inputAccessoryView = toolBar
            textField.inputView = datePicker
        }
    }
    
    @objc func saveProfileInfo() {
        if profileInfo.count == 6 {
            guard let name = profileInfo["name"],
                  let secondName = profileInfo["surname"],
                  let birthDate = profileInfo["birthDate"],
                  let phoneNumber = profileInfo["phoneNumber"],
                  let email = profileInfo["email"],
                  let password = profileInfo["password"] else {return}
            let profile = Profile(name: name, secondName: secondName, dateOfBirth: birthDate, phoneNumber: phoneNumber, email: email, password: password)
            do {
                let encoder = JSONEncoder()
                let data = try encoder.encode(profile)
                UserDefaults.standard.set(data, forKey: "profile")
                self.navigationController?.pushViewController(AlbumsConfigurator.configure(), animated: true)
                self.dismiss(animated: false)
            } catch {
                print("Unable to Encode Profile (\(error))")
            }
        } else {
            print("error")
        }
    }
    
    @objc func changeDate(_ sender: UIDatePicker) {
        let age = Calendar.current.date(byAdding: .year, value: -18, to: Date())!
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        if sender.date < age {
            if let textField = self.view.viewWithTag(2) as? UITextField {
                textField.text = formatter.string(from: sender.date)
            }
        } else {
            sender.date = Date()
        }
    }
    
    @objc func dismissDatePicker() {
        self.view.endEditing(true)
    }
    
    private func configureUI() {
        view.backgroundColor = .white
    }
    
    private func setDelegates() {
        regTableView.delegate = self
        regTableView.dataSource = self
    }
    
    private func setupLayout() {
        view.addSubview(regTableView)
        view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            
            regTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            regTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            regTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            regTableView.bottomAnchor.constraint(equalTo: saveButton.topAnchor),
            
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
        if textField.tag == 3 {
            guard let text = textField.text else { return false }
            let newString = (text as NSString).replacingCharacters(in: range, with: string)
            textField.text = viewModel.formatInputPhoneNumber(with: "+X (XXX) XXX-XXXX", phone: newString)
            return false
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        switch textField.tag {
        case 0:
            guard let text = textField.text, viewModel.nameIsValid(name: text) else {
                textField.layer.borderColor = UIColor.red.cgColor
                return}
            textField.layer.borderColor = UIColor.gray.cgColor
            profileInfo["name"] = text
        case 1:
            guard let text = textField.text, viewModel.nameIsValid(name: text) else {
                textField.layer.borderColor = UIColor.red.cgColor
                return}
            textField.layer.borderColor = UIColor.gray.cgColor
            profileInfo["surname"] = text
        case 2:
            guard let text = textField.text, text != "" else {
                textField.layer.borderColor = UIColor.red.cgColor
                return}
            textField.layer.borderColor = UIColor.gray.cgColor
            profileInfo["birthDate"] = text
        case 3:
            guard let text = textField.text, text != "" else {
                textField.layer.borderColor = UIColor.red.cgColor
                return}
            textField.layer.borderColor = UIColor.gray.cgColor
            profileInfo["phoneNumber"] = text
        case 4:
            guard let text = textField.text, viewModel.emailIsValid(email: text) else {
                textField.layer.borderColor = UIColor.red.cgColor
                return}
            textField.layer.borderColor = UIColor.gray.cgColor
            profileInfo["email"] = text
        case 5:
            guard let text = textField.text, viewModel.passwordIsValid(password: text) else {
                textField.layer.borderColor = UIColor.red.cgColor
                return}
            textField.layer.borderColor = UIColor.gray.cgColor
            profileInfo["password"] = text
        default:
            break
        }
    }
    
    //MARK: - TableView Delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.getNumberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: FooterView.reuseIdentifier) as? FooterView
        footer?.configure(with: viewModel, for: section)
        return footer ?? FooterView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileInfoCell.reuseIdentifier, for: indexPath) as? ProfileInfoCell
        cell?.configure(with: viewModel, for: indexPath)
        cell?.textField.delegate = self
        cell?.textField.tag = indexPath.section
        createDatePicker()
        return cell ?? ProfileInfoCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? ProfileInfoCell
        cell?.textField.becomeFirstResponder()
    }
}


