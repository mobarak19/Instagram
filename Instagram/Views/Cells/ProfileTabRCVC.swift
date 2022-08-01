//
//  ProfileTabRCVC.swift
//  Instagram
//
//  Created by Genusys Inc on 7/31/22.
//

import UIKit

class ProfileTabRCVC: UICollectionReusableView {
    static let identifire = "ProfileTabRCVC"
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        backgroundColor = .orange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
