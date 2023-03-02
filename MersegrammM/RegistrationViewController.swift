//
//  RegistrationViewController.swift
//  MersegrammM
//
//  Created by Boleslav Glavatki on 22.02.23.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseDatabase
import FirebaseStorage



class RegistrationViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    /*        MARK: - Outlets      */
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var profilImage: UIImageView!
    
    @IBOutlet weak var accountErstellen: UIButton!
    
    @IBOutlet weak var haveAnAccountButton: UIButton!
    
    
    /*      MARK: var/let      */
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addTargetTotextField()
        addTapGestureToImageView()
    }
    
    
    /*        MARK: - Choose photo      */
    //Um PhotoView als Button zu benutzen
    func addTapGestureToImageView(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSelectProfilPhoto))
        profilImage.addGestureRecognizer(tapGesture)
        profilImage.isUserInteractionEnabled = true
    }
    @objc func handleSelectProfilPhoto(){
       let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        present(pickerController, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editImage = info[.editedImage] as? UIImage{
            profilImage.image = editImage
            selectedImage = editImage
        }else if let originalImage = info[.originalImage] as? UIImage{
            profilImage.image = originalImage
            selectedImage = originalImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    
    /*        MARK: - Methods      */
    
    
    func setupView(){
        profilImage.layer.cornerRadius = profilImage.frame.width / 2
        profilImage.layer.borderColor = UIColor.white.cgColor
        profilImage.layer.borderWidth = 2
        
        
        usernameTextField.backgroundColor = UIColor(white: 1.0, alpha: 0.8)
        usernameTextField.borderStyle = .roundedRect
        usernameTextField.attributedPlaceholder = NSAttributedString(string: usernameTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
        
        emailTextField.backgroundColor = UIColor(white: 1.0, alpha: 0.8)
        emailTextField.borderStyle = .roundedRect
        emailTextField.attributedPlaceholder = NSAttributedString(string: emailTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
        
        passwordTextField.backgroundColor = UIColor(white: 1.0, alpha: 0.8)
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.attributedPlaceholder = NSAttributedString(string: passwordTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
        accountErstellen.backgroundColor = UIColor(white: 0.8, alpha: 0.2)
        accountErstellen.layer.cornerRadius = 5
        accountErstellen.isEnabled = false
        
        //Die Login Wort bisschen dicke und andere Farbe
        let attributedText = NSMutableAttributedString(string: "Du hast einen Account?", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17), NSAttributedString.Key.foregroundColor : UIColor.systemTeal])
        attributedText.append(NSMutableAttributedString(string: " " + "Login", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 24), NSAttributedString.Key.foregroundColor : UIColor.systemPink]))
        
        haveAnAccountButton.setAttributedTitle(attributedText, for: .normal)
        
    }
    func addTargetTotextField(){
        usernameTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
                                 passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
    }
    @objc func textFieldDidChange(){
        let isText = usernameTextField.text?.count ?? 0 > 0 &&
        emailTextField.text?.count ?? 0 > 0 &&
        passwordTextField.text?.count ?? 0 > 0
        
        if isText{
            accountErstellen.backgroundColor = UIColor(white: 1.0, alpha: 0.8)
            accountErstellen.layer.cornerRadius = 5
            accountErstellen.isEnabled = true
        } else
        {
            accountErstellen.backgroundColor = UIColor(white: 0.8, alpha: 0.2)
            accountErstellen.layer.cornerRadius = 5
            accountErstellen.isEnabled = false
        }
    }
    
    
    
    /*        MARK: - Action      */
    
    @IBAction func createButtonTaped(_ sender: UIButton) {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!)
        { (user, error) in
            if let err = error{
                print(err.localizedDescription)
                return
            }
            print("USER MIT DEM EMAIL", user?.user.email ?? "")
            //User informationen in Datenbank eingeben
            guard let newUser = user?.user else { return }
            let uid = newUser.uid
            
            self.uploadUserData(uid: uid, username: self.usernameTextField.text!, email: self.emailTextField.text!)
        }
        
    }
    func uploadUserData(uid:String, username:String, email:String){
        
        let storageRef = Storage.storage().reference().child("profil_image").child(uid)
        guard let image = selectedImage else {
            return
        }
        guard let uploadData = image.jpegData(compressionQuality: 0.1) else{return }
        
        storageRef.putData(uploadData, metadata: nil){(metadata, error) in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            storageRef.downloadURL(completion: {(url, error)in
                if error != nil {
                    print(error?.localizedDescription)
                    return
                }
                let profilImageUrlString = url?.absoluteString
                print(profilImageUrlString!)
                let ref =  Database.database(url:"https://mersegrammm-default-rtdb.europe-west1.firebasedatabase.app/").reference().child("users").child(uid)
                print("Datenbank Adresse: ", ref)
                
                ref.setValue(["username" : self.usernameTextField.text!, "email" : self.emailTextField.text!, "profilImageUrl": profilImageUrlString ?? "Kein Bild vorhanden"])
            })
        }
    }
    
    
    
    
    /*       MARK: - Navigation       */

    @IBAction func dismissButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
