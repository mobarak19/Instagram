//
//  SettingsVC.swift
//  Instagram
//
//  Created by Genusys Inc on 7/5/22.
//
import SafariServices
import UIKit
import FirebaseAuth
struct SettingsCellModel{
    let title:String
    var handler:(()->Void)
}

final class SettingsVC: UIViewController {

    var tableView : UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    var data = [[SettingsCellModel]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    func configureModels(){
        
        data.append([
            SettingsCellModel(title: "Edit Profile") {[weak self] in
                self?.didTappedEditProfile()
            },
            SettingsCellModel(title: "Invite Friends") {[weak self] in
            
                self?.didTappedInviteFriends()
            },
            SettingsCellModel(title: "Save Original Posts") {[weak self] in
          
                self?.didTappedSaveOriginalPost()
            }
        ])
        data.append([
            SettingsCellModel(title: "Terms of Service") {[weak self] in
         
                self?.openURL(type:.terms)
            },
            SettingsCellModel(title: "Privacy Policy") {[weak self] in
                self?.openURL(type:.privacy)

            },
            SettingsCellModel(title: "Help / Feedback") {[weak self] in
                self?.openURL(type:.help)

            }
        ])
        
        data.append([
            SettingsCellModel(title: "Log Out") {[weak self] in
                self?.logout()
            }
        ])
    }
    
    func didTappedSaveOriginalPost(){
        
    }
    func openURL(type:SettingsURLType){
        var urlString:String
        switch type {
        case .terms:
            urlString = "https://help.instagram.com/581066165581870"
        case .privacy:
            urlString = "https://help.instagram.com/519522125107875/?helpref=hc_fnav"
        case .help:
            urlString = "https://help.instagram.com"

        }
        
        guard let url = URL(string: urlString) else{
            return
        }
        let vc = SFSafariViewController(url: url)
        self.present(vc, animated: true)
    }
    func didTappedEditProfile(){
        let vc = EditProfileVC()
        vc.title = "Edit Profile"
        let navVC = UINavigationController(rootViewController: vc)
       // navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    func didTappedInviteFriends(){
        
    }
    enum SettingsURLType{
        case terms,privacy,help
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    func logout(){
        
        let actionSheet = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
            
            AuthManager.shared.logOut { success in
                
                DispatchQueue.main.async {
                    if success{
                        let vc = LoginVC()
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true){
                            self.navigationController?.popToRootViewController(animated: false)
                            self.tabBarController?.selectedIndex = 0
                        }
                    }else{
                        
                        print("Could not log out")
                        
                    }
                }

            }
        }))

        actionSheet.popoverPresentationController?.sourceView  = tableView
        actionSheet.popoverPresentationController?.sourceRect = tableView.bounds
        self.present(actionSheet, animated: true)
 
    }

}

extension SettingsVC:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        data[indexPath.section][indexPath.row].handler()
    }
}
