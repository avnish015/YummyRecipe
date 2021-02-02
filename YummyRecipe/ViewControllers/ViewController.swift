//
//  ViewController.swift
//  YummyRecipe
//
//  Created by Avnish on 28/01/21.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class ViewController: UIViewController {
    
    @IBOutlet weak var emailIdTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    var handle:AuthStateDidChangeListenerHandle?
//    var credential:AuthCredential?


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    override func viewWillDisappear(_ animated: Bool) {

    }
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        if let emailId = emailIdTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: emailId, password: password) { (result, error) in
                if let error = error {
                    Utility.sharedInstance.showAlert(vc: self, messageText: error.localizedDescription, titleText: "Error")
                }
            }
        }
    }
    
    @IBAction func signupButtontapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "SignupViewController", sender: self)
    }
    
}

extension ViewController:GIDSignInDelegate {
    // MARK:- Google SignIn
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("Error:// \(error.localizedDescription)")
        }
        guard let authenticator = user.authentication else {
            return
        }
        let credential = GoogleAuthProvider.credential(withIDToken: authenticator.idToken, accessToken: authenticator.accessToken)
        Auth.auth().signIn(with:credential) { (result, error) in
            print(user.profile.name)
        }
    }
}

