//
//  MainController.swift
//  MyMaps
//
//  Created by Дмитрий Емельянов on 14.11.2021.
//

import UIKit

class MainController: UIViewController {
    
    
    private var image: UIImage!
    
    @IBOutlet weak var router: MainRouter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func showMap (_ sender: UIButton) {
        router.toMap()
    }
    
    @IBAction func logout (_ sender: UIButton) { 
        UserDefaults.standard.set(false, forKey: "isLogin")
    }
    
    @IBAction func takePhoto(_ sender: Any) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print ("No")
            return
        }
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    private func showPhotoController(with img: UIImage) {
        
        image = img
        performSegue(withIdentifier: "photo", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is PhotoController {
            let vc = segue.destination as! PhotoController
            vc.image = self.image
        }
    }
}

class MainRouter: BaseRouter {
    
    func toMap() {
        let vc = UIStoryboard(name: "Main", bundle: nil)
            .initViewContoller(ViewController.self)
        present(vc)
    }
    
}

extension MainController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = extractImage(info) else { picker.dismiss(animated: true); return }
        
        picker.dismiss(animated: true) {
            self.showPhotoController(with: image)
        }
    }
    
    private func extractImage(_ info: [UIImagePickerController.InfoKey: Any]) -> UIImage? {
        if let image = info[.editedImage] as? UIImage {
            return image
        } else if let image = info[.originalImage] as? UIImage{
            return image
        } else {
            return nil
        }
    }
}
