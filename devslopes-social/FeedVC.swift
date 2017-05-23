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

class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func signOutTapped(_ sender: Any) {


            let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
            print("########Keychain Signout#######")
            print("Dileep: ID removed from keychain: \(keychainResult)")
            try! FIRAuth.auth()?.signOut()
            performSegue(withIdentifier: "goToSignIn", sender: nil)


    }

}
