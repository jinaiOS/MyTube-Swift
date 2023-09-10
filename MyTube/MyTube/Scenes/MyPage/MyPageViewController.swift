//
//  MyPageViewController.swift
//  MyTube
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

//
//  MyPageViewController.swift
//  MyTube
//
//  Created by 허수빈 on 2023/09/04.
//

import UIKit
import SnapKit
import SwiftUI

class MyPageViewController: UIViewController {
    let nicknameLabel = UILabel()
    let idLabel = UILabel()
    let historyScrollView = UIScrollView()
    let historyStackView = UIStackView()
    let circleStackView = UIStackView()
    let historyItemView = UIImageView()
    let rectangleStackView = UIStackView()
    var historyImageCnt = 0
    private let viewModel = HomeViewModel()
    
    let logoutButton = UIButton(type: .system)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let nickname = UserDefaultManager.sharedInstance.userInfo?.nickName,
           let id = UserDefaultManager.sharedInstance.userInfo?.id {
            nicknameLabel.text = nickname
            idLabel.text = "@" + id
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        lazy var scrollView : UIScrollView = {
            let scrollView = UIScrollView()
            view.addSubview(scrollView)
            scrollView.snp.makeConstraints {
                $0.edges.equalTo(view.safeAreaLayoutGuide)
            }
            return scrollView
        }()
        
        lazy var stackView : UIStackView = {
            let stackView = UIStackView()
            scrollView.addSubview(stackView)
            stackView.snp.makeConstraints {
                $0.top.leading.bottom.trailing.equalTo(scrollView)
                $0.centerX.equalTo(scrollView)
                //                stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            }
            
            return stackView
        }()
        
        stackView.spacing = 20
        stackView.axis = .vertical
        
        lazy var vProfile : UIView = {
            let vProfile = UIView()
            stackView.addArrangedSubview(vProfile)
            vProfile.snp.makeConstraints {
                $0.height.equalTo(88)
            }
            return vProfile
        }()
        
        // 프로필 사진 아이콘
        let profileIcon = UIImageView(image: UIImage(named: "image1"))
        profileIcon.contentMode = .scaleAspectFill
        profileIcon.clipsToBounds = true
        profileIcon.layer.cornerRadius = 25
        profileIcon.translatesAutoresizingMaskIntoConstraints = false
        vProfile.addSubview(profileIcon)
        
        profileIcon.snp.makeConstraints { make in
            make.leading.equalTo(vProfile).offset(24)
            make.top.equalTo(vProfile).offset(24)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        // 닉네임 텍스트
        let nicknameLabel = UILabel()
        nicknameLabel.text = "Janus"
        nicknameLabel.font = UIFont.systemFont(ofSize: 20)
        nicknameLabel.textColor = .black
        nicknameLabel.textAlignment = .left
        nicknameLabel.translatesAutoresizingMaskIntoConstraints = false
        vProfile.addSubview(nicknameLabel)
        
        nicknameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileIcon.snp.trailing).offset(8)
            make.top.equalTo(vProfile).offset(28)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
        
        // 아이디 텍스트
        let idLabel = UILabel()
        idLabel.text = "@janus5307"
        idLabel.font = UIFont.systemFont(ofSize: 18)
        idLabel.textColor = .gray
        idLabel.textAlignment = .left
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        vProfile.addSubview(idLabel)
        
        idLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileIcon.snp.trailing).offset(8)
            make.top.equalTo(nicknameLabel.snp.bottom).offset(4)
            make.width.equalTo(200)
            make.height.equalTo(20)
        }
        
        
        
        // 화살표 아이콘
        let editButton = UIButton(type: .system)
        let editIcon = UIImage(systemName: "chevron.right")
        editButton.setImage(editIcon, for: .normal)
        editButton.tintColor = .black // 아이콘 색상 설정
        editButton.translatesAutoresizingMaskIntoConstraints = false
        vProfile.addSubview(editButton)
        
        editButton.snp.makeConstraints { make in
            make.trailing.equalTo(vProfile).offset(-24)
            make.top.equalTo(vProfile).offset(34)
            make.width.equalTo(30)
            //            make.height.equalTo(30)
        }
        
        // editButton에 탭 이벤트를 추가합니다.
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        
        // 라인
        let lineView = UIView()
        lineView.backgroundColor = .systemGray5
        lineView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(lineView)
        
        lineView.snp.makeConstraints { make in
            make.height.equalTo(2)
        }
        
        
        
        // 구독한 채널 텍스트
        let subscribeLabel = UILabel()
        subscribeLabel.text = "구독한 채널"
        subscribeLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        subscribeLabel.textColor = .black
        subscribeLabel.textAlignment = .left
        subscribeLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(subscribeLabel)
        
        subscribeLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(24)
            make.width.equalTo(200)
            make.height.equalTo(20)
        }
        
        
        // 구독한 채널
        let circleScrollView = UIScrollView()
        circleScrollView.showsHorizontalScrollIndicator = true // 수평 스크롤 바 숨김
        circleScrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(circleScrollView)
        
        circleStackView.axis = .horizontal
        circleStackView.spacing = 14 // 원 사이의 간격 조절
        circleStackView.translatesAutoresizingMaskIntoConstraints = false
        circleScrollView.addSubview(circleStackView)
        circleScrollView.showsHorizontalScrollIndicator = false
        

        
        // 원 모양 이미지 뷰 스택 뷰의 레이아웃 설정
        circleStackView.snp.makeConstraints { make in
            make.top.equalTo(circleScrollView.snp.top)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.equalTo(circleScrollView.snp.bottom)
        }
        
        // 스크롤 뷰의 레이아웃 설정
        circleScrollView.snp.makeConstraints { make in
            make.top.equalTo(subscribeLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(90) // 스크롤 뷰의 높이 조절
        }
        
        
        
        // 좋아요 영상 텍스트
        let likeLabel = UILabel()
        likeLabel.text = "좋아요 영상"
        likeLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        likeLabel.textColor = .black
        likeLabel.textAlignment = .left
        likeLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(likeLabel)
        
        likeLabel.snp.makeConstraints { make in
            make.top.equalTo(circleStackView.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(24)
            make.width.equalTo(200)
            make.height.equalTo(20)
        }
        
        // 좋아요 영상
        let rectangleScrollView = UIScrollView()
        rectangleScrollView.showsHorizontalScrollIndicator = false // 가로 스크롤 바 숨김
        rectangleScrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(rectangleScrollView)
        
        // 사각형 모양의 뷰들을 담을 스택 뷰
        rectangleStackView.axis = .horizontal
        rectangleStackView.spacing = 14 // 사각형 뷰들 사이의 간격 조절
        rectangleStackView.translatesAutoresizingMaskIntoConstraints = false
        rectangleScrollView.addSubview(rectangleStackView)
        

        
        // 스크롤 뷰와 스택 뷰의 레이아웃 설정
        rectangleScrollView.snp.makeConstraints { make in
            make.top.equalTo(likeLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(0)
            make.trailing.equalToSuperview().offset(0)
            make.height.equalTo(100) // 스크롤 뷰의 높이 조절
        }
        
        rectangleStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(100) // 스택 뷰의 높이 조절
        }
        
        
        
        // 시청 기록 텍스트
        let historyLabel = UILabel()
        historyLabel.text = "시청 기록"
        historyLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        historyLabel.textColor = .black
        historyLabel.textAlignment = .left
        historyLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(historyLabel)
        
        historyLabel.snp.makeConstraints { make in
            make.top.equalTo(rectangleScrollView.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(24)
            make.width.equalTo(200)
            make.height.equalTo(20)
        }
        
        // 시청 기록
        // 스크롤 가능한 컨테이너 뷰
        historyScrollView.showsHorizontalScrollIndicator = false // 가로 스크롤 바 숨김
        historyScrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(historyScrollView)
        
        // 사각형 모양의 뷰들을 담을 스택 뷰
        historyStackView.axis = .horizontal
        historyStackView.spacing = 14 // 사각형 뷰들 사이의 간격 조절
        historyStackView.translatesAutoresizingMaskIntoConstraints = false
        historyScrollView.addSubview(historyStackView)
        
        
        // 스크롤 뷰와 스택 뷰의 레이아웃 설정
        historyScrollView.snp.makeConstraints { make in
            make.top.equalTo(historyLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(0)
            make.trailing.equalToSuperview().offset(0)
            make.height.equalTo(100) // 스크롤 뷰의 높이 조절
        }
        
        historyStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(100) // 스택 뷰의 높이 조절
        }
        
        NSLayoutConstraint.activate([
            historyScrollView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -120)
        ])
        
        let transparentRectangle = UIView()
        transparentRectangle.backgroundColor = .clear // 투명한 배경색
        transparentRectangle.translatesAutoresizingMaskIntoConstraints = false
        transparentRectangle.layer.cornerRadius = 6 // 모서리 반지름 설정
        transparentRectangle.layer.borderWidth = 0 // 테두리 두께 설정
        transparentRectangle.layer.borderColor = UIColor.black.cgColor // 테두리 색상 설정
        historyScrollView.addSubview(transparentRectangle)
        
        transparentRectangle.snp.makeConstraints { make in
            make.top.equalTo(historyScrollView.snp.bottom).offset(24)
            make.width.equalTo(200)
            make.height.equalTo(600)
        }
        
        NSLayoutConstraint.activate([
            historyScrollView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -16)
        ])
        
        
        let emptyView = UIView()
        emptyView.backgroundColor = .clear // 투명한 배경색
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(emptyView)
        emptyView.snp.makeConstraints {
            $0.height.equalTo(100)
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let channelID = UserDefaults.standard.object(forKey: "subscribeChannelID") as? Array<String>
       
        for view in self.circleStackView.subviews {
            view.removeFromSuperview()
        }
        // 원 모양 이미지 뷰 생성 및 스택 뷰에 추가
        for i in channelID ?? [] {
            let circleImageView = UIImageView(image: UIImage(systemName: "circle.fill"))
            circleImageView.tintColor = .gray // 이미지 뷰의 색상 설정
            circleImageView.contentMode = .scaleAspectFit
            circleImageView.clipsToBounds = true
            Task {
                let profileImg = await YoutubeManger.shared.getProfileThumbnail(channelID: i)?.items?[0].snippet.thumbnails.medium.url
                circleImageView.image = await ImageCacheManager.shared.loadImage(url: profileImg ?? "")
            }
            circleImageView.layer.cornerRadius = 40
            circleImageView.translatesAutoresizingMaskIntoConstraints = false
            circleImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true // 원 모양 이미지 뷰의 너비 조절
            circleImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true // 원 모양 이미지 뷰의 높이 조절
            
            // 원 모양 이미지 뷰를 스택 뷰에 추가
            circleStackView.addArrangedSubview(circleImageView)
        }
        
        for view in self.rectangleStackView.subviews {
            view.removeFromSuperview()
        }
        
        let likeVideoID = UserDefaults.standard.object(forKey: "likeVideoID") as? Array<String>
        
        // 사각형 모양의 뷰를 6개 추가
        for i in likeVideoID ?? [] {
            let rectangleView = UIImageView()
            rectangleView.backgroundColor = .gray // 원하는 색상으로 설정하세요
            rectangleView.translatesAutoresizingMaskIntoConstraints = false
            rectangleView.layer.cornerRadius = 6 // 모서리 반지름 설정
            Task {
                rectangleView.image = await ImageCacheManager.shared.loadImage(url: "https://img.youtube.com/vi/\(i)/0.jpg")
            }
            
            rectangleStackView.addArrangedSubview(rectangleView)
            
            rectangleView.widthAnchor.constraint(equalToConstant: 140).isActive = true // 사각형 뷰의 너비 조절
            rectangleView.heightAnchor.constraint(equalToConstant: 100).isActive = true // 사각형 뷰의 높이 조절
        }
        
        let historyVideo = UserDefaults.standard.object(forKey: "currentVideoId") as? Array<String>
        for view in self.historyStackView.subviews {
            view.removeFromSuperview()
        }
        for i in 0..<(historyVideo?.count ?? 0) {
                let historyItemView = UIImageView()
                historyItemView.backgroundColor = .gray // 원하는 색상으로 설정하세요
                historyItemView.translatesAutoresizingMaskIntoConstraints = false
                Task {
                    historyItemView.image = await ImageCacheManager.shared.loadImage(url: "https://img.youtube.com/vi/\(historyVideo?[i] ?? "")/0.jpg")
                }
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(historyItemTapped(_:)))
                historyItemView.isUserInteractionEnabled = true // 탭을 인식하도록 설정
                historyItemView.addGestureRecognizer(tapGesture)
    

                historyItemView.layer.cornerRadius = 6 // 모서리 반지름 설정
                historyStackView.addArrangedSubview(historyItemView)

                historyItemView.widthAnchor.constraint(equalToConstant: 140).isActive = true // 사각형 뷰의 너비 조절
                historyItemView.heightAnchor.constraint(equalToConstant: 100).isActive = true // 사각형 뷰의 높이 조절
            }

    }
    
    @objc func historyItemTapped(_ sender: UITapGestureRecognizer) {
        let detailPageController = DetailPageController()
        let data = viewModel.ThumbnailList[sender.view?.tag ?? 0]
        let videoID = data.id.videoId
        let url = "https://youtu.be/" + videoID
        
        let detailVC = DetailPageController()
        detailVC.configureData(url: url, data: data)
        UserDefaultManager.sharedInstance.saveCurrentVideo(videoId: data.id.videoId)
        navigationController?.pushViewController(detailVC, animated: true)
        
        Task {
            let channelID = data.snippet.channelId
            let channelInfo = await YoutubeManger.shared.getChannelInfo(channelID: channelID)
            print("====> \(channelInfo)")
        }
        navigationController?.pushViewController(detailPageController, animated: true)
    }
    
    // 로그아웃 버튼을 눌렀을 때 호출될 메서드
    @objc func logoutButtonTapped() {
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(LoginViewController(), animated: false)
    }
    
    @objc func editButtonTapped() {
        let joinMembershipVC = JoinMembershipViewController()
        joinMembershipVC.type = .Edit
        self.navigationController?.pushViewController(joinMembershipVC, animated: true)
    }
    
    deinit {
        print("deinit - MyPageVC")
    }
}

// SwiftUI를 활용한 미리보기
struct MyPageViewController_Previews: PreviewProvider {
    static var previews: some View {
        MyPageViewControllerReprsentable().edgesIgnoringSafeArea(.all)
    }
}

struct MyPageViewControllerReprsentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        return UINavigationController(rootViewController: MyPageViewController())
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
    typealias UIViewControllerType = UIViewController
}
