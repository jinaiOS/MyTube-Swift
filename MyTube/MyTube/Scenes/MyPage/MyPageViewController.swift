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

class MyPageViewController: UIViewController {
    
    let logoutButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        // 스크롤 가능한 뷰를 생성
         let scrollView = UIScrollView()
         scrollView.translatesAutoresizingMaskIntoConstraints = false
         view.addSubview(scrollView)

         NSLayoutConstraint.activate([
             scrollView.topAnchor.constraint(equalTo: view.topAnchor),
             scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
         ])

         // 컨텐츠 뷰 생성
         let contentView = UIView()
         contentView.translatesAutoresizingMaskIntoConstraints = false
         scrollView.addSubview(contentView)

         NSLayoutConstraint.activate([
             contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
             contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
             contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
             contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
             contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
         ])
        

        
        // 메인 텍스트
        let mainLabel = UILabel()
        mainLabel.text = "MY"
        mainLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        mainLabel.textColor = .black
        mainLabel.textAlignment = .center
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mainLabel)

        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(-30) // contentView의 top에 고정
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(20)
        }
        
        // 로그아웃 아이콘
        let logoutButton = UIButton(type: .system)
        let logoutIcon = UIImage(systemName: "rectangle.portrait.and.arrow.right")
        logoutButton.setImage(logoutIcon, for: .normal)
        logoutButton.tintColor = .black
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)

        // UIBarButtonItem 생성 및 customView 설정
        let logoutBarButtonItem = UIBarButtonItem(customView: logoutButton)

        // 네비게이션 바의 오른쪽 아이템으로 설정
        self.navigationItem.rightBarButtonItem = logoutBarButtonItem
                
        // 프로필 사진 아이콘
        let profileIcon = UIImageView(image: UIImage(named: "image1"))
        profileIcon.contentMode = .scaleAspectFill
        profileIcon.clipsToBounds = true
        profileIcon.layer.cornerRadius = 25
        profileIcon.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(profileIcon)

        profileIcon.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.top.equalTo(mainLabel.snp.bottom).offset(24)
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
        contentView.addSubview(nicknameLabel)
        
        nicknameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileIcon.snp.trailing).offset(8)
            make.top.equalTo(mainLabel.snp.bottom).offset(28)
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
        contentView.addSubview(idLabel)
        
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
        contentView.addSubview(editButton)

        editButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-24)
            make.top.equalTo(mainLabel.snp.bottom).offset(34)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }

        // editButton에 탭 이벤트를 추가합니다.
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        
        // 라인
        let lineView = UIView()
        lineView.backgroundColor = .systemGray5
        lineView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(lineView)

        lineView.snp.makeConstraints { make in
            make.top.equalTo(editButton.snp.bottom).offset(32)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(2)
        }
        
        
        
        // 구독한 채널 텍스트
        let subscribeLabel = UILabel()
        subscribeLabel.text = "구독한 채널"
        subscribeLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        subscribeLabel.textColor = .black
        subscribeLabel.textAlignment = .left
        subscribeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(subscribeLabel)
        
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
        contentView.addSubview(circleScrollView)
        
        let circleStackView = UIStackView()
        circleStackView.axis = .horizontal
        circleStackView.spacing = 14 // 원 사이의 간격 조절
        circleStackView.translatesAutoresizingMaskIntoConstraints = false
        circleScrollView.addSubview(circleStackView)
        circleScrollView.showsHorizontalScrollIndicator = false
        
        // 원 모양 이미지 뷰 생성 및 스택 뷰에 추가
        for _ in 0..<6 {
            let circleImageView = UIImageView(image: UIImage(systemName: "circle.fill"))
            circleImageView.tintColor = .gray // 이미지 뷰의 색상 설정
            circleImageView.contentMode = .scaleAspectFit
            circleImageView.clipsToBounds = true
            circleImageView.layer.cornerRadius = 40
            circleImageView.translatesAutoresizingMaskIntoConstraints = false
            circleImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true // 원 모양 이미지 뷰의 너비 조절
            circleImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true // 원 모양 이미지 뷰의 높이 조절
            
            // 원 모양 이미지 뷰를 스택 뷰에 추가
            circleStackView.addArrangedSubview(circleImageView)
        }

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
        contentView.addSubview(likeLabel)
        
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
        contentView.addSubview(rectangleScrollView)

        // 사각형 모양의 뷰들을 담을 스택 뷰
        let rectangleStackView = UIStackView()
        rectangleStackView.axis = .horizontal
        rectangleStackView.spacing = 14 // 사각형 뷰들 사이의 간격 조절
        rectangleStackView.translatesAutoresizingMaskIntoConstraints = false
        rectangleScrollView.addSubview(rectangleStackView)

        // 사각형 모양의 뷰를 6개 추가
        for _ in 0..<6 {
            let rectangleView = UIView()
            rectangleView.backgroundColor = .gray // 원하는 색상으로 설정하세요
            rectangleView.translatesAutoresizingMaskIntoConstraints = false
            rectangleView.layer.cornerRadius = 6 // 모서리 반지름 설정
            rectangleStackView.addArrangedSubview(rectangleView)

            rectangleView.widthAnchor.constraint(equalToConstant: 140).isActive = true // 사각형 뷰의 너비 조절
            rectangleView.heightAnchor.constraint(equalToConstant: 100).isActive = true // 사각형 뷰의 높이 조절
        }

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
        contentView.addSubview(historyLabel)
        
        historyLabel.snp.makeConstraints { make in
            make.top.equalTo(rectangleScrollView.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(24)
            make.width.equalTo(200)
            make.height.equalTo(20)
        }
        
        // 시청 기록
        // 스크롤 가능한 컨테이너 뷰
        let historyScrollView = UIScrollView()
        historyScrollView.showsHorizontalScrollIndicator = false // 가로 스크롤 바 숨김
        historyScrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(historyScrollView)

        // 사각형 모양의 뷰들을 담을 스택 뷰
        let historyStackView = UIStackView()
        historyStackView.axis = .horizontal
        historyStackView.spacing = 14 // 사각형 뷰들 사이의 간격 조절
        historyStackView.translatesAutoresizingMaskIntoConstraints = false
        historyScrollView.addSubview(historyStackView)

        // 사각형 모양의 뷰를 6개 추가
        for _ in 0..<6 {
            let historyItemView = UIView()
            historyItemView.backgroundColor = .gray // 원하는 색상으로 설정하세요
            historyItemView.translatesAutoresizingMaskIntoConstraints = false
            historyItemView.layer.cornerRadius = 6 // 모서리 반지름 설정
            historyStackView.addArrangedSubview(historyItemView)

            historyItemView.widthAnchor.constraint(equalToConstant: 140).isActive = true // 사각형 뷰의 너비 조절
            historyItemView.heightAnchor.constraint(equalToConstant: 100).isActive = true // 사각형 뷰의 높이 조절
        }

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
            historyScrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -120)
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
            historyScrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
        
        
    }
    // 로그아웃 버튼을 눌렀을 때 호출될 메서드
        @objc func logoutButtonTapped() {
            // LoginViewController를 생성합니다.
//            let loginVC = LoginViewController()
//
//            if let navigationController = self.navigationController {
//                navigationController.setViewControllers([loginVC], animated: true)
//            } else {
//                let navigationController = UINavigationController(rootViewController: loginVC)
//                navigationController.modalPresentationStyle = .fullScreen
//                self.present(navigationController, animated: true, completion: nil)
//            }
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(LoginViewController(), animated: false)
        }
    
    @objc func editButtonTapped() {
        let joinMembershipVC = JoinMembershipViewController()
        
        if let navigationController = self.navigationController {
            navigationController.pushViewController(joinMembershipVC, animated: true)
        } else {
            let navigationController = UINavigationController(rootViewController: joinMembershipVC)
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true, completion: nil)
        }
    }

    deinit {
        print("deinit - MyPageVC")
    }
}
