//
//  GroupFeedCell.swift
//  _BreakPoint
//
//  Created by ahmed on 9/14/18.
//  Copyright © 2018 ahmed. All rights reserved.
//

import UIKit

class GroupFeedCell: UITableViewCell {

    func setup(image: UIImage, email: String, content: String) {
        setupUI()
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        self.userEmailLabel.text = email
        self.textView.text = content
        self.profileImageView.image = image
    }
    
    
    
    private func setupUI() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(userEmailLabel)
        contentView.addSubview(textView)
        
        profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 45).isActive = true
        
        userEmailLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor).isActive = true
        userEmailLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8).isActive = true
        
        textView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25).isActive = true
        textView.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8).isActive = true
        textView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8).isActive = true
        textView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
   
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView(image:  UIImage(named: "defaultProfileImage"))
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
        tv.font = UIFont(name: "menlo", size: 12)
        tv.text = "Some content in here"
        tv.isEditable = false
        return tv
    }()

}
