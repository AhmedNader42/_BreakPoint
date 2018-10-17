//
//  SecondViewController.swift
//  _BreakPoint
//
//  Created by ahmed on 9/2/18.
//  Copyright © 2018 ahmed. All rights reserved.
//

import UIKit

class GroupsVC: UIViewController {
    var groupsArray = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(GroupsCell.self, forCellReuseIdentifier: "groupsCell")
        tableView.rowHeight = 100
        tableView.reloadData()
        newGroupButton.addTarget(self, action: #selector(newGroupPressed), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DataService.shared.REF_GROUPS.observe(.value) { (snapshot) in
            DataService.shared.getAllGroups { (returnedGroups) in
                DispatchQueue.main.async {
                    self.groupsArray = returnedGroups
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.backgroundColor = #colorLiteral(red: 0.2126879096, green: 0.2239724994, blue: 0.265286684, alpha: 1)
        tableView.backgroundView = nil
    }
    
    func setupUI() {
        view.backgroundColor = #colorLiteral(red: 0.2549019608, green: 0.2705882353, blue: 0.3137254902, alpha: 1)
        
        view.addSubview(topView)
        view.addSubview(tableView)
        topView.addSubview(newGroupButton)
        topView.addSubview(titleLabel)
        
        
        topView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        newGroupButton.rightAnchor.constraint(equalTo: topView.rightAnchor, constant: -20).isActive = true
        newGroupButton.topAnchor.constraint(equalTo: topView.topAnchor, constant: 40).isActive = true
        
        
        titleLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 45).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        
        tableView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    @objc func newGroupPressed() {
        let newGroup = storyboard?.instantiateViewController(withIdentifier: "NewGroupVC") ?? UIViewController()
        present(newGroup, animated: true, completion: nil)
    }
    
    let topView: UIView = {
        let lView = UIView(frame: .zero)
        lView.translatesAutoresizingMaskIntoConstraints = false
        lView.backgroundColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 0.939265839)
        return lView
    }()
    
    let newGroupButton : UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "compose"), for: .normal)
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "menlo", size: 18)
        label.text = "_groups"
        label.textColor = #colorLiteral(red: 0.6221079826, green: 0.8111736774, blue: 0.3771412969, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    
    let tableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return table
    }()
    
}



extension GroupsVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupsCell", for: indexPath) as! GroupsCell
        let group = groupsArray[indexPath.row]
        cell.setup(title: group.title, description: group.description, memberCount: group.memberCount)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let groupFeed = storyboard?.instantiateViewController(withIdentifier: "GroupFeedVC") as! GroupFeedVC
        groupFeed.initData(ForGroup: groupsArray[indexPath.row])
        presentDetail(groupFeed)
    }
}

