//
//  GroupFeedVC.swift
//  _BreakPoint
//
//  Created by ahmed on 9/14/18.
//  Copyright © 2018 ahmed. All rights reserved.
//

import UIKit
import Firebase
class GroupFeedVC: UIViewController {
    var group: Group?
    var messages = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableView.rowHeight = 120
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(GroupFeedCell.self, forCellReuseIdentifier: "groupFeedCell")
        tableView.reloadData()
        sendView.bindToKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleLabel.text = group?.title
        DataService.shared.getEmail(ForGroup: self.group!) { (emailsArray) in
            DispatchQueue.main.async {
                self.membersLabel.text = emailsArray.joined(separator: ", ")
            }
        }
        
        DataService.shared.REF_GROUPS.observe(.value) { (_) in
            DataService.shared.getAllMessages(ForGroup: self.group!) { (messages) in
                DispatchQueue.main.async {
                    self.messages = messages
                    self.tableView.reloadData()
                    if self.messages.count > 0 {
                        self.tableView.scrollToRow(at: IndexPath(row: self.messages.count - 1, section: 0), at: .bottom , animated: true)
                    }
                }
                
                
            }
        }
        
        tableView.backgroundColor = #colorLiteral(red: 0.2126879096, green: 0.2239724994, blue: 0.265286684, alpha: 1)
        tableView.backgroundView = nil
    }
    
    
    func initData(ForGroup group: Group) {
        self.group = group
    } 
    
    
    func setupUI() {
        view.backgroundColor =  UIColor(red: 0.2549019608, green: 0.2705882353, blue: 0.3137254902, alpha: 1)
        
        topView.addSubview(dismissButton)
        view.addSubview(topView)
        topView.addSubview(titleLabel)
        topView.addSubview(dismissButton)
        topView.addSubview(leaveButton)
        view.addSubview(membersLabel)
        view.addSubview(tableView)
        view.addSubview(sendView)
        sendView.addSubview(messageTextField)
        sendView.addSubview(sendButton)
        
        topView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 45).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        
        dismissButton.topAnchor.constraint(equalTo: topView.topAnchor, constant: 32).isActive = true
        dismissButton.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 16).isActive = true
        dismissButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        
        leaveButton.rightAnchor.constraint(equalTo: topView.rightAnchor, constant: -20).isActive = true
        leaveButton.topAnchor.constraint(equalTo: topView.topAnchor, constant: 40).isActive = true
        leaveButton.addTarget(self, action: #selector(donePressed), for: .touchUpInside)
        
        membersLabel.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 0).isActive = true
        membersLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        membersLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        
        tableView.topAnchor.constraint(equalTo: membersLabel.bottomAnchor, constant: 8).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: sendView.leftAnchor).isActive = true
        
        sendView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        sendView.topAnchor.constraint(equalTo: tableView.bottomAnchor).isActive = true
        sendView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        sendView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        sendView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        messageTextField.centerYAnchor.constraint(equalTo: sendView.centerYAnchor).isActive = true
        messageTextField.leftAnchor.constraint(equalTo: sendView.leftAnchor, constant: 8).isActive = true
        messageTextField.rightAnchor.constraint(equalTo: sendButton.leftAnchor, constant: -16).isActive = true
        messageTextField.topAnchor.constraint(equalTo: sendView.topAnchor, constant: 16).isActive = true
        messageTextField.bottomAnchor.constraint(equalTo: sendView.bottomAnchor, constant: -16).isActive = true
        
        sendButton.centerYAnchor.constraint(equalTo: messageTextField.centerYAnchor).isActive = true
        sendButton.rightAnchor.constraint(equalTo: sendView.rightAnchor, constant: -10).isActive = true
        sendButton.addTarget(self, action: #selector(sendPressed), for: .touchUpInside)
    }
    
    @objc func sendPressed() {
        if messageTextField.hasText {
            sendButton.isEnabled = false
            DataService.shared.uploadPost(withMessage: messageTextField.text!, forUID: (Auth.auth().currentUser?.uid)!, withGroupKey: group?.key) { (status) in
                DispatchQueue.main.async {
                    self.sendButton.isEnabled = true
                    self.tableView.reloadData()
                    self.messageTextField.text = ""
                }
            }
        }
    }
    
    @objc func donePressed() {
        
    }
    
    @objc func close() {
        dismissDetail()
    }
    
    let dismissButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage( UIImage(named: "close"), for: .normal)
        return button
    }()
    
    let leaveButton : UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("LEAVE", for: .normal)
        button.setTitleColor(.red, for: .normal)
        return button
    }()
    
    let topView: UIView = {
        let lView = UIView(frame: .zero)
        lView.translatesAutoresizingMaskIntoConstraints = false
        lView.backgroundColor =  UIColor(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 0.939265839)
        return lView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "menlo", size: 18)
        label.text = "_groupTitle"
        label.textColor =  UIColor(red: 0.6221079826, green: 0.8111736774, blue: 0.3771412969, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    
    let membersLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor =  UIColor(red: 0.6221079826, green: 0.8111736774, blue: 0.3771412969, alpha: 1)
        label.font = UIFont(name: "menlo", size: 18)
        label.text = "Ahmed, mohammed, Abbas"
        label.textAlignment = .left
        return label
    }()
    
    let tableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.allowsSelection = false
        table.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return table
    }()
    
    
    let sendView: UIView = {
        let lView = UIView(frame: .zero)
        lView.translatesAutoresizingMaskIntoConstraints = false
        lView.backgroundColor =  UIColor(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 0.939265839)
        return lView
    }()
    
    let messageTextField: InsetTextField = {
        let textField = InsetTextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor =  UIColor(red: 0.2656834778, green: 0.2802070723, blue: 0.332586453, alpha: 1)
        textField.placeholder = "Send them a message"
        textField.font = UIFont(name: "menlo", size: 14)
        textField.textColor =  UIColor(red: 0, green: 0.7235742211, blue: 0.8151144385, alpha: 1)
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let sendButton : UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "send"), for: .normal)
        button.backgroundColor =  .clear
        return button
    }()
}


extension GroupFeedVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupFeedCell", for: indexPath) as! GroupFeedCell
        let message = messages[indexPath.row]
        DataService.shared.getUsername(ForUID: message.senderId) { (username) in
            DispatchQueue.main.async {
                cell.setup(image: #imageLiteral(resourceName: "defaultProfileImage"),email: username, content: message.content)
            }
        }
        return cell
    }
    
    
    
}
