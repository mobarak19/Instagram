//
//  HomeVC.swift
//  Instagram
//
//  Created by Genusys Inc on 7/5/22.
//

import UIKit
import FirebaseAuth
class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleLoginStatus()
    


    }

    
    func handleLoginStatus(){
        if Auth.auth().currentUser == nil{
            let vc = LoginVC()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false)
        }
    }
}
