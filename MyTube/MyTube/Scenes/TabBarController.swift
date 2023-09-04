//
//  TabBarController.swift
//  MyTube
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit
import SnapKit

final class TabBarController: UIViewController {
    
    private let homeVC = HomeViewController()
    private let myPageVC = MyPageViewController()
    private let tabBarView = TabBarView(frame: .zero)
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setLayout()
        configTabBarBtn()
    }
    
    @objc func didTappedHome() {
        contentView.addSubview(homeVC.view)
        changeTintColor()
    }
    
    @objc func didTappedMyPage() {
        contentView.addSubview(myPageVC.view)
        changeTintColor()
    }
}

extension TabBarController {
    func configure() {
        contentView.addSubview(homeVC.view)
        homeVC.didMove(toParent: self)
    }
    
    func setLayout() {
        [contentView, tabBarView].forEach {
            view.addSubview($0)
        }
        
        tabBarView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.width.equalTo(280)
            $0.height.equalTo(65)
        }
    }
    
    func configTabBarBtn() {
        tabBarView.houseBtn.addTarget(self, action: #selector(didTappedHome), for: .touchUpInside)
        tabBarView.personBtn.addTarget(self, action: #selector(didTappedMyPage), for: .touchUpInside)
    }
    
    func changeTintColor() {
        tabBarView.houseBtn.tintColor = (tabBarView.houseBtn.tintColor == .systemGray) ? .systemPink : .systemGray
        tabBarView.personBtn.tintColor = (tabBarView.personBtn.tintColor == .systemGray) ? .systemPink : .systemGray
    }
}
