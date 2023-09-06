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
    let commentTableView = CommentTableViewController()
    
    //MARK: - 영상 + 프로필 영역
    // 영상 출력 영역 (임시)
    lazy var tempVideoView: UIImageView = {
        let video = UIImageView()
        video.image = UIImage(systemName: "ellipsis")
        video.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 219)
        video.contentMode = .scaleAspectFill
        return video
    }()
    
    let titleLabel: UILabel = {
        let title = UILabel()
        title.textColor = .black
        title.text = "유튜브 영상 제목"
        title.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return title
    }()
    
    let statLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "100만회"
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        return label
    }()
    
    // 영상 이름 + 조회수 담는 stackView
    lazy var titleContainerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        [titleLabel, statLabel].forEach {
            stack.addArrangedSubview($0)
        }
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // 계정 이미지
    let profileImage: UIImageView = {
        let profileImg = UIImageView()
        let image = UIImage(systemName: "person.circle")
        profileImg.image = image
        profileImg.contentMode = .scaleAspectFill
        profileImg.layer.cornerRadius = 17
        profileImg.clipsToBounds = true
        profileImg.translatesAutoresizingMaskIntoConstraints = false
        profileImg.widthAnchor.constraint(equalToConstant: 40).isActive = true
        profileImg.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return profileImg
    }()
    
    let profileName: UILabel = {
        let name = UILabel()
        name.text = "프로필이름"
        name.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return name
    }()
    
    let followerLabel: UILabel = {
        let label = UILabel()
        label.text = "40만"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        return label
    }()
    
    lazy var profileContainerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.frame.size = CGSize(width: 199, height: 40)
        stack.distribution = .fillProportionally
        stack.spacing = 8
        [profileImage, profileName, followerLabel].forEach {
            stack.addArrangedSubview($0)
        }
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // 계정 구독 버튼
    let followButton: UIButton = {
        let button = UIButton()
        button.setTitle("구독", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        button.heightAnchor.constraint(equalToConstant: 26).isActive = true
        button.widthAnchor.constraint(equalToConstant: 38).isActive = true
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let likeButton: UIButton = {
        let button = UIButton()
        button.setTitle("👍🏻", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .blue
        button.heightAnchor.constraint(equalToConstant: 26).isActive = true
        button.widthAnchor.constraint(equalToConstant: 38).isActive = true
        button.layer.cornerRadius = 10
        return button
    }()
    
    let dislikeButton: UIButton = {
        let button = UIButton()
        button.setTitle("👎🏻", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .red
        button.heightAnchor.constraint(equalToConstant: 26).isActive = true
        button.widthAnchor.constraint(equalToConstant: 38).isActive = true
        button.layer.cornerRadius = 10
        return button
    }()
    
    let shareButton: UIButton = {
        let button = UIButton()
        button.setTitle("공유", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button.heightAnchor.constraint(equalToConstant: 26).isActive = true
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var buttonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        [likeButton, dislikeButton].forEach {
            stack.addArrangedSubview($0)
        }
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    //MARK: - 댓글 영역
    
    let userImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person.fill")
        image.widthAnchor.constraint(equalToConstant: 30).isActive = true
        image.heightAnchor.constraint(equalToConstant: 30).isActive = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let textLabel: UILabel = {
        let text = UILabel()
        text.text = "댓글"
        text.textColor = .white
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let numberLabel: UILabel = {
        let text = UILabel()
        text.text = "3천"
        text.textColor = .white
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let commentLabel: UILabel = {
        let text = UILabel()
        text.text = "댓글 작성 우루루루루"
        text.textColor = .white
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let commentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.widthAnchor.constraint(equalToConstant: 345).isActive = true
        view.heightAnchor.constraint(equalToConstant: 74).isActive = true
        view.backgroundColor = .darkGray
//        view.addGestureRecognizer(tapGesture)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let commentStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
//        stack.addGestureRecognizer(tapGesture)
        return stack
    }()
    
    //MARK: - 연관 영상 영역
    
    private let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.itemSize = CGSize(width: 120, height: 30)
        return layout
    }()
    
    private lazy var videoCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
//        collectionView.backgroundColor = .red
        collectionView.isScrollEnabled = true
//        collectionView.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: VideoCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        commentView.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setUI() {
        setVideoView()
        setVideoDetailView()
        configureCommentSection()
        configureCollectionSection()
    }
    
    func configureCommentSection() {
        setCommentView()
    }
    
    func setVideoView() {
        view.addSubview(tempVideoView)
//        NSLayoutConstraint.activate([
//            tempVideoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            tempVideoView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            tempVideoView.trail.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            tempVideoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            tempVideoView.heightAnchor.constraint(equalToConstant: 219)
//        ])
    }
    
    func setVideoDetailView() {
        [titleContainerStack, profileContainerStack, shareButton, followButton, buttonStack].forEach{
            view.addSubview($0)
        }
        setTitleLabelConstraints()
        setProfileView()
        setInteractionButton()
    }
    
    func setTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleContainerStack.topAnchor.constraint(equalTo: tempVideoView.bottomAnchor, constant: 11),
            titleContainerStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            titleContainerStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
//            titleContainerStack.heightAnchor.constraint(equalToConstant: 64)
        ])
    }
    
    func setProfileView() {
        NSLayoutConstraint.activate([
            profileContainerStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            profileContainerStack.topAnchor.constraint(equalTo: titleContainerStack.bottomAnchor, constant: 12),
//            profileContainerStack.trailingAnchor.constraint(equalTo: followButton.leadingAnchor, constant: -108),
            followButton.leadingAnchor.constraint(equalTo: profileContainerStack.trailingAnchor),
            followButton.topAnchor.constraint(equalTo: titleContainerStack.bottomAnchor, constant: 19),
            followButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }
    
    func setInteractionButton() {
        NSLayoutConstraint.activate([
            buttonStack.topAnchor.constraint(equalTo: profileContainerStack.bottomAnchor, constant: 8),
            buttonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            buttonStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -282),
            shareButton.leadingAnchor.constraint(equalTo: buttonStack.trailingAnchor, constant: 8),
            shareButton.topAnchor.constraint(equalTo: profileContainerStack.bottomAnchor, constant: 8)
        ])
    }
    
    func setCommentView() {
        view.addSubview(commentStackView)
        [commentView, textLabel, numberLabel, userImage, commentLabel].forEach{commentStackView.addSubview($0)}
        setCommentViewConstraints()
    }
    
    func setCommentViewConstraints() {
        NSLayoutConstraint.activate([
            commentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            commentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            commentStackView.topAnchor.constraint(equalTo: buttonStack.bottomAnchor, constant: 23),
            
            textLabel.leadingAnchor.constraint(equalTo: commentStackView.leadingAnchor, constant: 8),
            textLabel.topAnchor.constraint(equalTo: commentStackView.topAnchor, constant: 8),
            
            numberLabel.leadingAnchor.constraint(equalTo: textLabel.trailingAnchor, constant: 4),
            numberLabel.topAnchor.constraint(equalTo: commentStackView.topAnchor, constant: 8),
            numberLabel.trailingAnchor.constraint(equalTo: commentStackView.trailingAnchor, constant: 295),
            
            userImage.leadingAnchor.constraint(equalTo: commentStackView.leadingAnchor, constant: 8),
            userImage.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 4),
            
            commentLabel.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 5),
            commentLabel.bottomAnchor.constraint(equalTo: commentView.bottomAnchor, constant: -17),
            commentLabel.trailingAnchor.constraint(equalTo: commentStackView.trailingAnchor, constant: 119)
        ])
    }
    
    func configureCollectionSection() {
        view.addSubview(videoCollectionView)
        setVideoCollectionView()
    }
    
    func setVideoCollectionView() {
        NSLayoutConstraint.activate([
            videoCollectionView.topAnchor.constraint(equalTo: commentStackView.bottomAnchor),
            videoCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            videoCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            videoCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        print("눌려써요!")
        if let sheet = self.commentTableView.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        self.present(self.commentTableView, animated: true, completion: nil)
    }
    
    deinit {
        print("deinit - 디테일 페이지")
    }
}

extension DetailPageController: UICollectionViewDelegate {
    
}

extension DetailPageController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCell.identifier, for: indexPath) as! VideoCell
        return cell
    }
}

extension DetailPageController: UICollectionViewDelegateFlowLayout {
    
}
