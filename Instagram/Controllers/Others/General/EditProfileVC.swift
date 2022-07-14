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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavigationBar()

    }
    
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
