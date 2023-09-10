//
//  CommentTableViewController.swift
//  MyTube
//
//  Created by Jack Lee on 2023/09/05.
//

import UIKit
import Combine
import SnapKit

class CommentTableViewController: UIViewController {
    //MARK: - 전역 변수
    private let youtubeManager = YoutubeManger.shared
    var data: Thumbnails.Item?
    var commentData: [Comments.Item] = []
    
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
        view.addSubview(commentTableView)
        commentTableView.dataSource = self
        commentTableView.frame = view.bounds        
        loadCommentData()
    }
    
    func loadCommentData() {
        guard let videoId = data?.id.videoId else { print("데이터가 없습니다"); return }
        youtubeManager.getComments(from: videoId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let comment):
                self.appendComments(data: comment.items)
                self.commentTableView.reloadData()
            case .failure(let error):
                print("오류 출력 확인\(error)")
            }
        }
    }
    
    func appendComments(data: [Comments.Item]?) {
        if let items = data {
            commentData += items
        }
    }
    
    func fetchData(data: Thumbnails.Item) {
        self.data = data
    }
}

extension CommentTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = commentTableView.dequeueReusableCell(withIdentifier: CommentCell.identifier, for: indexPath) as! CommentCell
        let comment = commentData[indexPath.row]
        cell.contentView.backgroundColor = .darkGray
        cell.commentLabel.text = comment.snippet.topLevelComment.snippet.textDisplay
        cell.commentLabel.textColor = .white
        if let url = comment.snippet.topLevelComment.snippet.authorProfileImageURL {
            Task {
                let image = await ImageCacheManager.shared.loadImage(url: url)
                cell.profileImage.image = image
            }
        }
        return cell
    }
}
