//
//  NotificationTVC.swift
//  Instagram
//
//  Created by Genusys Inc on 10/6/22.
//

import UIKit

enum UserNotificationType{
    case like(post:UserPost)
    case follow(state:FollowState)
}

struct UserNotification{
    let type:UserNotificationType
    let text:String
    let user:User
}

protocol NotificationFollowEventTVCDelegate:AnyObject{
    func didTapFollowUnfollowBtn(model:UserNotification)
}

class NotificationFollowEventTVC: UITableViewCell {

    static let identifire = "NotificationTVC"

    public weak var delegate:NotificationFollowEventTVCDelegate?
    
    private let profileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .tertiarySystemBackground

        return imageView
    }()
    
    private let label:UILabel = {
        let lbl = UILabel()
        lbl.textColor = .label
        lbl.numberOfLines = 0
        lbl.text = "@joe followd you"

        return lbl
    }()
    
    private let followBtn:UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 4
        btn.layer.masksToBounds = true
        return btn
    }()
    private var model:UserNotification?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(profileImageView)
        contentView.addSubview(followBtn)
        contentView.addSubview(label)
        followBtn.addTarget(self, action: #selector(onTappFollowBtn), for: .touchUpInside)
        followBtn.setTitle("Unfollow", for: .normal)
        followBtn.setTitleColor(.label, for: .normal)
        followBtn.layer.borderWidth = 1
        followBtn.layer.borderColor = UIColor.secondaryLabel.cgColor
        selectionStyle = .none
    }
    
    @objc func onTappFollowBtn(){
       
        guard let model = model else {
            return
        }
        
        delegate?.didTapFollowUnfollowBtn(model: model)
    }
    
    public func configure(with model:UserNotification){
        self.model = model
        self.label.text = model.text
        self.profileImageView.sd_setImage(with: model.user.profilePhoto)
        switch model.type{
        case .like(post: let post):
            break
        case .follow(state: let state):
            switch state {
            case .following:
                followBtn.setTitle("Unfollow", for: .normal)
                followBtn.setTitleColor(.label, for: .normal)
                followBtn.layer.borderWidth = 1
                followBtn.layer.borderColor = UIColor.secondaryLabel.cgColor
            case .not_following:
                followBtn.setTitle("Follow", for: .normal)
                followBtn.setTitleColor(.white, for: .normal)
                followBtn.backgroundColor = .link
                followBtn.layer.borderWidth = 0
            }
            
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        followBtn.backgroundColor = nil
        followBtn.setTitle(nil, for: .normal)
        followBtn.layer.borderWidth = 0
        label.text = nil
        profileImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        profileImageView.frame = CGRect(x: 3, y: 3, width: contentView.height - 6, height: contentView.height - 6)
        profileImageView.layer.cornerRadius = profileImageView.height/2.0
        let size = CGFloat(100)
        let buttonHeight = CGFloat(40)
        followBtn.frame = CGRect(x: contentView.width - size, y: (contentView.height - buttonHeight)/2, width: size, height: buttonHeight)
        label.frame = CGRect(x: profileImageView.right + 5, y: 0, width: contentView.width - size - profileImageView.width - 11, height: contentView.height - 6)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
