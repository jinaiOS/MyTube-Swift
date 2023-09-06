//
//  CommentTableViewController.swift
//  MyTube
//
//  Created by Jack Lee on 2023/09/05.
//

import UIKit

class CommentTableViewController: UIViewController {
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
    }
}

extension CommentTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("눌렸습니다. \(indexPath.row)")
    }
}

extension CommentTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = commentTableView.dequeueReusableCell(withIdentifier: CommentCell.identifier, for: indexPath) as! CommentCell
        cell.contentView.backgroundColor = .white
        return cell
    }
}
