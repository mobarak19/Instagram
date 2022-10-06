
//
//  UserFollowTVC.swift
//  Instagram
//
//  Created by Genusys Inc on 10/6/22.
//

import UIKit

protocol UserFollowTVCDelegate:AnyObject{
    func didTapUnfollowBtn(_ model:UserRelationship)
}

enum FollowState{
    case following,not_following
}

struct UserRelationship{
    let username:String
    let name:String
    let type:FollowState
}

class UserFollowTVC: UITableViewCell {

    static let identifire = "UserFollowTVC"
    
    public weak var delegate: UserFollowTVCDelegate?
    
    private let profileImage:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        return imageView
    }()
    
    private let nameLbl : UILabel = {
        let lbl = UILabel ()
        lbl.numberOfLines = 1
        lbl.font = .systemFont(ofSize: 17, weight: .regular)
        return lbl
    }()
    
    private let usernameLbl : UILabel = {
        let lbl = UILabel ()
        lbl.numberOfLines = 1
        lbl.font = .systemFont(ofSize: 17, weight: .regular)
        lbl.textColor = .secondaryLabel
        return lbl
    }()
    
    private let followBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("Follow", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        btn.backgroundColor = .link
        return btn
    }()
    private var model : UserRelationship?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(nameLbl)
        contentView.addSubview(usernameLbl)
        contentView.addSubview(profileImage)
        contentView.addSubview(followBtn)
        selectionStyle = .none
        followBtn.addTarget(self, action: #selector(didTapFollowBtn), for: .touchUpInside)
    }
    
    @objc func didTapFollowBtn(){
        delegate?.didTapUnfollowBtn(model!)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        profileImage.frame = CGRect(x: 3, y: 3, width: contentView.height - 6, height: contentView.height - 6)
        profileImage.layer.cornerRadius = profileImage.height/2.0
        
        let buttonWidth = contentView.width > 500 ? 220.0 : contentView.width/3
        
        followBtn.frame = CGRect(x: contentView.width - 5 - buttonWidth, y: (contentView.height - 40)/2, width: buttonWidth, height:40)
        
        
        let labelHeight = contentView.height/2
        nameLbl.frame = CGRect(x: profileImage.right + 5, y: 0, width: contentView.width - 8 - profileImage.width - buttonWidth, height: labelHeight)
        
        usernameLbl.frame = CGRect(x: profileImage.right + 5, y: nameLbl.bottom, width:  contentView.width - 8 - profileImage.width  - buttonWidth, height: labelHeight)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImage.image = nil
        nameLbl.text = nil
        usernameLbl.text = nil
        followBtn.setTitle(nil, for: .normal)
        followBtn.layer.borderWidth = 0
        followBtn.backgroundColor = nil
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model:UserRelationship){
        self.model = model
        nameLbl.text = model.name
        usernameLbl.text = model.username
        switch model.type{
            
        case .following:
            followBtn.setTitle("Unfollow", for: .normal)
            followBtn.setTitleColor(.label, for: .normal)
            followBtn.backgroundColor = .systemBackground
            followBtn.layer.borderWidth = 1
            followBtn.layer.borderColor = UIColor.label.cgColor
        case .not_following:
            followBtn.setTitle("Follow", for: .normal)
            followBtn.setTitleColor(.white, for: .normal)
            followBtn.backgroundColor = .link
            followBtn.layer.borderWidth = 0
        }
    }
    
}
