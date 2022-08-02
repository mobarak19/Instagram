//
//  ProfileTabRCVC.swift
//  Instagram
//
//  Created by Genusys Inc on 7/31/22.
//

import UIKit

class ProfileTabRCVC: UICollectionReusableView {
    static let identifire = "ProfileTabRCVC"
    
    private let gridBtn:UIButton = {
        let btn = UIButton()
        btn.clipsToBounds = true
        btn.tintColor = .systemBlue
        btn.setBackgroundImage(UIImage(systemName: "square.grid.2x2"), for: .normal)
        return btn
    }()
    
    private let taggedBtn:UIButton = {
        let btn = UIButton()
        btn.clipsToBounds = true
        btn.tintColor = .secondarySystemBackground
        btn.setBackgroundImage(UIImage(systemName: "tag"), for: .normal)
        return btn
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        backgroundColor = .systemBackground
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
