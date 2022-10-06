//
//  User.swift
//  Instagram
//
//  Created by Genusys Inc on 8/1/22.
//

import Foundation

enum Gender{
    case male,female,other
}
struct User{
    let username:String
    let bio:String
    let name:(first:String,last:String)
    let birthDate:Date
    let gender:Gender
    let counts:UserCount
    let joindDate:Date
    let profilePhoto:URL
}

struct UserCount{
    let followers:Int
    let following:Int
    let posts:Int
}
