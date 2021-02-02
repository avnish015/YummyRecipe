//
//  Utlity.swift
//  YummyRecipe
//
//  Created by Avnish on 29/01/21.
//

import UIKit

class Utility {
    static let sharedInstance:Utility = Utility()
    private init() {}
    
    func showAlert(vc:UIViewController, messageText:String, titleText:String) {
        let alert = UIAlertController(title: titleText, message: messageText, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(action)
        vc.present(alert, animated: true, completion: nil)
    }
}

@IBDesignable extension UIView {
    @IBInspectable var cornerRadius:CGFloat {
        set {
            layer.masksToBounds = true
            self.layer.cornerRadius = newValue
        }
        get {
            return self.layer.cornerRadius
        }
    }
    
    @IBInspectable var boarderColor:UIColor {
        set {
            layer.masksToBounds = true
            layer.borderWidth = 1
            layer.borderColor = newValue.cgColor
        }
        get {
            return self.boarderColor
        }
    }
}
