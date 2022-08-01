//
//  ProfileInfoRCVC.swift
//  Instagram
//
//  Created by Genusys Inc on 7/31/22.
//

import UIKit

class ProfileInfoHeaderRCVC: UICollectionReusableView {
    static let identifire = "ProfileInfoHeaderRCVC"

    private let profileImageView:UIImageView = {
        let imageView = UIImageView()
        return imageView
        
    }()
    private let postsButton:UIButton = {
        let btn = UIButton()
        return btn
    }()
    
    private let followingButton:UIButton = {
        let btn = UIButton()
        return btn
    }()
    
    private let followersButton:UIButton = {
        let btn = UIButton()
        return btn
    }()
    
    private let editProfileButton:UIButton = {
        let btn = UIButton()
        return btn
    }()
    private let nameLbl:UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    private let bioLbl:UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        backgroundColor = .systemBlue
        addSubviews()
    }
    func addSubviews(){
        addSubview(profileImageView)
        addSubview(followersButton)
        addSubview(followingButton)
        addSubview(postsButton)
        addSubview(bioLbl)
        addSubview(nameLbl)
        addSubview(editProfileButton)

    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}
