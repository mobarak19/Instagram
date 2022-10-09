//
//  HomeVC.swift
//  Instagram
//
//  Created by Genusys Inc on 7/5/22.
//

import UIKit
import FirebaseAuth
class HomeVC: UIViewController {
    private var tableView:UITableView = {
        let tableView = UITableView()
        tableView.register(IGFeedPostTVC.self, forCellReuseIdentifier: IGFeedPostTVC.identifire)
        tableView.register(IGFeedPostHeaderTVC.self, forCellReuseIdentifier: IGFeedPostHeaderTVC.identifire)
        tableView.register(IGFeedPostActionsTVC.self, forCellReuseIdentifier: IGFeedPostActionsTVC.identifire)
        tableView.register(IGFeedPostGeneralTVC.self, forCellReuseIdentifier: IGFeedPostGeneralTVC.identifire)
        return tableView
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleLoginStatus()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    func handleLoginStatus(){
        if Auth.auth().currentUser == nil{
            let vc = LoginVC()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false)
        }
    }
}

extension HomeVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:IGFeedPostTVC.identifire, for: indexPath) as! IGFeedPostTVC
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
