
//
//  UserCell.swift
//  _BreakPoint
//
//  Created by ahmed on 9/13/18.
//  Copyright © 2018 ahmed. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    var showing = false
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        checkMarkImage.isHidden = !showing
        showing = !showing
    }
    
    func setup(email: String, isSelected: Bool) {
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        setupUI()
        userEmail.text = email
        checkMarkImage.isHidden = !isSelected
        showing = isSelected
    }
    
    private func setupUI() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(userEmail)
        contentView.addSubview(checkMarkImage)
        
        profileImageView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 45).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        userEmail.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8).isActive = true
        userEmail.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        userEmail.rightAnchor.constraint(equalTo: checkMarkImage.leftAnchor, constant: -8).isActive = true
        
        checkMarkImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        checkMarkImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        checkMarkImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        checkMarkImage.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        
        
        
    }
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView(image:  UIImage(named: "defaultProfileImage"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let userEmail: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor =  UIColor(red: 0.6221079826, green: 0.8111736774, blue: 0.3771412969, alpha: 1)
        label.font = UIFont(name: "menlo", size: 17)
        label.textAlignment = .left
        return label
    }()
    
    let checkMarkImage: UIImageView = {
        let imageView = UIImageView(image:  #imageLiteral(resourceName: "whiteCheckmark"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
}
