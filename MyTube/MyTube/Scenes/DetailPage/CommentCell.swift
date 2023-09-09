//
//  CommentCell.swift
//  MyTube
//
//  Created by Jack Lee on 2023/09/05.
//

import UIKit

class CommentCell: UITableViewCell {
    static let identifier = "CommentCell"
    var data: Thumbnails.Item?
    var commentData: [Comments] = []
    var youtubeManager = YoutubeManger.shared
    
    // 댓글 프로필 이미지
    let profileImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "person.circle")
        view.heightAnchor.constraint(equalToConstant: 30).isActive = true
        view.widthAnchor.constraint(equalToConstant: 30).isActive = true
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let commentLabel: UILabel = {
        let label = UILabel()
        label.text = "진짜 한번 꼭 보세요라고 지은님이 말함"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        
        fetchData(data: data)
        fetchCommentData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(profileImage)
        contentView.addSubview(commentLabel)
        
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        commentLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            profileImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            profileImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            commentLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 5),
            commentLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            commentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 8),
        ])
    }
    
    func fetchData(data: Thumbnails.Item?) {
        self.data = data
    }
    
    func fetchCommentData() {
        guard let videoId = data?.id.videoId else { print("데이터가 없습니다"); return }
        youtubeManager.getComments(from: videoId) { result in
            switch result {
            case .success(let comment):
                print("댓글 출력 확인\(comment)")
                self.commentData.append(comment)
            case .failure(let error):
                print("오류 출력 확인\(error)")
            }
        }
    }
}
