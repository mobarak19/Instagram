
import Foundation
import FirebaseDatabase


class DatabaseManager{
    static let shared = DatabaseManager()
    private let database = Database.database().reference()
    func canCreateUser(with email:String,username:String,completion:@escaping (Bool)->Void){
        completion(true)
    }
    
    func insertNewUser(with email:String,userName:String,completion: @escaping(Bool)->Void){
        database.child(email.makeFirebaseDatabaseKey()).setValue(["username":userName]){ error, _ in
            if error == nil{
                completion(true)
            }else{
                completion(false)
            }
            return
            
        }
    }
    
}

