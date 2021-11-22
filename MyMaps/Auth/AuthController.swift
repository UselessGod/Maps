//
//  AuthController.swift
//  MyMaps
//
//  Created by Дмитрий Емельянов on 14.11.2021.
//

import UIKit
import RxCocoa
import RxSwift

class AuthController: UIViewController {
    
    enum Constants {
        static let login = "admin"
        static let password = "123456"
    }
    
    @IBOutlet weak var router: LoginRouter!
    @IBOutlet weak var loginView: UITextField!
    @IBOutlet weak var passwordView: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLoginBinding()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @IBAction func login (_ sender: UIButton) {
        guard let login = loginView.text,
              let password = passwordView.text,
              login == Constants.login && password == Constants.password else { return }
        
        loginView.autocorrectionType = .no
        passwordView.autocorrectionType = .no
        
        router.toMain()
        UserDefaults.standard.set(true, forKey: "isLogin")
    }
    
    @IBAction func recovery (_ sender: UIButton) {
        router.onReset()
    }
    
    private func configureLoginBinding() {
        Observable
            .combineLatest(loginView.rx.text, passwordView.rx.text)
            .map { login, pass in
                return !(login ?? "").isEmpty && (pass ?? "").count >= 6
            }
            .bind { [weak loginButton] inputFilled in
                loginButton?.isEnabled = inputFilled
            }
    }
    
}

class LoginRouter: BaseRouter {
    
    func toMain() {
        let controller = UIStoryboard(name: "Main", bundle: nil)
            .initViewContoller(MainController.self)
        setAsRoot(controller)
    }
    
    func onReset() {
        let controller = UIStoryboard(name: "Auth", bundle: nil)
            .initViewContoller(ResetPassController.self)
        show(controller)
    }
}
