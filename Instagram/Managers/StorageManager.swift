//
//  StorageManager.swift
//  Instagram
//
//  Created by Genusys Inc on 7/5/22.
//

import FirebaseStorage

class StorageManager{
    static let shared = StorageManager()
    private let bucket = Storage.storage().reference()
    
    func uploadUserPost(model:UserPost,completion: @escaping(Result<URL,Error>) -> Void){
        
        
    }
    
    func downloadImage(with reference:String,completion : @escaping (Result<URL,IGStorageManagerError>)->Void){
        bucket.child(reference).downloadURL(completion: { url, error in
            guard let url = url, error == nil else{
                completion(.failure(.failToDownload))
                return
            }
            completion(.success(url))
        })
    }
}

