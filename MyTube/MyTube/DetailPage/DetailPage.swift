//
//  detailPage.swift
//  MyTube
//
//  Created by Jack Lee on 2023/09/04.
//

import Foundation
import UIKit
import AVFoundation

class DetailPageController : UIViewController {
    //MARK: - 전역 변수

    //MARK: - 영상 + 프로필 영역
    // 영상 출력 영역 (임시)
    lazy var tempVideoView: UIImageView = {
        let video = UIImageView()
        video.image = UIImage(systemName: "ellipsis")
        video.translatesAutoresizingMaskIntoConstraints = false
        video.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 219)
        video.layer.borderWidth = 2
        video.layer.borderColor = UIColor.green.cgColor
        video.contentMode = .scaleAspectFill
        view.addSubview(video)
        return video
    }()
        
    // 영상 이름
    let titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = .black
        title.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return title
    }()

    // 영상 조회 수치 > 가져올수 없는듯...?
    let statLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        return label
    }()

    // 계정 이미지
    let profileImage: UIImageView = {
        let profileImg = UIImageView()
        let image = UIImage(systemName: "ellipsis")
        profileImg.translatesAutoresizingMaskIntoConstraints = false
        profileImg.image = image
        profileImg.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        profileImg.layer.cornerRadius = 15
        profileImg.clipsToBounds = true
        return profileImg
    }()

    // 계정 이름
    let profileName: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return name
    }()

    // 계정 구독자 수치
    let followerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        return label
    }()

    // 계정 구독 버튼
    let followButton: UIButton = {
        let button = UIButton()
        button.setTitle("구독", for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 38, height: 26)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 15
        return button
    }()

    // like 버튼
    let likeButton: UIButton = {
        let button = UIButton()
        button.setTitle("테스트", for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 87, height: 26)
        button.titleLabel?.textAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let dislikeButton: UIButton = {
        let button = UIButton()
        button.setTitle("테스트", for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 87/2, height: 26)
        button.titleLabel?.textAlignment = .right
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let shareButton: UIButton = {
        let button = UIButton()
        button.setTitle("공유", for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 26)
        button.titleLabel?.textColor = .black
        button.backgroundColor = .gray
        button.layer.cornerRadius = 15
        return button
    }()
    
    //MARK: - 댓글 영역
    
    
    //MARK: - 연관 영상 영역

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setUI() {
        
        NSLayoutConstraint.activate([
            tempVideoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tempVideoView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        
        ])
    }
}


// 함수로 겹치는 코드는 돌리고!
