//
//  ProfileVC.swift
//  Instagram
//
//  Created by Genusys Inc on 7/5/22.
//

import UIKit

final class ProfileVC: UIViewController {

    private var collectionView :UICollectionView?
    private var userPosts = [UserPost]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureNavigationBar()
        
        configureCollectionView()
        
    }
    
    func configureCollectionView()  {
        
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        
        layout.minimumLineSpacing = 1
        
        layout.minimumInteritemSpacing = 1
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)

        let size =  (view.width-4)/3
        
        layout.itemSize = CGSize(width: size, height: size)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        guard let collectionView = collectionView else {
            return
        }

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotoCVC.self, forCellWithReuseIdentifier: PhotoCVC.identifire)
        
        collectionView.register(ProfileInfoHeaderRCVC.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileInfoHeaderRCVC.identifire)
        
        collectionView.register(ProfileTabRCVC.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileTabRCVC.identifire)
        
        view.addSubview(collectionView)
    }
    func configureNavigationBar(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(settingsDidTapped))
    }
 
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }

    @objc func settingsDidTapped(){
        let vc = SettingsVC()
        vc.title = "Settings"
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension ProfileVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return 0
            
        }
       // return userPosts.count
        return 30
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCVC.identifire, for: indexPath) as! PhotoCVC
        cell.backgroundColor = .systemBlue
        cell.configure(debug: "nature")
        //let model = userPosts[indexPath.row]
       // cell.configure(with: model)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let vc = PostVC(model: nil)
        vc.title = "Post"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        if indexPath.section == 1{
            let tabControllHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileTabRCVC.identifire, for: indexPath) as! ProfileTabRCVC
            tabControllHeader.delegate = self
            return tabControllHeader
        }
        let profileHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileInfoHeaderRCVC.identifire, for: indexPath) as! ProfileInfoHeaderRCVC
        profileHeader.delegate = self
        return profileHeader
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0{
            return CGSize(width: collectionView.width, height: collectionView.height/3)
        }
        return CGSize(width: collectionView.width, height: 50)
    }
    
}

extension ProfileVC:ProfileInfoHeaderRCVCDelegate{
    func profileHeaderDidTapPostBtn(_ header: ProfileInfoHeaderRCVC) {
        print("profileHeaderDidTapPostBtn")
        collectionView?.scrollToItem(at: IndexPath(row: 0, section: 1), at: .top, animated: true)
    }
    
    func profileHeaderDidTapFollowerBtn(_ header: ProfileInfoHeaderRCVC) {
        print("profileHeaderDidTapFollowerBtn")
        var mockData = [UserRelationship]()
        for x in 0..<10{
            mockData.append(UserRelationship(username: "@joe", name: "Joe Smith", type: x % 2 == 0 ?.following : .not_following))
        }
        
        let vc = ListVC(data: mockData)
        vc.title = "Follwers"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)

    }
    
    func profileHeaderDidTapFollowingBtn(_ header: ProfileInfoHeaderRCVC) {
        print("profileHeaderDidTapFollowingBtn")
        var mockData = [UserRelationship]()
        for x in 0..<10{
            mockData.append(UserRelationship(username: "@joe", name: "Joe Smith", type: x % 2 == 0 ?.following : .not_following))
        }
        let vc = ListVC(data: mockData)
        vc.title = "Following"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)

    }
    
    func profileHeaderDidTapEidtProfileBtn(_ header: ProfileInfoHeaderRCVC) {
        print("profileHeaderDidTapEidtProfileBtn")
        let vc = EditProfileVC()
        vc.title = "Edit Profile"
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)

    }
    
    
}


extension ProfileVC:ProfileTabRCVCDelegate{
    func didTapGridBtnTab() {
        print("didTapGridBtnTab")
    }
    
    func didTapTagBtnTab() {
        print("didTapTagBtnTab")

    }
    
    
}
