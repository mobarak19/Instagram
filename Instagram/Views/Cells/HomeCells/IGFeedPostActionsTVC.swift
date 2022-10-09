//
//  IGFeedPostActionsTVC.swift
//  Instagram
//
//  Created by Genusys Inc on 7/14/22.
//

import UIKit

class IGFeedPostActionsTVC: UITableViewCell {

    
    static let identifire = "IGFeedPostActionsTVC"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemGray

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
