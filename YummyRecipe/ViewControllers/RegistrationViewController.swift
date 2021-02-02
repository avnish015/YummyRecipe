//
//  RegistrationViewController.swift
//  YummyRecipe
//
//  Created by Avnish on 30/01/21.
//

import UIKit
import FirebaseAuth

class RegistrationViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var emailIdTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var reenterPasswordTextField: UITextField!
    @IBOutlet weak var nickNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addButtonToImageView()
    }
    
    func addButtonToImageView(){
        let button = UIButton()
        button.isUserInteractionEnabled = true
        profileImageView.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.addSubview(button)
        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: profileImageView.trailingAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor).isActive = true
        button.addTarget(self, action: #selector(addProfileImageButtonTapped(sender:)), for: .touchUpInside)
        button.setTitle("Add", for: .normal)
        button.backgroundColor = .systemGray
    }
    
    @objc func addProfileImageButtonTapped(sender:UIButton) {
        print("Add Image")
    }
    
    @IBAction func signupButtonTapped(_ sender:UIButton) {
        if let emailID = emailIdTextField.text, let password = passwordTextField.text, let reenterPassword = reenterPasswordTextField.text, let nickName = nickNameTextField.text {
            if !emailID.isEmpty && !password.isEmpty && !reenterPassword.isEmpty && !nickName.isEmpty {
                if password == reenterPassword {
                    Auth.auth().createUser(withEmail: emailID, password: password) { (result, error) in
                        if let error = error {
                            Utility.sharedInstance.showAlert(vc: self, messageText: error.localizedDescription, titleText: "Error")
                        }else {
                            let alertController = UIAlertController(title: "Successful",message: "User Registered Successfully", preferredStyle:.alert)
                            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
                                self.navigationController?.popViewController(animated: true)
                            }))
                            self.present(alertController, animated: true, completion: nil)
                        }
                    }
                }else {
                    Utility.sharedInstance.showAlert(vc: self, messageText: "Password is not matching, Please reenter your password & try again", titleText: "Error")
                }

            }else {
                Utility.sharedInstance.showAlert(vc: self, messageText: "Please enter all the details", titleText: "Error")
            }
        }else {
            Utility.sharedInstance.showAlert(vc: self, messageText:"Please enter all the details", titleText: "Error")
        }
    }
}
