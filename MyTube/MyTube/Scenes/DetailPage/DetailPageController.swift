//
//  DetailPageController.swift
//  MyTube
//
//  Created by Jack Lee on 2023/09/04.
//

import Foundation
import UIKit
import AVFoundation

class DetailPageController: UIViewController {
    //MARK: - 전역 변수
    
    //MARK: - 영상 + 프로필 영역
    // 영상 출력 영역 (임시)
    lazy var tempVideoView: UIImageView = {
        let video = UIImageView()
        video.image = UIImage(systemName: "ellipsis")
        video.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 219)
        video.contentMode = .scaleAspectFill
        video.translatesAutoresizingMaskIntoConstraints = false
        return video
    }()
    
    // 영상 이름
    let titleLabel: UILabel = {
        let title = UILabel()
        title.textColor = .black
        title.text = "출력 확인"
        title.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    // 영상 조회 수치 > 가져올수 없는듯...?
    let statLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "출력 확인"
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 계정 이미지
    let profileImage: UIImageView = {
        let profileImg = UIImageView()
        let image = UIImage(systemName: "ellipsis")
        profileImg.image = image
        profileImg.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        profileImg.layer.cornerRadius = 15
        profileImg.clipsToBounds = true
        profileImg.translatesAutoresizingMaskIntoConstraints = false
        return profileImg
    }()
    
    // 계정 이름
    let profileName: UILabel = {
        let name = UILabel()
        name.text = "프로필이름"
        name.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    // 계정 구독자 수치
    let followerLabel: UILabel = {
        let label = UILabel()
        label.text = "계정 팔로우"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 계정 구독 버튼
    let followButton: UIButton = {
        let button = UIButton()
        button.setTitle("구독", for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 38, height: 26)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // like 버튼
    let likeButton: UIButton = {
        let button = UIButton()
        button.setTitle("like", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .gray
        button.frame = CGRect(x: 0, y: 0, width: 38, height: 26)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let dislikeButton: UIButton = {
        let button = UIButton()
        button.setTitle("no like", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .gray
        button.frame = CGRect(x: 0, y: 0, width: 38, height: 26)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let shareButton: UIButton = {
        let button = UIButton()
        button.setTitle("공유", for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 26)
        button.titleLabel?.textColor = .black
        button.backgroundColor = .gray
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let titleStackView = UIStackView()
    let profileStackView = UIStackView()
    let followStackView = UIStackView()
    
    //MARK: - 댓글 영역
    
    //MARK: - 연관 영상 영역
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    func setUI() {
        configureTopSection()
    }
    
    func configureTopSection() {
        setVideoConstraints()
        setTitleStackView()
        setProfileStackView()
        setFollowStackView()
    }
    
    func setVideoConstraints() {
        view.addSubview(tempVideoView)
        NSLayoutConstraint.activate([
            tempVideoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tempVideoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tempVideoView.heightAnchor.constraint(equalToConstant: 219)
        ])
    }
    
    func setTitleStackView() {
        view.addSubview(titleStackView)
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(statLabel)
        titleStackView.axis = .vertical
        titleStackView.spacing = 4

        setTitleStackViewConstraints()
    }
    
    func setTitleStackViewConstraints() {
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleStackView.topAnchor.constraint(equalTo: tempVideoView.bottomAnchor),
            titleStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 24),
            titleStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -24),
        ])
    }
    
    func setProfileStackView() {
        view.addSubview(profileStackView)
        profileStackView.addArrangedSubview(profileImage)
        profileStackView.addArrangedSubview(profileName)
        profileStackView.addArrangedSubview(followerLabel)
        profileStackView.addArrangedSubview(followButton)
        profileStackView.axis = .horizontal
        profileStackView.distribution = .fillProportionally
        profileStackView.spacing = 8
        
        setProfileStackViewConstraints()
    }
    
    func setProfileStackViewConstraints() {
        profileStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileStackView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 12),
            profileStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 24),
            profileStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -24),
        ])
    }
    
    func setFollowStackView() {
        view.addSubview(followStackView)
        followStackView.addArrangedSubview(likeButton)
        followStackView.addArrangedSubview(dislikeButton)
        followStackView.addArrangedSubview(shareButton)
        followStackView.axis = .horizontal
        followStackView.distribution = .fillProportionally
        followStackView.spacing = 8
        
        setFollowStackViewConstraints()
    }
    
    func setFollowStackViewConstraints() {
        followStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            followStackView.topAnchor.constraint(equalTo: profileStackView.bottomAnchor, constant: 8),
            followStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            followStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -224)
        ])
    }
        deinit {
        print("deinit - 디테일 페이지")
    }
}
