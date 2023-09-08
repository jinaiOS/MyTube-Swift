//
//  CommentTableViewController.swift
//  MyTube
//
//  Created by Jack Lee on 2023/09/05.
//

import UIKit
import Combine

class CommentTableViewController: UIViewController {
    //MARK: - 전역 변수
    private let youtubeManager = YoutubeManger.shared
    var data: Thumbnails.Item?
    
    //MARK: - IBOutlet
    let commentTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.layer.cornerRadius = 10
        tableView.clipsToBounds = true
        tableView.allowsSelection = true
        tableView.register(CommentCell.self, forCellReuseIdentifier: CommentCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        view.addSubview(commentTableView)
        commentTableView.dataSource = self
        commentTableView.delegate = self
        
        commentTableView.frame = view.bounds
        
//        if let data = data {
//            youtubeManager.getComments(from: data.id.videoId)
//        }
    }
    
    func recieveData(data: Thumbnails.Item) {
        self.data = data
    }
}

extension CommentTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("눌렸습니다. \(indexPath.row)")
    }
}

extension CommentTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = commentTableView.dequeueReusableCell(withIdentifier: CommentCell.identifier, for: indexPath) as! CommentCell
        cell.contentView.backgroundColor = .white
        return cell
    }
}
