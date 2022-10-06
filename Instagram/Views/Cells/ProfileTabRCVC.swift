//
//  ProfileTabRCVC.swift
//  Instagram
//
//  Created by Genusys Inc on 7/31/22.
//

import UIKit

protocol ProfileTabRCVCDelegate:AnyObject{
    func didTapGridBtnTab()
    func didTapTagBtnTab()
}

class ProfileTabRCVC: UICollectionReusableView {
    
    static let identifire = "ProfileTabRCVC"
    
    var delegate:ProfileTabRCVCDelegate?
    private let padding = CGFloat(8)
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
        btn.tintColor = .lightGray
        btn.setBackgroundImage(UIImage(systemName: "tag"), for: .normal)
        return btn
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        backgroundColor = .systemBackground
        addSubview(gridBtn)
        addSubview(taggedBtn)
        gridBtn.addTarget(self, action: #selector(didTapGridBtn), for: .touchUpInside)
        taggedBtn.addTarget(self, action: #selector(didTapTagBtn), for: .touchUpInside)

    }
    
    @objc func didTapGridBtn(){
        gridBtn.tintColor = .systemBlue
        taggedBtn.tintColor = .lightGray
        delegate?.didTapGridBtnTab()
    }
    @objc func didTapTagBtn(){
        gridBtn.tintColor = .lightGray
        taggedBtn.tintColor = .systemBlue
        delegate?.didTapTagBtnTab()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = frame.height - padding * 2
        let gridBtnX = ((frame.width/2) - size)/2
        gridBtn.frame = CGRect(x: gridBtnX, y: padding, width: size, height: size)
        taggedBtn.frame = CGRect(x: gridBtnX + (frame.width/2), y: padding, width: size, height: size)

        
    }
    
}
