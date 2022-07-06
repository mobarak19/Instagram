
import UIKit

class RegistrationVC: UIViewController {
    private var userNameTF : UITextField = {
        let field = UITextField()
        field.returnKeyType = .next
        field.placeholder = "Username..."
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
    private var emailTF : UITextField = {
        let field = UITextField()
        field.returnKeyType = .next
        field.placeholder = "Email..."
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
    
    private var registerBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("Sign Up", for: .normal)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = Constants.cornerRadius
        btn.backgroundColor = .systemGreen
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubViews()
        view.backgroundColor = .systemBackground
        registerBtn.addTarget(self, action: #selector(didTappedRegisterUserBtn), for: .touchUpInside)
        
    }
    
    func addSubViews(){
        
        view.addSubview(userNameTF)
        view.addSubview(emailTF)
        view.addSubview(passwordTF)
        view.addSubview(registerBtn)
        
        userNameTF.delegate = self
        emailTF.delegate = self
        passwordTF.delegate = self

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        userNameTF.frame = CGRect(x: 20, y: view.safeAreaInsets.top + 40, width: view.width - 40, height: 52)
        
        emailTF.frame = CGRect(x: 20, y:userNameTF.bottom + 10, width: view.width - 40, height: 52)
        
        passwordTF.frame = CGRect(x: 20, y: emailTF.bottom + 10, width: view.width - 40, height: 52)
        
        registerBtn.frame = CGRect(x: 20, y: passwordTF.bottom + 10, width: view.width - 40, height: 52)
        
    }
    
    @objc func didTappedRegisterUserBtn(){

        userNameTF.resignFirstResponder()
        emailTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
        
        guard let email = emailTF.text,!email.isEmpty,
              let  password = passwordTF.text,!password.isEmpty, password.count >= 8,
              let username = userNameTF.text, !username.isEmpty else {return}
        
        AuthManager.shared.registerUser(userName: username, email: email, password: password) { success in
            DispatchQueue.main.async {
                if success{
                    self.dismiss(animated: true)

                    print("success")
                    
                }else{
                    print("Error occured")
                    let alert = UIAlertController(title: "Error in signup", message: "We were unable to sign you up", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                }
            }
      
        }

    }

}


extension RegistrationVC:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTF{
            emailTF.becomeFirstResponder()
        }else if textField == emailTF{
            passwordTF.becomeFirstResponder()
        }else if textField == passwordTF{
            didTappedRegisterUserBtn()
            
        }
        return true
    }
}
