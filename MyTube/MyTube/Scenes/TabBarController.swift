//
//  TabBarController.swift
//  MyTube
//
//  Created by 김지은 on 2023/09/04.
//

import UIKit
import SnapKit

final class TabBarController: UITabBarController {
    
    private let homeVC = HomeViewController()
    private let myPageVC = MyPageViewController()
    private let tabBarView = TabBarView(frame: .zero)
    let logoutBarButtonItem = UIBarItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [
            createNavViewController(viewController: homeVC),
            createNavViewController(viewController: myPageVC)
        ]
        tabBarView.delegate = self
        view.addSubview(tabBarView)
        
        tabBarView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.width.equalTo(280)
            $0.height.equalTo(65)
        }
        configTabBarBtn()
        self.navigationItem.rightBarButtonItem?.isHidden = true
        tabBar.isHidden = true
    }
}

private extension TabBarController {
    private func createNavViewController(viewController: UIViewController) -> UIViewController {
        self.navigationItem.title = "Youtube"
        
        // 네비게이션 바의 오른쪽 아이템으로 설정
        self.navigationItem.rightBarButtonItem = setLogoutButton()
        let navController = viewController
        return navController
    }
    
    func configTabBarBtn() {
        tabBarView.houseBtn.addTarget(self, action: #selector(didTappedHome), for: .touchUpInside)
        tabBarView.personBtn.addTarget(self, action: #selector(didTappedMyPage), for: .touchUpInside)
    }
    
    @objc func didTappedHome() {
        self.navigationItem.rightBarButtonItem?.isHidden = true
        tabBarController?.selectedIndex = 0
        self.navigationItem.title = "Youtube"
        changeTintColor(buttonType: tabBarView.houseBtn)
    }
    
    @objc func didTappedMyPage() {
        self.navigationItem.rightBarButtonItem?.isHidden = false
        tabBarController?.selectedIndex = 1
        self.navigationItem.title = "MY"

        changeTintColor(buttonType: tabBarView.personBtn)
    }
    
    func setLogoutButton() -> UIBarButtonItem {
        // 로그아웃 아이콘
        let logoutButton = UIButton(type: .system)
        let logoutIcon = UIImage(systemName: "rectangle.portrait.and.arrow.right")
        logoutButton.setImage(logoutIcon, for: .normal)
        logoutButton.tintColor = .black
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)

        // UIBarButtonItem 생성 및 customView 설정
        let logoutBarButtonItem = UIBarButtonItem(customView: logoutButton)
        return logoutBarButtonItem
    }
    
    // 로그아웃 버튼을 눌렀을 때 호출될 메서드
        @objc func logoutButtonTapped() {
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(UINavigationController(rootViewController: LoginViewController()), animated: false)
        }
    
    func changeTintColor(buttonType: UIButton) {
        tabBarView.houseBtn.tintColor = (buttonType == tabBarView.houseBtn) ? .systemRed : .systemGray
        tabBarView.personBtn.tintColor = (buttonType == tabBarView.personBtn) ? .systemRed : .systemGray
    }
    
    
}
extension TabBarController : TabBarViewDelegate {
    func did(selectindex: Int) {
        selectedIndex = selectindex
    }
}
