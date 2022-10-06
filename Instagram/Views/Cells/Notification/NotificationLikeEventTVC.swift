//
//  NotificationLikeEventTVC.swift
//  Instagram
//
//  Created by Genusys Inc on 10/6/22.
//

import UIKit
import SDWebImage


protocol NotificationLikeEventTVCDelegate:AnyObject{
    func didTapLikeBtn(model:UserNotification)
}

class NotificationLikeEventTVC: UITableViewCell {

    static let identifire = "NotificationLikeEventTVC"

    public weak var delegate:NotificationLikeEventTVCDelegate?
    
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
        lbl.text = "@joe liked your photo"
        return lbl
    }()
    
    private let postBtn:UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "nature"), for: .normal)
        return btn
    }()
    
    private var model:UserNotification?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(profileImageView)
        contentView.addSubview(postBtn)
        contentView.addSubview(label)
        postBtn.addTarget(self, action: #selector(onTappPostBtn), for: .touchUpInside)
        selectionStyle = .none

    }
    
    @objc func onTappPostBtn(){
        guard let model = model else {
            return
        }
        delegate?.didTapLikeBtn(model: model)
    }
    
    public func configure(with model:UserNotification){
        self.model = model
        self.label.text = model.text
        self.profileImageView.sd_setImage(with: model.user.profilePhoto)
        switch model.type{
        case .like(post: let post):
            let thumbnail = post.thumbnilImage
            postBtn.sd_setBackgroundImage(with: thumbnail, for: .normal)
        case .follow:
            break
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postBtn.setBackgroundImage(nil, for: .normal)
        label.text = nil
        profileImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.frame = CGRect(x: 3, y: 3, width: contentView.height - 6, height: contentView.height - 6)
        profileImageView.layer.cornerRadius = profileImageView.height/2.0
        let size = contentView.height - 4
        postBtn.frame = CGRect(x: contentView.width - size, y: 2, width: size, height: size)
        label.frame = CGRect(x: profileImageView.right+5, y: 0, width: contentView.width - size - profileImageView.width - 11, height: contentView.height - 6)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
