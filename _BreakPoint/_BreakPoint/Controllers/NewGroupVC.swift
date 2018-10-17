//
//  NewGroupVC.swift
//  _BreakPoint
//
//  Created by ahmed on 9/12/18.
//  Copyright © 2018 ahmed. All rights reserved.
//

import UIKit
import Firebase
class NewGroupVC: UIViewController {

    var emailArray = [String]()
    var choosenOnes = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UserCell.self, forCellReuseIdentifier: "userCell")
        tableView.rowHeight = 60
        tableView.reloadData()
        doneButton.isHidden = true
        addPeopleTextField.delegate = self
        addPeopleTextField.addTarget(self, action: #selector(newInputChange), for: .editingChanged)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
        doneButton.isHidden = true
        tableView.backgroundColor = #colorLiteral(red: 0.2126879096, green: 0.2239724994, blue: 0.265286684, alpha: 1)
        tableView.backgroundView = nil
    }
    func setupUI() {
        view.backgroundColor =  UIColor(red: 0.2549019608, green: 0.2705882353, blue: 0.3137254902, alpha: 1)
        topView.addSubview(dismissButton)
        view.addSubview(topView)
        topView.addSubview(titleLabel)
        topView.addSubview(dismissButton)
        topView.addSubview(doneButton)
        view.addSubview(contentStack)
        contentStack.addArrangedSubview(titleFieldLabel)
        contentStack.addArrangedSubview(titleTextField)
        contentStack.addArrangedSubview(descriptionLabel)
        contentStack.addArrangedSubview(descriptionTextField)
        contentStack.addArrangedSubview(addPeopleLabel)
        contentStack.addArrangedSubview(addPeopleTextField)
        contentStack.addArrangedSubview(tableView)
        
        topView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        titleLabel.centerYAnchor.constraint(equalTo: topView.centerYAnchor,constant: 10).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        
        dismissButton.centerYAnchor.constraint(equalTo: topView.centerYAnchor,constant: 10).isActive = true
        dismissButton.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 16).isActive = true
        dismissButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        
        doneButton.rightAnchor.constraint(equalTo: topView.rightAnchor, constant: -20).isActive = true
        doneButton.centerYAnchor.constraint(equalTo: topView.centerYAnchor,constant: 10).isActive = true
        doneButton.addTarget(self, action: #selector(donePressed), for: .touchUpInside)
        
        contentStack.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 10).isActive = true
        contentStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8).isActive = true
        contentStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        contentStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        
        titleTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        descriptionTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        addPeopleTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        titleFieldLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        addPeopleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        tableView.heightAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
    @objc func donePressed() {
        if titleTextField.hasText && descriptionTextField.hasText {
            DataService.shared.getIds(ForUsernames: choosenOnes) { (idsArray) in
                var userIds = idsArray
                userIds.append((Auth.auth().currentUser?.uid)!)
                DataService.shared.createGroup(withName: self.titleTextField.text!, andDescription: self.descriptionTextField.text!, forUserIds: userIds, handler: { (success) in
                    if success {
                        DispatchQueue.main.async {
                            self.close()
                        }
                    }else {
                        print("Please try again")
                    }
                })
            }
        }
        
    }
    
    @objc func newInputChange() {
        if addPeopleTextField.hasText {
            DataService.shared.getEmail(forSearchQuery: addPeopleTextField.text!) { (emails) in
                DispatchQueue.main.async {
                    self.emailArray = emails
                    self.tableView.reloadData()
                }
            }
        } else {
            emailArray.removeAll()
            tableView.reloadData()
        }
    }
    
    @objc func close() {
        dismiss(animated: true, completion: nil)
    }
    
    let dismissButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage( UIImage(named: "close"), for: .normal)
        return button
    }()
    
    let doneButton : UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Done", for: .normal)
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
        label.text = "_newGroup"
        label.textColor =  UIColor(red: 0.6221079826, green: 0.8111736774, blue: 0.3771412969, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    
    let titleFieldLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor =  UIColor(red: 0.6221079826, green: 0.8111736774, blue: 0.3771412969, alpha: 1)
        label.font = UIFont(name: "menlo", size: 14)
        label.text = "title"
        label.textAlignment = .left
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor =  UIColor(red: 0.6221079826, green: 0.8111736774, blue: 0.3771412969, alpha: 1)
        label.font = UIFont(name: "menlo", size: 14)
        label.text = "description"
        label.textAlignment = .left
        return label
    }()
    
    let addPeopleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor =  UIColor(red: 0.6221079826, green: 0.8111736774, blue: 0.3771412969, alpha: 1)
        label.font = UIFont(name: "menlo", size: 14)
        label.text = "Add People To Your Group"
        label.minimumScaleFactor = 0.3
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        return label
    }()
    
    let titleTextField: InsetTextField = {
        let textField = InsetTextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = #colorLiteral(red: 0.2656834778, green: 0.2802070723, blue: 0.332586453, alpha: 1)
        textField.placeholder = "It Shall be named...."
        textField.font = UIFont(name: "menlo", size: 14)
        textField.textColor = #colorLiteral(red: 0, green: 0.7235742211, blue: 0.8151144385, alpha: 1)
        return textField
    }()
    
    let descriptionTextField: InsetTextField = {
        let textField = InsetTextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = #colorLiteral(red: 0.2656834778, green: 0.2802070723, blue: 0.332586453, alpha: 1)
        textField.placeholder = "We are here for...."
        textField.font = UIFont(name: "menlo", size: 14)
        textField.textColor = #colorLiteral(red: 0, green: 0.7235742211, blue: 0.8151144385, alpha: 1)
        return textField
    }()
    
    let addPeopleTextField: InsetTextField = {
        let textField = InsetTextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor =  UIColor(red: 0.2656834778, green: 0.2802070723, blue: 0.332586453, alpha: 1)
        textField.placeholder = "These people shall join me...."
        textField.font = UIFont(name: "menlo", size: 14)
        textField.textColor =  UIColor(red: 0, green: 0.7235742211, blue: 0.8151144385, alpha: 1)
        textField.autocapitalizationType = .none
        return textField
    }()
    
    let tableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.allowsMultipleSelection = true
        table.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return table
    }()
    
    let contentStack: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        stackView.axis = .vertical
        return stackView
    }()
}


extension NewGroupVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserCell
        
        let email = emailArray[indexPath.row]
        if choosenOnes.contains(email) {
            cell.setup(email: email, isSelected: true)
        } else {
            cell.setup(email: email, isSelected: false)
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UserCell else { return }
        let email = cell.userEmail.text!
        if !(choosenOnes.contains(email)) {
            choosenOnes.append(email)
            addPeopleLabel.text = choosenOnes.joined(separator: ", ")
            doneButton.isHidden = false
        } else {
            choosenOnes = choosenOnes.filter({
                $0 != email
            })
            if choosenOnes.count > 0 {
                addPeopleLabel.text = choosenOnes.joined(separator: ", ")
            } else {
                addPeopleLabel.text = "Add people to your group"
                doneButton.isHidden = true
            }
        }
    }
}


extension NewGroupVC: UITextFieldDelegate {
    
}



