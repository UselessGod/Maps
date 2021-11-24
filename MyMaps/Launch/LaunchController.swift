//
//  LaunchController.swift
//  MyMaps
//
//  Created by Дмитрий Емельянов on 14.11.2021.
//

import UIKit

class LaunchController: UIViewController {
    
    @IBOutlet weak var router: LaunchRouter!
    
    override func viewDidLoad() {
        if UserDefaults.standard.bool(forKey: "isLogin") {
            router.toMain()
        } else {
            router.toAuth()
        }
    }
}

class LaunchRouter: BaseRouter {
    func toMain(){
        perform(segue: "onMain")
    }
    
    func toAuth(){
        perform(segue: "onLogin")
    }
}


class RootSegue: UIStoryboardSegue {
    override func perform() {
        UIApplication.shared.windows.first?.rootViewController = destination
//        UIApplication.shared.keyWindow?.rootViewController = destination
    }
}
