//
//  SomeModel.swift
//  MyMaps
//
//  Created by Дмитрий Емельянов on 17.11.2021.
//

import Foundation
import Alamofire

class User {
    var id = ""
    var name = ""
    var description = ""
    var age = ""
    
    static func get(completion: @escaping (User) -> Void) {
        let req = Request(endpoint: .getUser, method: .get)
        HTTPManager.shared.request(req) {
            
        }
    }
}
