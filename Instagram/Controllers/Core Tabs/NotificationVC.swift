//
//  NotificationVC.swift
//  Instagram
//
//  Created by Genusys Inc on 7/5/22.
//

import UIKit

final class NotificationVC: UIViewController {
    
    private var tableView:UITableView = {
        let table = UITableView()
        table.register(NotificationFollowEventTVC.self, forCellReuseIdentifier:NotificationFollowEventTVC.identifire)
        table.register(NotificationLikeEventTVC.self, forCellReuseIdentifier: NotificationLikeEventTVC.identifire)
        return table
    } ()
    

    private let spinner:UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.tintColor = .label
        return indicator
    }()
    
    private lazy var noConversationView = NoNotificationView()
    
    private var models = [UserNotification]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Notifications"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(spinner)
        //spinner.startAnimating()
        fetchNotification()

    }
    
    func fetchNotification(){
        for x in 0..<100{
            let model = UserNotification(type: x % 3 == 0 ? .like(post: UserPost(identifire: "1", postType: .photo, thumbnilImage: URL(string: "https://t4.ftcdn.net/jpg/03/16/04/19/240_F_316041918_NP4INHO1kxzQvifLqQO5zln3HgMfaEZo.jpg")!, postURL: URL(string: "https://t4.ftcdn.net/jpg/03/16/04/19/240_F_316041918_NP4INHO1kxzQvifLqQO5zln3HgMfaEZo.jpg")!, caption: "caption", lineCount: [], comments: [], createdDate: Date(), taggedUsers: [], owner: User(username: "", bio: "", name: (first: "", last: ""), birthDate: Date(), gender: .male, counts: UserCount(followers: 1, following: 1, posts: 1), joindDate: Date(), profilePhoto: URL(string: "http://google.com")!))) : .follow(state:  x % 2 == 0 ? .following : .not_following), text: "Hello world", user: User(username: "Joe", bio: "", name: (first: "Joe", last: "Smith"), birthDate: Date(), gender: .male, counts: UserCount(followers: 1, following: 1, posts: 1), joindDate: Date(), profilePhoto: URL(string: "https://t4.ftcdn.net/jpg/03/16/04/19/240_F_316041918_NP4INHO1kxzQvifLqQO5zln3HgMfaEZo.jpg")!))
            models.append(model)

        }
        tableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        spinner.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        spinner.center = view.center
    }
    
    func addNoNotificationView(){
        tableView.isHidden = true
        view.addSubview(noConversationView)
        noConversationView.frame = CGRect(x: 0, y: 0, width: view.width/2, height: view.width/4)
        noConversationView.center = view.center
    }
    
}


extension NotificationVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let model = models[indexPath.row]
    
        switch model.type{
            
        case .like(_):
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationLikeEventTVC.identifire, for: indexPath) as! NotificationLikeEventTVC
            cell.configure(with: model)
            cell.delegate = self

            return cell
        case .follow:
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationFollowEventTVC.identifire, for: indexPath) as! NotificationFollowEventTVC
            cell.configure(with: model)
            cell.delegate = self
            return cell

        }
        
     
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
extension NotificationVC:NotificationLikeEventTVCDelegate,NotificationFollowEventTVCDelegate{
    func didTapLikeBtn(model: UserNotification) {
        print("didTapLikeBtn")
        switch model.type{
        case .like(post: let post):
            let vc = PostVC(model: post)
            vc.title = post.postType.rawValue
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
        case .follow(state: _):
            fatalError("Dev issue: should not call")
        }
    }

    
    func didTapFollowUnfollowBtn(model: UserNotification) {
        print("didTapFollowUnfollowBtn")

    }
    
    
}
