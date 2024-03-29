
import Foundation

enum UserPostType:String{
    case photo = "Photo"
    case video = "Video"
}

struct UserPost{
    let identifire:String

    let postType:UserPostType
    let thumbnilImage:URL
    let postURL:URL
    let caption:String?
    let lineCount:[PostLike]
    let comments:[PostComment]
    let createdDate:Date
    let taggedUsers:[User]
    let owner:User
    
}

struct PostLike{
    let username:String
    let identifire:String
}


struct PostComment{
    let identifire:String
    let username:String
    let text:String
    let creatdDate:Date
    let likes:[CommentLike]
}


struct CommentLike{
    let username:String
    let commentIdentifire:String
}
