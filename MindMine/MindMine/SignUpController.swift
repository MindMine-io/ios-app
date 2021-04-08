//
//  SignUpController.swift
//  MindMine
//
//  Created by Hugo on 07/04/2021.
//

import Foundation
import Firebase


class SignUpController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBAction func didPressSignUp(_ sender: UIButton) {
        
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        createUser(withEmail: email, password: password)
        
    }
    
    func createUser(withEmail email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            
            if let error = error {
                print("Could not sign up user: ", error.localizedDescription)
                return
            }
            
            guard let uid = result?.user.uid else {
                return
            }
            
            print(uid)
            
        }
    }
    
    
}
