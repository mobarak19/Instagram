
import FirebaseDatabase
import FirebaseAuth
public class AuthManager{
    
    static let shared = AuthManager()
    
    func registerUser(userName:String,email:String,password:String,comletion:@escaping (Bool)->Void){
        print(userName,email,password)
        DatabaseManager.shared.canCreateUser(with: email, username: userName) { canCreate in
            print(canCreate)
            if canCreate{
                
                Auth.auth().createUser(withEmail: email, password: password){ result,error in
                    
                    guard  error == nil,result != nil else {
                        comletion(false)
                        return
                    }
                    
                    DatabaseManager.shared.insertNewUser(with: email, userName: userName) { inserted in
                        if inserted {
                            comletion(true)
                        }else{
                            comletion(false)
                        }
                        return
                    }

                }
            }else{
                comletion(false)
            
            }
        }
        
    }
    
    func userLogin(userName:String?,email:String?,password:String,completion:@escaping (Bool)->Void){
        if let email = email {
            
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard  authResult != nil, error == nil else {
                    completion(false)
                    return
                }
                completion(true)
                
            }
        }else if let userName = userName {
            
        }
    }
    
    
    func logOut(completion:@escaping(Bool)->Void){
        do{
            try Auth.auth().signOut()
            completion(true)
            return
        }catch{
            print(error.localizedDescription)
            completion(false)
            return

        }
    }
}
