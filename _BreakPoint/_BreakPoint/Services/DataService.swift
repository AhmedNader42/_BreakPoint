//
//  DataService.swift
//  _BreakPoint
//
//  Created by ahmed on 9/9/18.
//  Copyright © 2018 ahmed. All rights reserved.
//

import Foundation
import Firebase


// Reference to the DB URL
let DB_BASE = Database.database().reference()
class DataService  {
    
    // Shared instance
    static let shared = DataService()
    
    
    // References
    private var _REF_BASE = DB_BASE
    private var _REF_IMAGES = DB_BASE.child("images")
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_GROUPS = DB_BASE.child("groups")
    private var _REF_FEED = DB_BASE.child("feed")
    
    
    // Getters
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    var REF_GROUPS: DatabaseReference {
        return _REF_GROUPS
    }
    
    var REF_FEED: DatabaseReference {
        return _REF_FEED
    }
    var REF_IMAGES: DatabaseReference {
        return _REF_IMAGES
    }
    
    func createDBUser(uid: String, userData: Dictionary<String,Any>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    
    func uploadPost(withMessage message: String, forUID uid: String, withGroupKey groupKey: String?, sendCompletion: @escaping (_ status: Bool)->()) {
        
        if groupKey != nil {
            REF_GROUPS.child(groupKey!).child("messages").childByAutoId().updateChildValues(["content": message,
                                                                                             "senderId": uid
                                                                                            ])
            sendCompletion(true)
        } else {
            REF_FEED.childByAutoId().updateChildValues(["content": message,
                                                        "senderId": uid
                                                        ])
            sendCompletion(true)
            return
        }
    }
    
    func getAllMessages(ForGroup group: Group, handler: @escaping (_ messages: [Message]) -> ()) {
        var messages = [Message]()
        REF_GROUPS.child(group.key).child("messages").observeSingleEvent(of: .value) { (messageSnapshot) in
            guard let messageSnapshot = messageSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for message in messageSnapshot {
                let content = message.childSnapshot(forPath: "content").value as! String
                let senderId = message.childSnapshot(forPath: "senderId").value as! String
                messages.append(Message(content: content, senderId: senderId))
            }
            handler(messages)
        }
    }
    
    
    func getAllFeedMessages(handler: @escaping (_ messages: [Message]) -> ()) {
        REF_FEED.observeSingleEvent(of: .value) { (feedMessageSnapshot) in
            
            var messageArray = [Message]()
            guard let feedMessageSnapshot = feedMessageSnapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            
            for message in feedMessageSnapshot {
                let content = message.childSnapshot(forPath: "content").value as! String
                let senderId = message.childSnapshot(forPath: "senderId").value as! String
                let message = Message(content: content, senderId: senderId)
                messageArray.append(message)
            }
            
            handler(messageArray)
            
        }
    }
    
    
    func getUsername(ForUID uid: String, handler: @escaping (_ username: String) -> ()) {
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            print(userSnapshot)
            for user in userSnapshot {
                if user.key == uid {
                    handler(user.childSnapshot(forPath: "email").value as! String)
                    return
                }
            }
        }
    }
    
    func getEmail(ForGroup group: Group, handler: @escaping (_ emails: [String]) -> () ) {
        var emailArray = [String]()
    
        REF_USERS.observeSingleEvent(of: .value) { (usersSnapshot) in
            guard let usersSnapshot = usersSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for user in usersSnapshot {
                if group.members.contains(user.key) {
                    let email = user.childSnapshot(forPath: "email").value as! String
                    emailArray.append(email)
                }
            }
            handler(emailArray)
        }
    }
    
    func getIds(ForUsernames usernames: [String], handler: @escaping (_ uidsArray: [String]) -> ()) {
        
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            var idArray = [String]()
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for user in userSnapshot {
                let email = user.childSnapshot(forPath: "email").value as! String
                if usernames.contains(email) {
                    idArray.append(user.key)
                }
            }
            handler(idArray)
        }
    }
    
    
    func createGroup(withName name: String, andDescription desc: String,forUserIds ids: [String], handler : (_ status: Bool) -> () ) {
        REF_GROUPS.childByAutoId().updateChildValues(["title": name,
                                                      "description": desc,
                                                      "members": ids
                                                      ])
        handler(true)
    }
    
    
    func getEmail(forSearchQuery query: String, completion: @escaping (_ emailsArray: [String]) -> ()) {
        
        var emailArray = [String]()
        REF_USERS.observe(.value) { (userSnapshot) in
            
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for user in userSnapshot {
                let email = user.childSnapshot(forPath: "email").value as! String
                if email.contains(query) && email != Auth.auth().currentUser?.email {
                    emailArray.append(email)
                }
            }
            completion(emailArray)
        }
    }
    
    
    func getAllGroups(handler: @escaping (_ groupArray: [Group]) -> ()) {
        var groupsArray = [Group]()
        
        REF_GROUPS.observeSingleEvent(of: .value) { (groupSnapshot) in
            guard let groupSnapshot = groupSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for group in groupSnapshot {
                let memberArray = group.childSnapshot(forPath: "members").value as! [String]
                if memberArray.contains((Auth.auth().currentUser?.uid)!) {
                    let title = group.childSnapshot(forPath: "title").value as! String
                    let description = group.childSnapshot(forPath: "description").value as! String
                    let addedGroup = Group(title: title, description: description, key: group.key, memberCount: memberArray.count, members: memberArray)
                    groupsArray.append(addedGroup)
                }
            }
            
            handler(groupsArray)
        }
    }
}












