//
//  LoginVC.swift
//  Instagram
//
//  Created by Genusys Inc on 7/5/22.
//

import UIKit
import SafariServices
struct Constants{
    static let cornerRadius = 8.0
}
class LoginVC: UIViewController {

    private var userNameEmailTF : UITextField = {
        let field = UITextField()
        field.returnKeyType = .next
        field.placeholder = "Username of Email..."
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.layer.masksToBounds = true
        field.layer.cornerRadius  = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private var passwordTF : UITextField = {
        let field = UITextField()
        field.returnKeyType = .continue
        field.placeholder = "Password..."
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.layer.masksToBounds = true
        field.isSecureTextEntry = true
        field.layer.cornerRadius  = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private var termsBtn : UIButton = {
        let btn = UIButton()
 
        btn.setTitle("Terms of services", for: .normal)
        btn.setTitleColor(.secondaryLabel, for: .normal)
        return btn
    }()
    
    private var loginBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("Log In", for: .normal)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = Constants.cornerRadius
        btn.backgroundColor = .systemBlue
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    
    private var privacyBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("Privacy policy", for: .normal)
        btn.setTitleColor(.secondaryLabel, for: .normal)
        return btn
    }()
    private var createAccountBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("New User? Create an Account", for: .normal)
        btn.layer.masksToBounds = true
        btn.setTitleColor(.black, for: .normal)
        return btn
    }()
    private var headerView : UIView = {
        let header = UIView()
        header.clipsToBounds = true
        let imageView = UIImageView(image: UIImage(named: "gradient"))
        header.addSubview(imageView)
        return header
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubViews()
        
        loginBtn.addTarget(self, action: #selector(didTappedLoginBtn), for: .touchUpInside)
        createAccountBtn.addTarget(self, action: #selector(didTappedCreateAccountBtn), for: .touchUpInside)

        termsBtn.addTarget(self, action: #selector(didTappedtermsBtn), for: .touchUpInside)

        privacyBtn.addTarget(self, action: #selector(didTappedPrivacyBtn), for: .touchUpInside)

        
        userNameEmailTF.delegate = self
        passwordTF.delegate = self

    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        headerView.frame = CGRect(x: 0, y: view.top, width: view.width, height: view.height/3.0)
        userNameEmailTF.frame = CGRect(x: 25, y: headerView.bottom + 40, width: view.width - 50, height: 52.0)
        passwordTF.frame = CGRect(x: 25, y: userNameEmailTF.bottom + 10, width: view.width - 50, height: 52.0)
        
        loginBtn.frame = CGRect(x: 25, y: passwordTF.bottom + 10, width: view.width - 50, height: 52.0)
        createAccountBtn.frame = CGRect(x: 25, y: loginBtn.bottom + 10, width: view.width - 50, height: 52.0)
        
        termsBtn.frame = CGRect(x: 10, y: view.height-view.safeAreaInsets.bottom - 100, width: view.width - 20, height: 50)
        
        privacyBtn.frame = CGRect(x: 10, y: view.height-view.safeAreaInsets.bottom - 50, width: view.width - 20, height: 50)
        
        configureHeaderView()

    }
    
    func configureHeaderView(){
        guard headerView.subviews.count == 1 else {return}
        guard let backgroudnView =  headerView.subviews.first else{return}
        backgroudnView.frame = headerView.bounds
        
        let imageView = UIImageView(image: UIImage(named: "instagram"))
        headerView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: headerView.width/4, y: view.safeAreaInsets.top, width: headerView.width/2, height: headerView.height - view.safeAreaInsets.top)
    }
    
    private func addSubViews(){
        
        view.addSubview(userNameEmailTF)
        view.addSubview(passwordTF)
        view.addSubview(loginBtn)
        view.addSubview(termsBtn)
        view.addSubview(privacyBtn)
        view.addSubview(createAccountBtn)
        view.addSubview(headerView)
        
    }
    
    @objc private func didTappedLoginBtn(){
        print("didTappedLoginBtn")
        
        passwordTF.resignFirstResponder()
        userNameEmailTF.resignFirstResponder()
        
        guard let usernameEmail = userNameEmailTF.text, !usernameEmail.isEmpty,
              let password = passwordTF.text,!password.isEmpty,password.count>=8 else {return}
        
        //login functionality
        
        var userName:String?
        var email:String?
        if  usernameEmail.contains("@"),usernameEmail.contains(".") {
            email = usernameEmail
        }else{
            userName = usernameEmail
        }
        
        AuthManager.shared.userLogin(userName: userName, email: email, password: password) { isSuccess in
            
            DispatchQueue.main.async {
                if isSuccess{
                    self.dismiss(animated: true)
                }else{
                    
                    let alert = UIAlertController(title: "Log In Error", message: "We were unable to log you in", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                }
            }
     
        }
        
    }
    @objc private func didTappedtermsBtn(){
        guard let url = URL(string: "https://help.instagram.com/581066165581870") else{return}
        let vc = SFSafariViewController(url: url)
        self.present(vc, animated: true)
    }
    @objc private func didTappedPrivacyBtn(){
        guard let url = URL(string: "https://help.instagram.com/519522125107875/?helpref=hc_fnav") else{return}
        let vc = SFSafariViewController(url: url)
        self.present(vc, animated: true)
    }
    @objc private func didTappedCreateAccountBtn(){
        
        let vc = RegistrationVC()
        vc.title = "Create Account"
        
        let root = UINavigationController(rootViewController: vc)
        
       // root.modalPresentationStyle = .fullScreen
        
        self.present(root, animated: true)
        
    }
}

extension LoginVC:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameEmailTF{
            passwordTF.becomeFirstResponder()
        }else if textField == passwordTF{
            
            didTappedLoginBtn()
        }
        return true
    }
}
