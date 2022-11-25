//
//  LoginViewController.swift
//  Instagram
//
//  Created by Yuru Zhou on 11/24/22.
//

import UIKit
import FirebaseAuth
import SafariServices

class LoginViewController: UIViewController {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let emailField: UITextField = {
       let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .continue
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.placeholder = "Email Address..."
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textField.leftViewMode = .always
        textField.backgroundColor = .white
        return textField
    }()
    
    private let passwordField: UITextField = {
       let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .done
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.placeholder = "Password..."
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textField.leftViewMode = .always
        textField.backgroundColor = .white
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("New User? Create an Account.", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        return button
    }()
    
    private let termButton: UIButton = {
        let button = UIButton()
        button.setTitle("Term of Use", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let privacyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Privacy Policy", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Log In"
        view.backgroundColor = .white
        createAccountButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        termButton.addTarget(self, action: #selector(didTapTerm), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTapPrivacy), for: .touchUpInside)
        // Do any additional setup after loading the view.
        imageView.translatesAutoresizingMaskIntoConstraints = false
        emailField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        termButton.translatesAutoresizingMaskIntoConstraints = false
        privacyButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(imageView)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(createAccountButton)
        view.addSubview(loginButton)
        view.addSubview(termButton)
        view.addSubview(privacyButton)

        setupConstraints()
    }
    
    @objc func didTapSignUp() {
        let vc = SignUpViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didTapLogin() {
        guard let email = emailField.text, let password = passwordField.text, !email.isEmpty, !password.isEmpty, password.count >= 6 else {
            alertUserLoginError()
            return
        }
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self?.navigationController?.dismiss(animated: true)
            }
        }
    }
    
    func alertUserLoginError() {
        let alert = UIAlertController(title: "Login Failed", message: "Please enter all information.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        present(alert, animated: true)
    }
    
    @objc func didTapTerm() {
        guard let url = URL(string: "https://help.instagram.com/581066165581870/?helpref=uf_share") else { return }
        let vc  = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc func didTapPrivacy() {
        guard let url = URL(string: "https://privacycenter.instagram.com/policy") else { return }
        let vc  = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 120),
            imageView.widthAnchor.constraint(equalToConstant: 120),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            emailField.heightAnchor.constraint(equalToConstant: 52),
            emailField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            emailField.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
        
        NSLayoutConstraint.activate([
            passwordField.heightAnchor.constraint(equalToConstant: 52),
            passwordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 10),
            passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
        
        NSLayoutConstraint.activate([
            createAccountButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            createAccountButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.heightAnchor.constraint(equalToConstant: 46),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginButton.topAnchor.constraint(equalTo: createAccountButton.bottomAnchor, constant: 10),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            termButton.heightAnchor.constraint(equalToConstant: 46),
            termButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            termButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            termButton.bottomAnchor.constraint(equalTo: privacyButton.topAnchor),
            termButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            privacyButton.heightAnchor.constraint(equalToConstant: 46),
            privacyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            privacyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            privacyButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            privacyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    

}
