 //
//  PostVC.swift
//  _BreakPoint
//
//  Created by ahmed on 9/10/18.
//  Copyright © 2018 ahmed. All rights reserved.
//

import UIKit
import Firebase
 
class PostVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.userEmailLabel.text = Auth.auth().currentUser?.email
    }
    
    func setupUI() {
        view.backgroundColor = #colorLiteral(red: 0.2549019608, green: 0.2705882353, blue: 0.3137254902, alpha: 1)
        
        topView.addSubview(dismissButton)
        view.addSubview(topView)
        topView.addSubview(titleLabel)
        view.addSubview(profileImageView)
        view.addSubview(userEmailLabel)
        view.addSubview(textView)
        view.addSubview(postButton)
        
        
        topView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        
        titleLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 45).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        
        dismissButton.topAnchor.constraint(equalTo: topView.topAnchor, constant: 32).isActive = true
        dismissButton.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 16).isActive = true
        dismissButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        
        profileImageView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 16).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        userEmailLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
        userEmailLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8).isActive = true
        
        textView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8).isActive = true
        textView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        textView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        textView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        
        postButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8).isActive = true
        postButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        postButton.addTarget(self, action: #selector(sendPost), for: .touchUpInside)
        
    }
    
    @objc func sendPost() {
        if textView.hasText || textView.text != "...." {
            postButton.isEnabled = false
            DataService.shared.uploadPost(withMessage: textView.text, forUID: (Auth.auth().currentUser?.uid)!, withGroupKey: nil) { (success) in
                if success {
                    self.close()
                } else {
                    print("Error in sending post")
                }
                self.postButton.isEnabled = true
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
    
    
    let topView: UIView = {
        let lView = UIView(frame: .zero)
        lView.translatesAutoresizingMaskIntoConstraints = false
        lView.backgroundColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 0.939265839)
        return lView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "menlo", size: 18)
        label.text = "_postSomething"
        label.textColor = #colorLiteral(red: 0.6221079826, green: 0.8111736774, blue: 0.3771412969, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView(image:  #imageLiteral(resourceName: "defaultProfileImage"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let userEmailLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor =  #colorLiteral(red: 0, green: 0.7235742211, blue: 0.8151144385, alpha: 1)
        label.font = UIFont(name: "menlo", size: 14)
        label.text = "userEmail@provider.com"
        label.textAlignment = .center
        return label
    }()
    
    
    let textView: UITextView = {
        let tv = UITextView(frame: .zero)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .clear
        tv.textColor = #colorLiteral(red: 0, green: 0.7235742211, blue: 0.8151144385, alpha: 1)
        tv.font = UIFont(name: "menlo", size: 22)
        tv.text = "...."
        tv.clearsOnInsertion = true
        return tv
    }()
    
    let postButton : UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("POST", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.6221079826, green: 0.8111736774, blue: 0.3771412969, alpha: 1), for: .normal)
        button.setImage(#imageLiteral(resourceName: "send"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left:0, bottom: 0, right: 10)
        button.titleLabel?.font = UIFont(name: "menlo", size: 20)
        button.backgroundColor =  .clear
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        return button
    }()
}
 
 
 extension PostVC {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
 }
 
 
 
 
 
 
 
 
 
 
 
