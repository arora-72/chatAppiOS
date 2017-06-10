//
//  signedInViewController.swift
//  chat app firebase
//
//  Created by arora_72 on 10/06/17.
//  Copyright © 2017 indresh arora. All rights reserved.
//

import UIKit

import FirebaseAuth

class signedInViewController: UIViewController {
    
    let CONTACT_SEGUE = "contactsSegue"
    
    
    
    @IBOutlet weak var passwordTextField: UITextField!

    @IBOutlet weak var emailTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func logIn(_ sender: Any) {
        
                performSegue(withIdentifier: CONTACT_SEGUE, sender: nil)
        
        if emailTextField.text != "" && passwordTextField.text != ""{
            
            AuthProvider.Instance.logIn(email: emailTextField.text!, password: passwordTextField.text!, loginHandler: {(message) in
            
                if message != nil{
                    self.alertTheUser(title: "problem with authentication", message: message!)
                }else{
                    print("login completed!")
                }
                
                
            })
        }else{
            alertTheUser(title: "email and password are required", message: "please enter password and email in text field")
        }
    }

    @IBAction func signUp(_ sender: Any) {
        
        if emailTextField.text != "" && passwordTextField.text != ""{
        
            
            AuthProvider.Instance.signUp(email: emailTextField.text!, password: passwordTextField.text!, loginHandler: { (message) in
                
                if message != nil{
                    
                     self.alertTheUser(title: "problem with creating the new user", message: message!)
                    
                }else{
                    self.emailTextField.text = ""
                    self.passwordTextField.text = ""
                    self.performSegue(withIdentifier: self.CONTACT_SEGUE, sender: nil)
                }
            })
           
        
        }else{
            alertTheUser(title: "email and password are required", message: "please enter password and email in text field")
        }
    }

        
    


    
    
    
        private func alertTheUser(title: String, message: String){
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
}//class

