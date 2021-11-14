//
//  ResetPassController.swift
//  MyMaps
//
//  Created by Дмитрий Емельянов on 14.11.2021.
//

import UIKit

class ResetPassController: UIViewController {
    
    @IBOutlet weak var loginView: UITextField!
    
    @IBAction func recovery (_ sender: UIButton) {
        guard let login = loginView.text,
              login == AuthController.Constants.login else {
                return
        }
        showPassword()
    }
    
    private func showPassword() {
        let alert = UIAlertController(title: "Password", message: "123456", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(ok)
        present(alert, animated: true)
    }
}
