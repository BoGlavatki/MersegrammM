//
//  LoginViewController.swift
//  MersegrammM
//
//  Created by Boleslav Glavatki on 22.02.23.
//

import UIKit

class LoginViewController: UIViewController {
    /*      MARK: - Outlets    */
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passswordField: UITextField!
    
    
    @IBOutlet weak var loginButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addTargetToTextField()
        
        // Do any additional setup after loading the view.
    }
   
    /*  MARK: - Methoden   */
    func setupViews(){
     
      
        loginButton.backgroundColor = UIColor(white: 0.8, alpha: 0.2)
        
        loginButton.titleLabel?.font = UIFont(name: "Helvetica", size:12)
        loginButton.layer.cornerRadius = 5
        loginButton.isEnabled = false
    }
    
    func addTargetToTextField(){
        emailTextField.addTarget(self, action: #selector(textFielDidChanged), for: UIControl.Event.editingChanged)
        passswordField.addTarget(self, action: #selector(textFielDidChanged), for: UIControl.Event.editingChanged)
        
    }
    @objc func textFielDidChanged(){
        let isText = emailTextField.text?.count ?? 0 > 0 && passswordField.text?.count ?? 0 > 0  //hier wird geprüpft ob ein Text in Textfield eingegeben ist und anhand das loginButton auf true oder false eingesetz 
        
        if isText {
            loginButton.backgroundColor = UIColor(white: 1.0, alpha: 0.8)
            loginButton.layer.cornerRadius = 5
            loginButton.isEnabled = true
        }else{
            loginButton.backgroundColor = UIColor(white: 0.8, alpha: 0.2)
            loginButton.layer.cornerRadius = 5
            loginButton.isEnabled = false
        }
    }
    
    /*      MARK: - Actions    */
    
    
  @IBAction func loginButton(_ sender: UIButton) {
      print("login")
    }
    
    
  

}
