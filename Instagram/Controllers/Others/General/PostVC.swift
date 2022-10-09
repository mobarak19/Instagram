//
//  PostVC.swift
//  Instagram
//
//  Created by Genusys Inc on 7/5/22.
//

import UIKit

enum PostRenderType{
    case header(provider:User)
    case primaryContent(provider:UserPost)
    case actions(provider:String)
    case comments(provider:[PostComment])
}
struct PostRenderViewModel{
    let renderType:PostRenderType
}

class PostVC: UIViewController {
    private let model:UserPost?
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(IGFeedPostTVC.self, forCellReuseIdentifier: IGFeedPostTVC.identifire)
        tableView.register(IGFeedPostHeaderTVC.self, forCellReuseIdentifier: IGFeedPostHeaderTVC.identifire)
        tableView.register(IGFeedPostActionsTVC.self, forCellReuseIdentifier: IGFeedPostActionsTVC.identifire)
        tableView.register(IGFeedPostGeneralTVC.self, forCellReuseIdentifier: IGFeedPostGeneralTVC.identifire)
        return tableView
    }()
    
    private var renderModels:[PostRenderViewModel] = []
    
    init(model:UserPost?){
        self.model = model
        super.init(nibName: nil, bundle: nil)
        configureModels()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    func configureModels(){
        guard let userPostModel = model else{return}
        renderModels.append(PostRenderViewModel(renderType: .header(provider: userPostModel.owner)))
        renderModels.append(PostRenderViewModel(renderType: .primaryContent(provider: userPostModel)))
        renderModels.append(PostRenderViewModel(renderType: .actions(provider: "")))
        var comments = [PostComment]()
        for x in 0...4{
            comments.append(PostComment(identifire: "\(x)", username: "Joe", text: "This is a comment", creatdDate: Date(), likes: []))
        }
        renderModels.append(PostRenderViewModel(renderType: .comments(provider: comments)))
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

}

extension PostVC:UITableViewDataSource,UITableViewDelegate{
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return renderModels.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch renderModels[section].renderType{
        case .header(provider: _):return 1
        case .primaryContent(provider: _): return 1
        case .actions(provider: _):return 1
        case .comments(provider: let comments):return comments.count>4 ? 4: 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = renderModels[indexPath.section]
        
        switch model.renderType{
        case .header(provider: let provider):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTVC.identifire, for: indexPath) as! IGFeedPostHeaderTVC
            return cell
        case .primaryContent(provider: let provider):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTVC.identifire, for: indexPath) as! IGFeedPostTVC
            return cell
        case .actions(provider: let provider):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionsTVC.identifire, for: indexPath) as! IGFeedPostActionsTVC
            return cell
        case .comments(provider: let provider):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTVC.identifire, for: indexPath) as! IGFeedPostGeneralTVC
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = renderModels[indexPath.section]
        switch model.renderType{
        case .header(_):return 70
        case .primaryContent(_): return view.width
        case .actions(_): return 60
        case .comments(_): return 50
        }
    }
}
