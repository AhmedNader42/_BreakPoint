//
//  ProfileVC.swift
//  _BreakPoint
//
//  Created by ahmed on 9/10/18.
//  Copyright © 2018 ahmed. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ProfileVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        imagePicker.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.emailLabel.text = Auth.auth().currentUser?.email
    }
    
    func setupUI() {
        view.backgroundColor = #colorLiteral(red: 0.2549019608, green: 0.2705882353, blue: 0.3137254902, alpha: 1)
        
        view.addSubview(backgroundImage)
        containerView.addSubview(profileImage)
        view.addSubview(containerView)
        
        view.addSubview(logoutButton)
        view.addSubview(titleLabel)
        view.addSubview(emailLabel)
        view.addSubview(editImageButton)
        
        backgroundImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        backgroundImage.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backgroundImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backgroundImage.alpha = 0.5
        
        
        containerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        containerView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        containerView.bottomAnchor.constraint(equalTo: backgroundImage.topAnchor, constant: 250).isActive = true
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.layer.cornerRadius = 50
        containerView.clipsToBounds = true
        containerView.topColor = #colorLiteral(red: 0.09411764706, green: 0.6549019608, blue: 0.7803921569, alpha: 1)
        containerView.bottomColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        
        profileImage.heightAnchor.constraint(equalToConstant: 95).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 95).isActive = true
        profileImage.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        profileImage.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        profileImage.layer.cornerRadius = 47.5
        profileImage.clipsToBounds = true
        
        editImageButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        editImageButton.rightAnchor.constraint(equalTo: containerView.leftAnchor, constant: -8).isActive = true
        editImageButton.addTarget(self, action: #selector(editImagePressed), for: .touchUpInside)
        
        logoutButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        logoutButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        logoutButton.addTarget(self, action: #selector(logoutPressed), for: .touchUpInside)
        
        titleLabel.centerYAnchor.constraint(equalTo: logoutButton.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        emailLabel.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 20).isActive = true
        emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    @objc func editImagePressed() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func logoutPressed() {
        let alert = UIAlertController(title: "Logout" , message: "Are you sure you want to logout?", preferredStyle: .actionSheet)
        let getMeOutOfHereAction = UIAlertAction(title: "Get Me Out Of Here", style: .destructive) { (action) in
            
            do {
                try Auth.auth().signOut()
                GIDSignIn.sharedInstance().signOut()
                let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
                self.present(loginVC!, animated: true, completion: nil)
            } catch {
                print(error)
            }
        }
        let cancelAction = UIAlertAction(title: "No I want to stay", style: .cancel, handler: nil)
        alert.addAction(getMeOutOfHereAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    let logoutButton : UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "logoutIcon"), for: .normal)
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "menlo", size: 18)
        label.text = "_profile"
        label.textColor = #colorLiteral(red: 0.6221079826, green: 0.8111736774, blue: 0.3771412969, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    
    let emailLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0, green: 0.6862745098, blue: 0.7803921569, alpha: 1)
        label.font = UIFont(name: "menlo", size: 16)
        label.text = "userEmail@provider.com"
        label.textAlignment = .center
        return label
    }()
    
    let backgroundImage: UIImageView =  {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "loginBGImage"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let profileImage: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "defaultProfileImage"))
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let containerView: GradientView = {
        let myView = GradientView(frame: CGRect.zero)
        myView.translatesAutoresizingMaskIntoConstraints = false
        return myView
    }()
    
    let editImageButton : UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.textColor = .white
        button.setImage(#imageLiteral(resourceName: "addUserToGroup"), for: .normal)
        return button
    }()
    
    

    let imagePicker = UIImagePickerController()
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profileImage.image = pickedImage
            backgroundImage.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
}
