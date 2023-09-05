//
//  CommentCell.swift
//  MyTube
//
//  Created by Jack Lee on 2023/09/05.
//

import UIKit

class CommentCell: UITableViewCell {
    static let identifier = "CommentCell"
    
    // 댓글 프로필 이미지
    private let profileImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person.fill")
        image.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        image.tintColor = .green
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.text = "테스트"
        label.font = UIFont.systemFont(ofSize: 8)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.contentView.addSubview(profileImage)
        self.contentView.addSubview(commentLabel)
        
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            profileImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            profileImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 32),
            profileImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 12),
            
            commentLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 5),
            commentLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 37),
            commentLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 8),
            commentLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 17),
        ])
    }
}
