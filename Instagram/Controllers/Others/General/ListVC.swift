//
//  ListVC.swift
//  Instagram
//
//  Created by Genusys Inc on 7/5/22.
//

import UIKit

class ListVC: UIViewController {

    private let data:[UserRelationship]
    
    private let tableView:UITableView  = {
        let tableView = UITableView()
        tableView.register(UserFollowTVC.self, forCellReuseIdentifier: UserFollowTVC.identifire)
        return tableView
    }()
    
    init(data:[UserRelationship]){
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension ListVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:UserFollowTVC.identifire, for: indexPath) as! UserFollowTVC
        cell.configure(with: data[indexPath.row])
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}

extension ListVC : UserFollowTVCDelegate{
    func didTapUnfollowBtn(_ model: UserRelationship) {
        print("didTapUnfollowBtn")
    }
    
    
}
