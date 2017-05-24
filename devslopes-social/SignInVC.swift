//
//  ViewController.swift
//  devslopes-social
//
//  Created by Dileep Gadiraju on 5/17/17.
//  Copyright © 2017 Dileep Gadiraju. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase
import SwiftKeychainWrapper

class SignInVC: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var pwdField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            performSegue(withIdentifier: "goToFeed", sender: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func facebookBtnTapped(_ sender: Any) {
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("------------FB Error------")
                print("Dileep: Unable to authenticate with facebook - \(error!)")
                print("------------------------")
            } else if result?.isCancelled == true {
                print("--------FB Cancel-----")
                print("Dileep: User Cancelled authentication with Facebook ")
                print("----------------------------")
            }else {
                print("--------FB Authenticated--------")
                print("Dileep: Successfully authenticated with Facebook ")
                print("---------------------------")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
    }
    
    
    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("------------FireBase Error----")
                print("Dileep: Unable to authenticate with Firebase\(error!)")
                print("--------------------------")
            } else {
                print("------------FireBase Authenticated----")
                print("Dileep: Successfully User authenticated with Firebase ")
                print("-------------------------------------")
                if let user = user {
                    let userData = ["provider": credential.provider]
                    self.completeSignIn(uid: user.uid, userData: userData)
                }

            }
        })
    }
    
    
    @IBAction func singInTapped(_ sender: Any) {
        if let email = emailField.text, let pwd = pwdField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil {
                    print("########FireBase Authenticated#######")
                    print("Dileep: Email User authenticated with Firebase ")
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            print("########FireBase Failed to Create Email #######")
                            print("Dileep: Unable to authenticate with Firebase using Email")
                        } else {
                            print("########FireBase Created User and Authenticated#######")
                            print("Dileep: Successfully authenticated with Firebase ")
                            let userData = ["provider": user?.providerID]
                            self.completeSignIn(uid: (user?.uid)!, userData: userData as! Dictionary<String, String>)
                        }
                    })
                }
            })
        }
        
        
    }
    
    
    
    func completeSignIn(uid: String, userData: Dictionary<String, String>) {
    //KeychainWrapper.setString(user?.uid, forKey: KEY_UID)
    
        //var accessibility: KeychainItemAccessibility? = nil
       // KeychainWrapper.set(id, forKey: KEY_UID, accessibility)
        
        DataService.ds.createFirebaseDBUser(uid: uid, userData: userData)
        let keychainResult = KeychainWrapper.standard.set(uid, forKey: KEY_UID)
        print("########Keychain Saved Data#######")
        print("Dileep: Data saved to keychain: \(keychainResult)")
        performSegue(withIdentifier: "goToFeed", sender: nil)
    
    }
    

}

