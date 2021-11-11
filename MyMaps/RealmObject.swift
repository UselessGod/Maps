//
//  RealmObject.swift
//  MyMaps
//
//  Created by Дмитрий Емельянов on 11.11.2021.
//

import Foundation
import GoogleMaps
import RealmSwift

class RealmObject: Object {
    
    static let mapRealm = try! Realm()
    
    
    func save() {
        try! realm?.add(self)
    }
    
    func remove() {
        try! realm?.delete(self)
    }
}

class Track: RealmObject {
    
    let mapRealm: Realm! = try! Realm()
    
    @objc dynamic var trackRoute: GMSPolyline? 
    @objc dynamic var trackRoutePath: GMSMutablePath? = nil
}
