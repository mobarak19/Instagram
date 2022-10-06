//
//  NoNotificationView.swift
//  Instagram
//
//  Created by Genusys Inc on 10/6/22.
//

import UIKit

class NoNotificationView: UIView {

    private let noNotificationLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "No Notification Yet"
        lbl.textColor = .secondaryLabel
        lbl.textAlignment = .center
        lbl.numberOfLines = 1
        return lbl
    } ()
    
    private let imageView : UIImageView = {
        let imgView = UIImageView()
        imgView.tintColor = .secondaryLabel
        imgView.contentMode = .scaleAspectFit
        imgView.image = UIImage(systemName: "bell")
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(noNotificationLbl)
        addSubview(imageView)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: (width-50)/2, y: 0, width: 50, height: 50).integral
        noNotificationLbl.frame = CGRect(x: 0, y: imageView.bottom, width: width, height: height - 50).integral
    }

}
