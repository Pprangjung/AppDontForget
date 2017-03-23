//
//  SignupViewController.swift
//  AppDontForget
//
//  Created by Prang on 1/10/2560 BE.
//  Copyright © 2560 Prang. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var userImageView: CustomableImageView!
    
    @IBOutlet weak var usernameTF: AkiraTextField!
    @IBOutlet weak var emailTF: AkiraTextField!
    
    @IBOutlet weak var passwordTF: AkiraTextField!
    
    
    var networkingService = NetworkService()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func choosePicture(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        
        let alertController = UIAlertController(title: "Add a Picture", message: "Choose From", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
            pickerController.sourceType = .camera
            self.present(pickerController, animated: true, completion: nil)
            
        }
        let photosLibraryAction = UIAlertAction(title: "Photos Library", style: .default) { (action) in
            pickerController.sourceType = .photoLibrary
            self.present(pickerController, animated: true, completion: nil)
            
        }
        
        let savedPhotosAction = UIAlertAction(title: "Saved Photos Album", style: .default) { (action) in
            pickerController.sourceType = .savedPhotosAlbum
            self.present(pickerController, animated: true, completion: nil)
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alertController.addAction(cameraAction)
        alertController.addAction(photosLibraryAction)
        alertController.addAction(savedPhotosAction)
        alertController.addAction(cancelAction)
        
        
        present(alertController, animated: true, completion: nil)
    }
    
    
   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    
        let pickedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        self.dismiss(animated: true, completion: nil)
        self.userImageView.image = pickedImage
        
    }
    
    
    

    
    @IBAction func singupAction(_ sender: Any) {
         let data = UIImageJPEGRepresentation(self.userImageView.image!, 0.8)
        
        networkingService.signUp (emailTF.text!, username: usernameTF.text!, password: passwordTF.text!, data: data!)
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Home")
        present(vc, animated: true, completion: nil)

        
        
    }
    
}
