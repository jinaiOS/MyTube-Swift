//
//  CommentTableViewController.swift
//  MyTube
//
//  Created by Jack Lee on 2023/09/05.
//

import UIKit
import Combine
import SwiftUI

class CommentTableViewController: UIViewController {
    //MARK: - 전역 변수
    private let youtubeManager = YoutubeManger.shared
    var data: Thumbnails.Item?
    var commentData: [Comments] = []
    
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
        fetchCommentData()
    }
    
    func fetchCommentData() {
        guard let videoId = data?.id.videoId else { print("데이터가 없습니다"); return }
        youtubeManager.getComments(from: videoId) { result in
            switch result {
            case .success(let comments):
                print(comments)
                self.commentData.append(comments)
                self.commentTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension CommentTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("눌렸습니다. \(indexPath.row)")
    }
}

extension CommentTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = commentTableView.dequeueReusableCell(withIdentifier: CommentCell.identifier, for: indexPath) as! CommentCell
        let comment = commentData[indexPath.row]
        cell.contentView.backgroundColor = .white
        // MARK: - 댓글 연결 실패
//        cell.commentLabel.text = comment.items.
        return cell
    }
}

// SwiftUI를 활용한 미리보기
struct CommentTableViewController_Previews: PreviewProvider {
    static var previews: some View {
        CommentTableVCReprsentable().edgesIgnoringSafeArea(.all)
    }
}

struct CommentTableVCReprsentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        return UINavigationController(rootViewController: CommentTableViewController())
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
    typealias UIViewControllerType = UIViewController
}
