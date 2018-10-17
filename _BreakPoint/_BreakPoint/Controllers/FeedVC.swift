//
//  FirstViewController.swift
//  _BreakPoint
//
//  Created by ahmed on 9/2/18.
//  Copyright © 2018 ahmed. All rights reserved.
//

import UIKit

class FeedVC: UIViewController {

    var messagesArray = [Message]()
    
    override func viewDidAppear(_ animated: Bool) {
        DataService.shared.getAllFeedMessages { (messages) in
            DispatchQueue.main.async {
                self.messagesArray = messages.reversed() 
                self.tableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(feedCell.self, forCellReuseIdentifier: "feedCell")
        tableView.rowHeight = 100
        tableView.reloadData()
        
        
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
        topView.addSubview(composePostButton)
        topView.addSubview(titleLabel)
        
        
        topView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        composePostButton.rightAnchor.constraint(equalTo: topView.rightAnchor, constant: -20).isActive = true
        composePostButton.topAnchor.constraint(equalTo: topView.topAnchor, constant: 40).isActive = true
        composePostButton.addTarget(self, action: #selector(composePressed), for: .touchUpInside)
        
        titleLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 45).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        
        tableView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    @objc func composePressed() {
        let postVC = storyboard?.instantiateViewController(withIdentifier: "PostVC")
        present(postVC!, animated: true, completion: nil)
    }
    
    let topView: UIView = {
        let lView = UIView(frame: .zero)
        lView.translatesAutoresizingMaskIntoConstraints = false
        lView.backgroundColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 0.939265839)
        return lView
    }()
    
    let composePostButton : UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "addNewIcon"), for: .normal)
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "menlo", size: 18)
        label.text = "_feed"
        label.textColor = #colorLiteral(red: 0.6221079826, green: 0.8111736774, blue: 0.3771412969, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    
    let tableView: UITableView = {
       let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.allowsSelection = false
        table.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return table
    }()

}



extension FeedVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! feedCell
        let message = messagesArray[indexPath.row]
        DataService.shared.getUsername(ForUID: message.senderId) { (returnedUserName) in
            cell.setup(content: message.content, senderID: returnedUserName)
        }
        return cell
    }
}

