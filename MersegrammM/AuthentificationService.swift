//
//  AuthentificationService.swift
//  MersegrammM
//
//  Created by Boleslav Glavatki on 09.03.23.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class AuthentificationService {
    
    //Einloggen
    static func signIn(email: String, password: String, onSuccess: @escaping () -> Void, onError: @escaping (_ error: String?) -> Void){
        Auth.auth().signIn(withEmail: email, password: password){(data, error) in
            if let err = error{
                onError(err.localizedDescription)
                return
            }
            print(data?.user.email ?? "")
            onSuccess()//Der übergebene Closure wird beim erfolgreichen einloggen ausgeführt
        }
    }
    
    static func createUser(username: String, email: String, password: String, imageData: Data, onSuccess: @escaping () -> Void, onError: @escaping (_ error: String?) -> Void){
        Auth.auth().createUser(withEmail: email, password: password){ (data, error) in
            if let err = error {
                onError(err.localizedDescription)
            }
            //User erfolgreich erstellt
            guard let uid = data?.user.uid else{return}
            self.uploadUserData(uid: uid, username: username, email: email, imageData: imageData, onSuccess: onSuccess)
            
        }
    }
    
    
    static func uploadUserData(uid:String, username:String, email:String, imageData: Data, onSuccess: @escaping () -> Void){
        
        let storageRef = Storage.storage().reference().child("profil_image").child(uid)
        
        storageRef.putData(imageData, metadata: nil){(metadata, error) in
            if error != nil{
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
                
                ref.setValue(["username" : username, "email" : email, "profilImageUrl": profilImageUrlString ?? "Kein Bild vorhanden"])
            })
            onSuccess()
        }
    }
    
    
    
    
    
    
}

