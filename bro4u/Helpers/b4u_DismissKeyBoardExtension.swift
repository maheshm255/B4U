//
//  b4u_DismissKeyBoardExtension.swift
//  bro4u
//
//  Created by MACBookPro on 4/7/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

import Foundation


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
//        view.endEditing(true)
        
    }
}
