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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
    }
    
    
    @IBAction func signOutTapped(_ sender: Any) {


            let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
            print("########Keychain Signout#######")
            print("Dileep: ID removed from keychain: \(keychainResult)")
            try! FIRAuth.auth()?.signOut()
            performSegue(withIdentifier: "goToSignIn", sender: nil)


    }

}
