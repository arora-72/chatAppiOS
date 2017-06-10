//
//  AuthProvider.swift
//  chat app firebase
//
//  Created by arora_72 on 10/06/17.
//  Copyright © 2017 indresh arora. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase


typealias loginHandler = (_ msg: String?) -> Void;

struct loginErrorCode {
    
    
    static let INVALID_EMAIL = "invalid email address, please provide a valid email address"
    static let WRONG_PASSWORD = "Wrong password, please enter the correct password"
    static let PROBLEM_CONNECTING = "problem connecting to the firebase database"
    static let USER_NOT_FOUND = "User not found, please register"
    static let EMAIL_ALREADY_IN_USE = "email already in use, please use another email"
    static let WEAK_PASSWORD = "password should be at least 6 strings long"
    
}


class AuthProvider{
    
    private static let _instance = AuthProvider()
    
    static var Instance: AuthProvider{
        return _instance;
    }
    
    func logIn(email: String, password: String,loginHandler: loginHandler?) {
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user,error) in
            
            
            if error != nil{
                
                self.handleError(err:  error! as NSError, loginHandler: loginHandler)
                
            }else{
                loginHandler!(nil)
            }
        
    })
        
    }//logic function
    
    
    func signUp(email: String, password: String, loginHandler: loginHandler?){
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user,error) in
            
            if error != nil{
               self.handleError(err: error! as NSError, loginHandler: loginHandler)
            }else{
                
                if user?.uid != nil{
                    
                    //store the user to database
                    
                    dbProvider.Instance.saveUser(withID: user!.uid, email: email, password: password)
                    
                    //login the user
                    self.logIn(email: email, password: password, loginHandler: loginHandler)
                    
                }
            }
        })
    }//logic function

    
    
    func logOut() -> Bool {
        if FIRAuth.auth()?.currentUser != nil{
            do{
                try FIRAuth.auth()?.signOut()
                return true
            }catch{
                return false
            }
        }
        return true
    }//logic function
    
    func userID() -> String {
        return (FIRAuth.auth()?.currentUser!.uid)!
    }
    
    
    
    private func handleError(err: NSError, loginHandler: loginHandler?){
        
        
        if let errCode = FIRAuthErrorCode(rawValue: err.code){
            
            switch errCode {
            case .errorCodeWrongPassword :
                loginHandler!(loginErrorCode.WRONG_PASSWORD)
                break;
            case .errorCodeInvalidEmail :
                loginHandler!(loginErrorCode.INVALID_EMAIL)
                break;
            case .errorCodeUserNotFound :
                loginHandler!(loginErrorCode.USER_NOT_FOUND)
                break;
            case .errorCodeEmailAlreadyInUse :
                loginHandler!(loginErrorCode.EMAIL_ALREADY_IN_USE)
                break;
            case .errorCodeWeakPassword :
                loginHandler!(loginErrorCode.WEAK_PASSWORD)
                break;
            default:
                loginHandler!(loginErrorCode.PROBLEM_CONNECTING)
                break;
            }
            
        }
    }
    
    
}//class
