//
//  SignupViewController.swift
//  AppDontForget
//
//  Created by Prang on 12/18/2559 BE.
//  Copyright © 2559 Prang. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController{
    
    
    @IBOutlet weak var ProfileImg: UIImageView!
    
    @IBOutlet weak var UsernamTF: AkiraTextField!
    
    @IBOutlet weak var EmailTF: AkiraTextField!
    
    @IBOutlet weak var PasswordTF: AkiraTextField!
    
    
    let imagePicker = UIImagePickerController()
    var selectedPhoto: UIImage!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

      let tap = UITapGestureRecognizer(target: self, action: #selector(SignupViewController.selectPhoto(tap:)))
        tap.numberOfTapsRequired=1
        ProfileImg.addGestureRecognizer(tap)
        ProfileImg.isUserInteractionEnabled=true
        ProfileImg.layer.cornerRadius=ProfileImg.frame.size.height/2
        ProfileImg.clipsToBounds=true
    }
    
    func selectPhoto(tap:UITapGestureRecognizer) {
        self.imagePicker.delegate=self
        self.imagePicker.allowsEditing=true
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            self.imagePicker.sourceType = .camera
        }else{
            self.imagePicker.sourceType = .photoLibrary
        }
        //self.navigationController?.pushViewController(self.imagePicker, animated: true)อ่าอันนี้มันผิด
        self.present(self.imagePicker, animated: true, completion: nil)
    }
   
  
    
    @IBAction func CancelDidT(_ sender: Any) {
        dismiss(animated: true,completion: nil)
        
        
        
    }
    
    @IBAction func SignupDidT(_ sender: Any) {
        guard let email=EmailTF.text, !email.isEmpty else {
            print("Email is empty")
            return
        }
        
        guard let password = PasswordTF.text, !password.isEmpty 
            else {
                print("Password is empty")
                return
        }
        guard let username=UsernamTF.text,!username.isEmpty
        else {
            print("Username is empty")
            return
        }
        
        
        
        
        var data = NSData()
            data = UIImageJPEGRepresentation(self.ProfileImg.image!,0.1)! as NSData
        ProgressHUD.show("Please wait...",interaction:true)
        Datasevice.datasevice.SignUp(username: username,email: email, password: password, data:data)
        
       }
    }
    
    
    
    var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent //แถบบาร์สีขาว
    }


   

extension SignupViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    //ImagePicker
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        selectedPhoto = (info[UIImagePickerControllerEditedImage] as? UIImage)!
        self.ProfileImg.image = selectedPhoto
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}
    


