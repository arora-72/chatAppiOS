//
//  contactsViewController.swift
//  chat app firebase
//
//  Created by arora_72 on 10/06/17.
//  Copyright © 2017 indresh arora. All rights reserved.
//

import UIKit

class contactsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func logOut(_ sender: Any) {
        
        if AuthProvider.Instance.logOut(){
            dismiss(animated: true, completion: nil)

        }
        
    }

}
