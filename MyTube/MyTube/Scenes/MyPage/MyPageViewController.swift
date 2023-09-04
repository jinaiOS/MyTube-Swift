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

class MyPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        
        // "MY" 텍스트 레이블
        let myLabel = UILabel()
        myLabel.text = "MY"
        myLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        myLabel.textColor = .black
        myLabel.textAlignment = .center
        myLabel.frame = CGRect(x: 24, y: 64, width: view.frame.width - 48, height: 20)
        view.addSubview(myLabel)

        let logoutButton = UIButton(type: .system)
        let logoutIcon = UIImage(systemName: "rectangle.portrait.and.arrow.right")
        logoutButton.setImage(logoutIcon, for: .normal)
        logoutButton.tintColor = .black
        logoutButton.frame = CGRect(x: 340 , y: 60, width: 30, height: 30) // MY 텍스트 오른쪽에 배치
        view.addSubview(logoutButton)
        
        // 동그라미 모양 아이콘
        let circleIcon = UIImageView(image: UIImage(named: "image1"))
        circleIcon.contentMode = .scaleAspectFill
        circleIcon.clipsToBounds = true
        circleIcon.layer.cornerRadius = 25
        circleIcon.frame = CGRect(x: 24, y: 110, width: 50, height: 50)
        view.addSubview(circleIcon)

        
        // 닉네임 라벨
        let textLabel = UILabel()
        textLabel.text = "Janus"
        textLabel.font = UIFont.systemFont(ofSize: 20)
        textLabel.textColor = .black
        textLabel.textAlignment = .left
        textLabel.frame = CGRect(x: 88, y: 112, width: 100, height: 20)
        view.addSubview(textLabel)
        
        // 아이디 라벨
        let textLabel2 = UILabel()
        textLabel2.text = "@janus5307"
        textLabel2.font = UIFont.systemFont(ofSize: 18)
        textLabel2.textColor = .gray
        textLabel2.textAlignment = .left
        textLabel2.frame = CGRect(x: 88, y: 136, width: 200, height: 20)
        view.addSubview(textLabel2)
    
        // 화살표 아이콘
        let editButton = UIButton(type: .system)
        let editIcon = UIImage(systemName: "chevron.right")
        editButton.setImage(editIcon, for: .normal)
        editButton.tintColor = .black // 아이콘 색상 설정
        editButton.frame = CGRect(x: 340, y: 122, width: 30, height: 30)
        view.addSubview(editButton)

    }
    deinit {
        print("deinit - MyPageVC")
    }
}

