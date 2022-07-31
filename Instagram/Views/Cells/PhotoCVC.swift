//
//  PhotoCVC.swift
//  Instagram
//
//  Created by Genusys Inc on 7/27/22.
//

import UIKit
import SDWebImage

class PhotoCVC: UICollectionViewCell {
    static let identifire = "PhotoCVC"
    
    private var imageView : UIImageView = {
        let imageView  = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    } ()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(imageView)
        contentView.clipsToBounds = true
        accessibilityHint = "Double tap to open post"
        accessibilityLabel = "User post image"

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    public func configure(with model:UserPost){
        
        let thumbnilUrl = model.thumbnilImage
        imageView.sd_setImage(with: thumbnilUrl,completed: nil)
    }
    
    public func configure(debug imageName:String){
        imageView.image = UIImage(named:imageName)
    }
}
