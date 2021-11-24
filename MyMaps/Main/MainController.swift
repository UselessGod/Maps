//
//  MainController.swift
//  MyMaps
//
//  Created by Дмитрий Емельянов on 14.11.2021.
//

import UIKit

class MainController: UIViewController {
    
    @IBOutlet weak var router: MainRouter!
    
    @IBAction func showMap (_ sender: UIButton) {
        router.toMap()
    }
    
    @IBAction func logout (_ sender: UIButton) { 
        UserDefaults.standard.set(false, forKey: "isLogin")
    }
}

class MainRouter: BaseRouter {
    
    func toMap() {
        let vc = UIStoryboard(name: "Main", bundle: nil)
            .initViewContoller(ViewController.self)
        present(vc)
    }
    
}
