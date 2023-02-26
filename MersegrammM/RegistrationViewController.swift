//
//  RegistrationViewController.swift
//  MersegrammM
//
//  Created by Boleslav Glavatki on 22.02.23.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    /*        MARK: - Outlets      */
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var profilImage: UIImageView!
    
    @IBOutlet weak var accountErstellen: UIButton!
    
    @IBOutlet weak var haveAnAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        // Do any additional setup after loading the view.
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
    
    
    /*        MARK: - Action      */
    
    @IBAction func createButtonTaped(_ sender: UIButton) {
    }
    
    
    /*       MARK: - Navigation       */

    @IBAction func dismissButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
