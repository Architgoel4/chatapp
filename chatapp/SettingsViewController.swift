//
//  SettingsViewController.swift
//  chatapp
//
//  Created by Goel, Archit on 18/07/18.
//  Copyright © 2018 Goel, Archit. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var uploadPhotoBtn: UIButton!
    
    var selectedUser: ChatUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userNameLbl.text = selectedUser?.username
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func getPhoto(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(image, animated: true, completion: nil)
    }
    
    @IBAction func uploadPhoto(_ sender: Any) {
        uploadImage()
    }
    
    func uploadImage(){
        selectedUser?.uploadProfileImage(profileImage: imageView.image!)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let pickerInfo: Dictionary = info as Dictionary
        let img: UIImage = pickerInfo[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = img
        self.dismiss(animated: true, completion: nil)
    }
}
