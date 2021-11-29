//
//  PhotoController.swift
//  MyMaps
//
//  Created by Дмитрий Емельянов on 29.11.2021.
//

import Foundation
import UIKit

class PhotoController: UIViewController {
    
    @IBOutlet weak var imgVIew: UIImageView?
    
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgVIew?.image = image
        
    }
}
