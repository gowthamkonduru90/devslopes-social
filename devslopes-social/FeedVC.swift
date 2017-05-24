//
//  FeedVC.swift
//  devslopes-social
//
//  Created by Dileep Gadiraju on 5/22/17.
//  Copyright © 2017 Dileep Gadiraju. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView : UITableView!
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        DataService.ds.REF_POSTS.observe(.value, with: {( snapshot ) in
            //print(snapshot.value)
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    print("SNAP-- : \(snap)")
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        self.posts.append(post)
                    }
                }
            }
            self.tableView.reloadData()
        })
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let post = posts[indexPath.row]
        //print("CAPTION: \(post.caption)")
        let post = posts[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell {
            cell.configureCell(post: post)
            return cell
        } else {
            return PostCell()
        }
        
        //return cell
    }
    
    
    @IBAction func signOutTapped(_ sender: Any) {


            let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
            print("########Keychain Signout#######")
            print("Dileep: ID removed from keychain: \(keychainResult)")
            try! FIRAuth.auth()?.signOut()
            performSegue(withIdentifier: "goToSignIn", sender: nil)


    }

}
