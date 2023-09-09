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
        mainLabel.translatesAutoresizingMaskIntoConstraints = false // 이 부분을 추가
        contentView.addSubview(mainLabel)

        mainLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
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
        contentView.addSubview(logoutButton)
        
        logoutButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(36)
            make.trailing.equalToSuperview().offset(-24)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
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
        let subCircleIcon = UIImageView(image: UIImage(named: "image1"))
        subCircleIcon.contentMode = .scaleAspectFill
        subCircleIcon.clipsToBounds = true
        subCircleIcon.layer.cornerRadius = 40
        subCircleIcon.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(subCircleIcon)
        
        subCircleIcon.snp.makeConstraints { make in
            make.top.equalTo(subscribeLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(24)
            make.width.equalTo(80)
            make.height.equalTo(80)
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
            make.top.equalTo(subCircleIcon.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(24)
            make.width.equalTo(200)
            make.height.equalTo(20)
        }
        
        // 좋아요 영상
        let rectangleView = UIView()
        rectangleView.backgroundColor = .gray // 원하는 색상으로 설정하세요
        rectangleView.translatesAutoresizingMaskIntoConstraints = false
        rectangleView.layer.cornerRadius = 6 // 모서리 반지름 설정
        contentView.addSubview(rectangleView)
        
        rectangleView.snp.makeConstraints { make in
            make.top.equalTo(likeLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(24)
            make.width.equalTo(140)
            make.height.equalTo(100)
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
            make.top.equalTo(rectangleView.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(24)
            make.width.equalTo(200)
            make.height.equalTo(20)
        }
        
        // 시청 기록
        let historyView = UIView()
        historyView.backgroundColor = .gray // 원하는 색상으로 설정하세요
        historyView.translatesAutoresizingMaskIntoConstraints = false
        historyView.layer.cornerRadius = 6 // 모서리 반지름 설정
        contentView.addSubview(historyView)
        
        historyView.snp.makeConstraints { make in
            make.top.equalTo(historyLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(24)
            make.width.equalTo(140)
            make.height.equalTo(100)
        }
        
        NSLayoutConstraint.activate([
            historyView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
        
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
