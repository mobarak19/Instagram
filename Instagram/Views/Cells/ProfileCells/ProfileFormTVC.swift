//
//  ProfileFormTVC.swift
//  Instagram
//
//  Created by Genusys Inc on 7/27/22.
//

import UIKit

protocol ProfileFormDelegate:AnyObject{
    
    func formTableViewCell(_ cell:UITableViewCell, didUpdateField model:EditProfileItemModel)
}

class ProfileFormTVC: UITableViewCell {

 
    static let identifire = "ProfileFormTVC"
    var delegate : ProfileFormDelegate?
    private let formLbl:UILabel = {
        let lbl = UILabel()
        lbl.textColor = .label
        lbl.numberOfLines = 1
        return lbl
    } ()
    private let field : UITextField = {
        let field = UITextField()
        field.returnKeyType = .done
        
        return field
    }()
    var tempModel : EditProfileItemModel?
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        clipsToBounds = true
        contentView.addSubview(formLbl)
        contentView.addSubview(field)
        field.delegate = self
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func layoutSubviews() {
        super.layoutSubviews()
        
        formLbl.frame = CGRect(x: 5, y: 0, width: contentView.width/3, height: contentView.hieght)
        field.frame = CGRect(x: formLbl.right + 5, y: 0, width:(contentView.width - 10 - formLbl.width), height: contentView.hieght)

    }
    
    func configure(with model:EditProfileItemModel){
        formLbl.text = model.label
        field.placeholder = model.placeholder
        field.text = model.value
        self.tempModel = model
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        formLbl.text = nil
        field.placeholder = nil
        field.text = nil
    }
}

extension ProfileFormTVC:UITextFieldDelegate{

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard let tempModel = tempModel else{
            return true
        }
        
        let model = EditProfileItemModel(label: tempModel.label, placeholder: tempModel.placeholder, value: textField.text)
        
        delegate?.formTableViewCell(self, didUpdateField: model)
        textField.resignFirstResponder()
        return true
    }
}
