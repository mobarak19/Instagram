//
//  ProfileVC.swift
//  Instagram
//
//  Created by Genusys Inc on 7/5/22.
//

import UIKit

final class ProfileVC: UIViewController {

    private var collectionView :UICollectionView?
    
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
        collectionView.backgroundColor = .red
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

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCVC.identifire, for: indexPath) as! PhotoCVC
        cell.backgroundColor = .systemBlue
        cell.configure(debug: "nature")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    
}
