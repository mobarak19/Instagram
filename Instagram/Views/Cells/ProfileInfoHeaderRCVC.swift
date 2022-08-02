//
//  ProfileInfoRCVC.swift
//  Instagram
//
//  Created by Genusys Inc on 7/31/22.
//

import UIKit

protocol ProfileInfoHeaderRCVCDelegate:AnyObject{
    func profileHeaderDidTapPostBtn(_ header:ProfileInfoHeaderRCVC)
    func profileHeaderDidTapFollowerBtn(_ header:ProfileInfoHeaderRCVC)
    func profileHeaderDidTapFollowingBtn(_ header:ProfileInfoHeaderRCVC)
    func profileHeaderDidTapEidtProfileBtn(_ header:ProfileInfoHeaderRCVC)

}

class ProfileInfoHeaderRCVC: UICollectionReusableView {
    static let identifire = "ProfileInfoHeaderRCVC"

    public weak var delegate:ProfileInfoHeaderRCVCDelegate?
    
    private let profileImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.layer.masksToBounds = true
        return imageView
        
    }()
    private let postsButton:UIButton = {
        let btn = UIButton()
        btn.setTitle("Posts", for: .normal)
        btn.backgroundColor = .secondarySystemBackground
        btn.setTitleColor(UIColor.label, for: .normal)
        return btn
    }()
    
    private let followingButton:UIButton = {
        let btn = UIButton()
        btn.setTitle("Following", for: .normal)
        btn.backgroundColor = .secondarySystemBackground
        btn.setTitleColor(UIColor.label, for: .normal)

        return btn
    }()
    
    private let followersButton:UIButton = {
        let btn = UIButton()
        btn.setTitle("Followers", for: .normal)
        btn.backgroundColor = .secondarySystemBackground
        btn.setTitleColor(UIColor.label, for: .normal)

        return btn
    }()
    
    private let editProfileButton:UIButton = {
        let btn = UIButton()
        btn.setTitle("Edit Your Profile", for: .normal)
        btn.backgroundColor = .secondarySystemBackground
        btn.setTitleColor(UIColor.label, for: .normal)

        return btn
    }()
    private let nameLbl:UILabel = {
        let lbl = UILabel()
        lbl.text = "Mobarak"
        lbl.textColor = .label
        lbl.numberOfLines = 1
        return lbl
    }()
    private let bioLbl:UILabel = {
        let lbl = UILabel()
        lbl.text = "Your task provides an expiration handler that the system calls if it needs to terminate your task"
        lbl.textColor = .label
        lbl.numberOfLines = 0
        return lbl
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        addSubviews()
        addButtonActions()
    }
    func addSubviews(){
        addSubview(profileImageView)
        addSubview(postsButton)

        addSubview(followersButton)
        addSubview(followingButton)
        addSubview(bioLbl)
        addSubview(nameLbl)
        addSubview(editProfileButton)

    }
    
    func addButtonActions(){
        postsButton.addTarget(self, action: #selector(didTappedPostBtn), for: .touchUpInside)
        followingButton.addTarget(self, action: #selector(didTappedFollowingBtn), for: .touchUpInside)
        followersButton.addTarget(self, action: #selector(didTappedFollowersBtn), for: .touchUpInside)
        editProfileButton.addTarget(self, action: #selector(didTappedEditProfileBtn), for: .touchUpInside)
    }
    
    @objc func didTappedPostBtn(){
        delegate?.profileHeaderDidTapPostBtn(self)
    }
    @objc func didTappedFollowersBtn(){
        delegate?.profileHeaderDidTapFollowerBtn(self)
    }
    @objc func didTappedFollowingBtn(){
        delegate?.profileHeaderDidTapFollowingBtn(self)
    }
    @objc func didTappedEditProfileBtn(){
        delegate?.profileHeaderDidTapEidtProfileBtn(self)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let profilePhotoSize = width/4
        profileImageView.frame = CGRect(x: 5, y: 5, width: profilePhotoSize, height: profilePhotoSize).integral
        
        profileImageView.layer.cornerRadius = profilePhotoSize/2.0

        let buttonHeight = profilePhotoSize/2
        
        let countButtonWidth = (width - 10 - profilePhotoSize)/3.0
        postsButton.frame = CGRect(x: profileImageView.right, y: 5, width: countButtonWidth, height: buttonHeight).integral
        followersButton.frame = CGRect(x: postsButton.right, y: 5, width: countButtonWidth, height: buttonHeight).integral
        followingButton.frame = CGRect(x: followersButton.right, y: 5, width: countButtonWidth, height: buttonHeight).integral
        editProfileButton.frame = CGRect(x: profileImageView.right, y:buttonHeight + 5, width: countButtonWidth*3.0, height: buttonHeight).integral
        nameLbl.frame = CGRect(x: 5, y: 5 + profileImageView.bottom, width: width - 10, height: 50)
        let bioLblSize = bioLbl.sizeThatFits(frame.size)
        bioLbl.frame = CGRect(x: 5, y: 5 + nameLbl.bottom, width: width - 15, height: bioLblSize.height)
    }
    
}
