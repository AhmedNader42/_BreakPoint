//
//  feedCell.swift
//  _BreakPoint
//
//  Created by ahmed on 9/10/18.
//  Copyright © 2018 ahmed. All rights reserved.
//

import UIKit

class feedCell: UITableViewCell {
    
    
    func setup(content: String, senderID: String) {
        setupUI()
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        self.userEmailLabel.text = senderID
        self.textView.text = content
    }
    
    private func setupUI() {
        self.contentView.addSubview(profileImageView)
        self.contentView.addSubview(userEmailLabel)
        self.contentView.addSubview(textView)
        
        profileImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 8).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        userEmailLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor).isActive = true
        userEmailLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8).isActive = true
        
        textView.topAnchor.constraint(equalTo: userEmailLabel.bottomAnchor, constant: 8).isActive = true
        textView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        textView.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8).isActive = true
        textView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8).isActive = true
        
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
        label.font = UIFont(name: "menlo", size: 10)
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
        tv.isEditable = false
        return tv
    }()
    

}
