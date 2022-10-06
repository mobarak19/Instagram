//
//  EditProfileVC.swift
//  Instagram
//
//  Created by Genusys Inc on 7/5/22.
//

import UIKit

class EditProfileVC: UIViewController {

    private let tableView:UITableView = {
        let tableView = UITableView()
        tableView.register(ProfileFormTVC.self, forCellReuseIdentifier: ProfileFormTVC.identifire)
        return tableView
    } ()
    
    var models = [[EditProfileItemModel]]()
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavigationBar()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.tableHeaderView = createTableHeaderView()
        
        configureModels()
    }
    
    func configureModels(){
        //name, username, website,bio
        
        let section1Label = ["Name","Username","Website","Bio"]
        var section1 = [EditProfileItemModel]()
        for label in section1Label {
            let model = EditProfileItemModel(label: label, placeholder: "Enter \(label)...", value: nil)
            section1.append(model)
        }
        
        //email, phone, gender
        
        let section2Label = ["Email","Phone","Gender"]
        var section2 = [EditProfileItemModel]()

        for label in section2Label {
            let model = EditProfileItemModel(label: label, placeholder: "Enter \(label)...", value: nil)
            section2.append(model)
        }
        
        models.append(section1)
        models.append(section2)
        
        tableView.reloadData()
        
        
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func createTableHeaderView()->UIView{
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.height/4).integral)
        let size = header.height/1.5
        let profilePhotoBtn = UIButton(frame: CGRect(x: (view.width-size)/2, y: (header.height-size)/2, width: size, height: size))
        header.addSubview(profilePhotoBtn)
        profilePhotoBtn.layer.masksToBounds = true
        profilePhotoBtn.layer.cornerRadius = size/2.0
        profilePhotoBtn.addTarget(self, action: #selector(didTapProfilePhotoBtn), for: .touchUpInside)
        
        profilePhotoBtn.setBackgroundImage(UIImage(systemName: "person.circle"), for: .normal)
        profilePhotoBtn.tintColor = .label
        profilePhotoBtn.layer.borderWidth = 1
        profilePhotoBtn.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        
        return header
    }
    
    @objc func didTapProfilePhotoBtn(){
        didTapChangeProfilePicture()
    }
    
    //apps call does not response in background mood.
    //network switch create problem for call
    //sound problem in call happend very often
    
    func setUpNavigationBar(){
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTappedSave))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTappedCancel))
    }
    
    @objc func didTappedCancel(){
        dismiss(animated: true)
    }
    @objc func didTappedSave(){
        
    }
    
    @objc private func didTapChangeProfilePicture(){
        let actionSheet = UIAlertController(title: "Profile Picture", message: "Change profile picture", preferredStyle: .actionSheet)
        
        
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Chose from Library", style: .default, handler: { _ in
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))
        actionSheet.popoverPresentationController?.sourceView = view
        actionSheet.popoverPresentationController?.sourceRect = view.bounds
        self.present(actionSheet, animated: true)
    }

}


extension EditProfileVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].count
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileFormTVC.identifire, for: indexPath) as! ProfileFormTVC
        
        let model = models[indexPath.section][indexPath.row]
        cell.configure(with: model)
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section == 1 else{
            return nil
        }
        return "Private Information"
    }
    
    
}
extension EditProfileVC:ProfileFormDelegate{
    func formTableViewCell(_ cell: UITableViewCell, didUpdateField model: EditProfileItemModel) {
        print(model.value)
    }
    
    
}
