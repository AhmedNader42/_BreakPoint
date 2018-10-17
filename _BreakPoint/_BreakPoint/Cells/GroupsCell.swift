//
//  groupsCell.swift
//  _BreakPoint
//
//  Created by ahmed on 9/10/18.
//  Copyright © 2018 ahmed. All rights reserved.
//

import UIKit

class GroupsCell: UITableViewCell {
    
    func setup(title: String, description: String, memberCount: Int) {
        setupUI()
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        titleLabel.text = title
        descriptionLabel.text = description
        membersLabel.text = String(describing: memberCount) + " Members"
    }
    
    
    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(membersLabel)
        
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        
        membersLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8).isActive = true
        membersLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
    }
    
    let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor =  UIColor(red: 0.6221079826, green: 0.8111736774, blue: 0.3771412969, alpha: 1)
        label.font = UIFont(name: "menlo", size: 20)
        label.text = "_groupTitle"
        label.textAlignment = .left
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor =  UIColor(red: 0.6221079826, green: 0.8111736774, blue: 0.3771412969, alpha: 1)
        label.font = UIFont(name: "menlo", size: 16)
        label.text = "description"
        label.textAlignment = .left
        return label
    }()
    
    let membersLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor =  UIColor(red: 0.6221079826, green: 0.8111736774, blue: 0.3771412969, alpha: 1)
        label.font = UIFont(name: "menlo", size: 16)
        label.text = "members"
        label.textAlignment = .left
        return label
    }()
}
