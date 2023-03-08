//
//  HomeViewController.swift
//  MersegrammM
//
//  Created by Boleslav Glavatki on 02.03.23.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Outlets
    @IBOutlet weak var LogOutButton: UIBarButtonItem!
    
    
    
    
    
    /*
    // MARK: - Navigation
    }
    */
    
    
    // MARK: - Action
    
    @IBAction func LogOutButtonTaped(_ sender: UIBarButtonItem) {
        do{ try Auth.auth().signOut()
        
        }catch let logoutError {
            print(logoutError.localizedDescription)
        }
        
        let storyboard = UIStoryboard(name: "Start", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "loginVC")
        present(loginVC, animated: true)
    }
    
}
