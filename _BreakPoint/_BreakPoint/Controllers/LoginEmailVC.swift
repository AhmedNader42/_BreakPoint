//
//  loginEmailVC.swift
//  _BreakPoint
//
//  Created by ahmed on 9/9/18.
//  Copyright © 2018 ahmed. All rights reserved.
//

import UIKit

class LoginEmailVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        dismissButton.addTarget(self, action: #selector(close), for: .touchUpInside)
    }
    
    func setupUI() {
        view.backgroundColor = #colorLiteral(red: 0.2126879096, green: 0.2239724994, blue: 0.265286684, alpha: 1)
        view.addSubview(dismissButton)
        view.addSubview(loginButtonsStack)
        
        
        dismissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 32).isActive = true
        dismissButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        
        loginButtonsStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        loginButtonsStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        loginButtonsStack.topAnchor.constraint(equalTo: dismissButton.bottomAnchor, constant: 8).isActive = true
        
        emailTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        loginButtonsStack.addArrangedSubview(loginEmailLabel)
        loginButtonsStack.addArrangedSubview(emailTextField)
        loginButtonsStack.addArrangedSubview(passwordTextField)
        loginButtonsStack.addArrangedSubview(loginButton)
        
        
        // Target Actions
        loginButton.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
    }
    
    @objc func loginPressed() {
        if emailTextField.hasText && passwordTextField.hasText {
            AuthService.shared.loginUser(withEmail: emailTextField.text!, andPassword: passwordTextField.text!) { (success, error) in
                if success {
                    self.close()
                    print("Signed in successfully")
                    return
                } else {
                    print(error?.localizedDescription as Any)
                }
                
                
                AuthService.shared.registerUser(withEmail: self.emailTextField.text!, andPassword: self.passwordTextField.text!, userCreationCompletion: { (success, error) in
                    if success {
                        AuthService.shared.loginUser(withEmail: self.emailTextField.text!, andPassword: self.passwordTextField.text!) { (success, error) in
                            if success {
                                self.close()
                                print("Signed in successfully after registeration")
                                return
                            } else {
                                print(error?.localizedDescription as Any)
                            }
                        }
                    } else {
                        print(error?.localizedDescription as Any)
                    }
                })
                
            }
        }
    }
    
    
    @objc func close() {
        dismiss(animated: true, completion: nil)
    }
    
    let dismissButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "close"), for: .normal)
        return button
    }()
    
    let loginButtonsStack: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        stackView.spacing = 20
        stackView.axis = .vertical
        return stackView
    }()
    
    let loginEmailLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.6221079826, green: 0.8111736774, blue: 0.3771412969, alpha: 1)
        label.font = UIFont(name: "menlo", size: 24)
        label.text = "_loginByEmail"
        label.textAlignment = .center
        return label
    }()
    
    let loginButton : UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.textColor = #colorLiteral(red: 0.6221079826, green: 0.8111736774, blue: 0.3771412969, alpha: 1)
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = UIFont(name: "menlo", size: 24)
        return button
    }()
    
    let emailTextField: InsetTextField = {
        let textField = InsetTextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont(name: "menlo", size: 20)
        textField.backgroundColor = .white
        textField.placeholder = "Email"
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        return textField
    }()
    
    let passwordTextField: InsetTextField = {
        let textField = InsetTextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont(name: "menlo", size: 20)
        textField.backgroundColor = .white
        textField.isSecureTextEntry = true
        textField.placeholder = "Password"
        textField.keyboardType = .phonePad
        textField.autocapitalizationType = .none
        return textField
    }()
    
    
    
}
