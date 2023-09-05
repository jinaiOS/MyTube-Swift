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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setLayout()
        configTabBarBtn()
    }
}

private extension TabBarController {
    func configure() {
        view.backgroundColor = .systemBackground
        view.addSubview(homeVC.view)
    }
    
    func setLayout() {
        view.addSubview(tabBarView)
        
        tabBarView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.width.equalTo(280)
            $0.height.equalTo(65)
        }
    }
    
    @objc func didTappedHome() {
        view.addSubview(homeVC.view)
        setLayout()
        changeTintColor(buttonType: tabBarView.houseBtn)
    }
    
    @objc func didTappedMyPage() {
        view.addSubview(myPageVC.view)
        setLayout()
        changeTintColor(buttonType: tabBarView.personBtn)
    }
    
    func configTabBarBtn() {
        tabBarView.houseBtn.addTarget(self, action: #selector(didTappedHome), for: .touchUpInside)
        tabBarView.personBtn.addTarget(self, action: #selector(didTappedMyPage), for: .touchUpInside)
    }
    
    func changeTintColor(buttonType: UIButton) {
        tabBarView.houseBtn.tintColor = (buttonType == tabBarView.houseBtn) ? .systemRed : .systemGray
        tabBarView.personBtn.tintColor = (buttonType == tabBarView.personBtn) ? .systemRed : .systemGray
    }
}
