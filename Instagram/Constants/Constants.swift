//
//  Constants.swift
//  Instagram
//
//  Created by Genusys Inc on 7/27/22.
//

import Foundation

//private func setInstantMessageFormat(type:String,data:String,mid:String)->String{
//
//    let extn = UserDefaults.standard.string(forKey: KEY_USER_EXTN)
//
//    guard let extn = extn else {
//        return ""
//    }
//
//    let jsonObj = MsgFromat(type: type, data: data, from: extn, mid: mid)
//
//    let encoder = JSONEncoder()
//
//    let data = try! encoder.encode(jsonObj)
//
//    let string = String(data: data, encoding: .utf8)!
//
//
//    let utf8str = string.data(using: .utf8)
//
//    if let base64Encoded = utf8str?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0)) {
//        print("Encoded: \(base64Encoded)")
//        return base64Encoded + "\n\r"
//
//    }
//
//    return "\n\r"
//}
