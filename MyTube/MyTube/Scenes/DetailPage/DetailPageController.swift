//
//  DetailPageController.swift
//  MyTube
//
//  Created by Jack Lee on 2023/09/04.
//

import Combine
import UIKit
import GoogleAPIClientForREST
import youtube_ios_player_helper

class DetailPageController: UIViewController {
    
    //MARK: - 전역 변수
    private let commentTableView = CommentTableViewController()
    private let homeModel = HomeViewModel()
    private let inset: CGFloat = 24
    private var url: String?
    var data: Thumbnails.Item?
    var subscription = Set<AnyCancellable>()
    
    //MARK: - 영상 + 프로필 영역
    lazy var videoPlayerView: YTPlayerView = {
        let video = YTPlayerView()
        video.contentMode = .scaleAspectFit
        video.translatesAutoresizingMaskIntoConstraints = false
        return video
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        let newSize = label.intrinsicContentSize
        label.textColor = .black
        label.frame.size = newSize
        label.text = "유튜브 영상 제목"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statLabel: UILabel = {
        let label = UILabel()
        let newSize = label.intrinsicContentSize
        label.textColor = .black
        label.frame.size = newSize
        label.text = "조회수 100만회"
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var titleContainerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fillProportionally
        [titleLabel, statLabel].forEach {
            stack.addArrangedSubview($0)
        }
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let profileImage: UIImageView = {
        let profileImg = UIImageView()
        let image = UIImage(systemName: "person.circle")
        profileImg.image = image
        profileImg.contentMode = .scaleAspectFit
        profileImg.layer.cornerRadius = 17
        profileImg.clipsToBounds = true
        profileImg.heightAnchor.constraint(equalToConstant: 40).isActive = true
        profileImg.widthAnchor.constraint(equalToConstant: 40).isActive = true
        profileImg.translatesAutoresizingMaskIntoConstraints = false
        return profileImg
    }()
    
    let profileName: UILabel = {
        let name = UILabel()
        name.text = "프로필 이름"
        name.textAlignment = .left
        name.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    let followerLabel: UILabel = {
        let label = UILabel()
        let newSize = label.sizeThatFits(label.frame.size)
        label.text = "40만"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        label.frame.size = newSize
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let followButton: UIButton = {
        let button = UIButton()
        button.setTitle("구독", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        button.heightAnchor.constraint(equalToConstant: 26).isActive = true
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addVideoToList), for: .touchUpInside)
        return button
    }()
    
    lazy var profileContainerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 8
        [profileImage, profileName, followerLabel].forEach {
            stack.addArrangedSubview($0)
        }
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let likeButton: UIButton = {
        let button = UIButton()
        button.setTitle("👍🏻", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .blue
        button.heightAnchor.constraint(equalToConstant: 26).isActive = true
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let dislikeButton: UIButton = {
        let button = UIButton()
        button.setTitle("👎🏻", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .red
        button.heightAnchor.constraint(equalToConstant: 26).isActive = true
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let shareButton: UIButton = {
        let button = UIButton()
        button.setTitle("공유", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        button.heightAnchor.constraint(equalToConstant: 26).isActive = true
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var buttonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        [likeButton, dislikeButton].forEach {stack.addArrangedSubview($0)}
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    //MARK: - 댓글 영역
    
    let commentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.widthAnchor.constraint(equalToConstant: 345).isActive = true
        view.heightAnchor.constraint(equalToConstant: 74).isActive = true
        view.backgroundColor = .darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let textLabel: UILabel = {
        let text = UILabel()
        text.text = "댓글"
        text.textColor = .white
        text.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        text.heightAnchor.constraint(equalToConstant: 20).isActive = true
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let numberLabel: UILabel = {
        let text = UILabel()
        text.text = "3천"
        text.textColor = .white
        text.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        text.heightAnchor.constraint(equalToConstant: 20).isActive = true
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    lazy var statStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .bottom
        stack.axis = .horizontal
        stack.spacing = 4
        [textLabel, numberLabel].forEach{stack.addArrangedSubview($0)}
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let userImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person.circle")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        image.widthAnchor.constraint(equalToConstant: 30).isActive = true
        image.heightAnchor.constraint(equalToConstant: 30).isActive = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let commentLabel: UILabel = {
        let text = UILabel()
        text.text = "댓글 작성 우루루루루"
        text.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        text.textColor = .white
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    lazy var commentStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 5
        [userImage, commentLabel].forEach{stack.addArrangedSubview($0)}
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var commentViewStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.heightAnchor.constraint(equalToConstant: 74).isActive = true
        stack.widthAnchor.constraint(equalToConstant: 345).isActive = true
        return stack
    }()
    
    //MARK: - 연관 영상 영역
    
    private let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        return layout
    }()
    
    private lazy var videoCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = true
        collectionView.showsVerticalScrollIndicator = true
        collectionView.register(ThumbnailCell.self, forCellWithReuseIdentifier: ThumbnailCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        // 하단 영상 썸네일 호출
        bindViewModel()
        homeModel.getThumbnailData()
        
        setupUI()
    }
    
    //MARK: - setup 함수
    
    func setupUI() {
        setVideo()
        setViewDetail()
        configureCollectionSection()
    }
    
    func setVideo() {
        view.addSubview(videoPlayerView)
        
        if let data = data {
            DispatchQueue.main.async {
                self.videoPlayerView.load(withVideoId: data.id.videoId)
            }
        }
        
        NSLayoutConstraint.activate([
            videoPlayerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            videoPlayerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),// constant: inset),
            videoPlayerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),// constant: -inset),
            videoPlayerView.heightAnchor.constraint(equalToConstant: 219)
        ])
    }
    
    func setViewDetail() {
        [titleContainerStack, profileContainerStack, followButton, buttonStack, shareButton].forEach{ view.addSubview($0) }
        setTitleContainer()
        setProfileView()
        setInteractionButton()
        setCommentView()
    }
    
    func setTitleContainer() {
        titleLabel.text = data?.snippet.title
        
        NSLayoutConstraint.activate([
            titleContainerStack.topAnchor.constraint(equalTo: videoPlayerView.bottomAnchor, constant: 11),
            titleContainerStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: inset),
            titleContainerStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -inset),
            titleContainerStack.heightAnchor.constraint(equalToConstant: 64)
        ])
    }
    
    func setProfileView() {
        profileName.text = data?.snippet.channelTitle
        
        NSLayoutConstraint.activate([
            profileContainerStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: inset),
            profileContainerStack.topAnchor.constraint(equalTo: titleContainerStack.bottomAnchor, constant: 12),
            followButton.topAnchor.constraint(equalTo: titleContainerStack.bottomAnchor, constant: 19),
            followButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -inset)
        ])
    }
    
    func setInteractionButton() {
        NSLayoutConstraint.activate([
            buttonStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: inset),
            buttonStack.topAnchor.constraint(equalTo: profileContainerStack.bottomAnchor, constant: 8),
            shareButton.leadingAnchor.constraint(equalTo: buttonStack.trailingAnchor, constant: 8),
            shareButton.topAnchor.constraint(equalTo: profileContainerStack.bottomAnchor, constant: 8),
        ])
    }
    
    func setCommentView() {
        view.addSubview(commentViewStack)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        commentStack.addGestureRecognizer(tapGesture)
        
        [commentView, statStack, commentStack].forEach{commentViewStack.addSubview($0)}
        
        NSLayoutConstraint.activate([
            commentViewStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: inset),
            commentViewStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -inset),
            commentViewStack.topAnchor.constraint(equalTo: buttonStack.bottomAnchor, constant: 23),
            statStack.leadingAnchor.constraint(equalTo: commentView.leadingAnchor, constant: 8),
            statStack.topAnchor.constraint(equalTo: commentView.topAnchor, constant: 8),
            commentStack.leadingAnchor.constraint(equalTo: commentView.leadingAnchor, constant: 8),
            commentStack.topAnchor.constraint(equalTo: statStack.bottomAnchor, constant: 4),
            commentStack.trailingAnchor.constraint(equalTo: commentView.trailingAnchor, constant: -8)
        ])
    }
    
    func configureCollectionSection() {
        view.addSubview(videoCollectionView)
        setVideoCollectionView()
    }
    
    func setVideoCollectionView() {
        NSLayoutConstraint.activate([
            videoCollectionView.topAnchor.constraint(equalTo: commentViewStack.bottomAnchor, constant: 25),
            videoCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            videoCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: inset),
            videoCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -inset),
        ])
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        print("눌려써요!")
        if let sheet = self.commentTableView.sheetPresentationController, let data = data {
            sheet.detents = [.medium()]
            commentTableView.fetchData(data: data)
        }
        self.present(self.commentTableView, animated: true, completion: nil)
    }
    
    //MARK: - 데이터 호출 함수
    // 탭한 유튜브 영상 데이터 가져오기 위한 함수
    func configureData(url: String, data: Thumbnails.Item) {
        self.url = url
        self.data = data
    }
    
    // 탭한 영상 저장하도록 정리
    @objc func addVideoToList() {
        UserDefaults.standard.string(forKey: "currentVideoId")
        if let data = data {
            print("비디오 아이디는 \(data.id.videoId)")
            print("채널 아이디는 \(data.snippet.channelId)")
        }
    }
    
    //MARK: - collectionView 데이터 채우기
    func bindViewModel() {
        homeModel.$ThumbnailList.sink { [weak self] thumbnails in
            guard let self = self else { return }
            print("thumbnails: \(thumbnails)")
            DispatchQueue.main.async {
                self.videoCollectionView.reloadData()
            }
        }.store(in: &subscription)
    }
    
    deinit {
        print("deinit - 디테일 페이지")
    }
}

//MARK: - CollectionView Delegate

extension DetailPageController: UICollectionViewDelegate {
    
}

extension DetailPageController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        present(<#T##viewControllerToPresent: UIViewController##UIViewController#>, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeModel.ThumbnailList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThumbnailCell.identifier, for: indexPath) as! ThumbnailCell
        let item = homeModel.ThumbnailList[indexPath.item]
        cell.configure(data: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let currentRow = indexPath.row
        if (currentRow % homeModel.display) == homeModel.display - 5
            && (currentRow / homeModel.display) == (homeModel.getRequestPage - 1) {
            homeModel.getThumbnailData()
        }
    }
}

//MARK: - CollectionView FlowLayout

extension DetailPageController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 345, height: 238)
    }
}

//MARK: - YTPlayerViewDelegate

extension DetailPageController: YTPlayerViewDelegate {
    
}
