//
//  TabBarController.swift
//  MyTube
//
//  Created by 김지은 on 2023/09/04.
//

import UIKit
import SnapKit

final class TabBarController: UIViewController {
    
    private let homeVC = HomeViewController()
    private let myPageVC = MyPageViewController()
    private var homeNavigationVC: UINavigationController
    private var myPageNavigationVC: UINavigationController
    private let tabBarView = TabBarView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setLayout(vc: homeVC)
        configTabBarBtn()
    }
    
    init() {
        homeNavigationVC = UINavigationController(rootViewController: homeVC)
        myPageNavigationVC = UINavigationController(rootViewController: myPageVC)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension TabBarController {
    func configure() {
        view.backgroundColor = .systemBackground
        view.addSubview(homeNavigationVC.view)
    }
    
    func setLayout(vc: UIViewController) {
        vc.addTabBar(tabBarView: tabBarView)
    }
    
    func configTabBarBtn() {
        tabBarView.houseBtn.addTarget(self, action: #selector(didTappedHome), for: .touchUpInside)
        tabBarView.personBtn.addTarget(self, action: #selector(didTappedMyPage), for: .touchUpInside)
    }
    
    @objc func didTappedHome() {
        view.addSubview(homeNavigationVC.view)
        setLayout(vc: homeVC)
        changeTintColor(buttonType: tabBarView.houseBtn)
    }
    
    @objc func didTappedMyPage() {
        view.addSubview(myPageNavigationVC.view)
        setLayout(vc: myPageVC)
        changeTintColor(buttonType: tabBarView.personBtn)
    }
    
    func changeTintColor(buttonType: UIButton) {
        tabBarView.houseBtn.tintColor = (buttonType == tabBarView.houseBtn) ? .systemRed : .systemGray
        tabBarView.personBtn.tintColor = (buttonType == tabBarView.personBtn) ? .systemRed : .systemGray
    }
}
