//
//  Extentions.swift
//  Aubuchon
//
//  Created by mac on 13/11/18.
//  Copyright © 2018 Differenz. All rights reserved.
//

import UIKit
//MARK:- Alert function
extension UIViewController {
    func alertMessage(message: String, title: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

//MARK:- string trim function
extension String {
    func trim() -> String
    {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
}

