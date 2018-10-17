//
//  LoginVC.swift
//  _BreakPoint
//
//  Created by ahmed on 9/9/18.
//  Copyright © 2018 ahmed. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
class LoginVC: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if Auth.auth().currentUser != nil {
            dismiss(animated: true, completion: nil)
        }
    }
    
    
    @objc func loginWithFacebookPressed() {
        
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            let userData = ["provider": authResult?.user.providerID,
                            "email" : authResult?.user.email
            ]
            DataService.shared.createDBUser(uid: (authResult?.user.uid)!, userData: userData)
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    // MARK :- UI Setup
    func setupUI() {
        view.backgroundColor = #colorLiteral(red: 0.2126879096, green: 0.2239724994, blue: 0.265286684, alpha: 1)
        view.addSubview(loginImage)
        view.addSubview(titleLabel)
        view.addSubview(loginView)
        loginView.addSubview(loginButtonsStack)
        
        
        // Image
        loginImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        loginImage.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        loginImage.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        loginImage.heightAnchor.constraint(equalToConstant: 334).isActive = true
        
        // Title label
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        // Login View
        loginView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loginView.heightAnchor.constraint(equalToConstant: 343).isActive = true
        loginView.widthAnchor.constraint(equalToConstant: 370).isActive = true
        
        // Login Buttons stack
        loginButtonsStack.addArrangedSubview(loginLabel)
        loginButtonsStack.addArrangedSubview(loginFacebookButton)
        loginButtonsStack.addArrangedSubview(loginGoogleButton)
        loginButtonsStack.addArrangedSubview(orLabel)
        loginButtonsStack.addArrangedSubview(loginEmailButton)
        
        loginButtonsStack.topAnchor.constraint(equalTo: loginView.topAnchor,constant: 16).isActive = true
        loginButtonsStack.leftAnchor.constraint(equalTo: loginView.leftAnchor,constant: 16).isActive = true
        loginButtonsStack.rightAnchor.constraint(equalTo: loginView.rightAnchor,constant: -16).isActive = true
        loginButtonsStack.bottomAnchor.constraint(equalTo: loginView.bottomAnchor, constant: -16).isActive = true
        
        loginEmailButton.addTarget(self, action: #selector(loginWithEmailPressed), for: .touchUpInside)
        loginFacebookButton.addTarget(self, action: #selector(loginWithFacebookPressed), for: .touchUpInside)
    }
    
    
    
    let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.6221079826, green: 0.8111736774, blue: 0.3771412969, alpha: 1)
        label.font = UIFont(name: "menlo", size: 24)
        label.text = "_breakpoint"
        return label
    }()
    
    let loginImage: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "loginBGImage"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let loginView: ShadowView = {
        let lView = ShadowView(frame: .zero)
        lView.translatesAutoresizingMaskIntoConstraints = false
        lView.backgroundColor = #colorLiteral(red: 0.2549019608, green: 0.2705882353, blue: 0.3137254902, alpha: 1)
        
        return lView
    }()
    
    let loginButtonsStack: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        stackView.axis = .vertical
        return stackView
    }()
    
    let loginLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.6221079826, green: 0.8111736774, blue: 0.3771412969, alpha: 1)
        label.font = UIFont(name: "menlo", size: 18)
        label.text = "_login"
        label.textAlignment = .center
        return label
    }()
    
    let orLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.6221079826, green: 0.8111736774, blue: 0.3771412969, alpha: 1)
        label.font = UIFont(name: "menlo", size: 18)
        label.text = "OR"
        label.textAlignment = .center
        return label
    }()
    
    let loginFacebookButton : UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.textColor = .white
        button.setTitle("Login with Facebook", for: .normal)
        button.titleLabel?.font = UIFont(name: "menlo", size: 18)
        button.backgroundColor = #colorLiteral(red: 0.262745098, green: 0.3568627451, blue: 0.568627451, alpha: 1)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        return button
    }()
    
    let loginGoogleButton: GIDSignInButton = {
        let button = GIDSignInButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.style = .standard
        return button
    }()
    
    let loginEmailButton : UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.textColor = .white
        button.setTitle("Login with Email", for: .normal)
        button.titleLabel?.font = UIFont(name: "menlo", size: 14)
        button.layer.cornerRadius = 20
        button.setImage(#imageLiteral(resourceName: "emailIcon"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10)
        return button
    }()
    
    
    // Mark : Target Actions
    @objc func loginWithEmailPressed() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "LoginEmailVC") else {
            return
        }
        
        present(vc, animated: true, completion: nil)
    }
    
    
}







