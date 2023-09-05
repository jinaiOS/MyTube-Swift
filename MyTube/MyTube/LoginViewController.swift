//
//  LoginViewController.swift
//  MyTube
//
//  Created by 김지은 on 2023/09/04.
//

import UIKit

class LoginViewController: UIViewController {
    
    lazy var tfID: CustomTextfieldView = {
        let textfield = CustomTextfieldView()
        return textfield
    }()
    
    lazy var tfPassword: CustomTextfieldView = {
        let textfield = CustomTextfieldView()
        return textfield
    }()
    
    lazy var imgIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "MainIcon")
        return image
    }()
    
    lazy var vButton: UIView = {
       let view = UIView()
        return view
    }()
    
    lazy var btnLogin: UIButton = {
       let button = UIButton()
        return button
    }()
    
    lazy var btnFindID: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("아이디 찾기", for: .normal)
         return button
    }()
    
    lazy var btnRePassword: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("비밀번호 재설정", for: .normal)
         return button
    }()
    
    lazy var btnJoinMembership: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("회원가입", for: .normal)
        button.addTarget(self, action: #selector(joinMembershipButtonTouched), for: .touchUpInside)
         return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.backgroundColor = .white
        stack.layer.cornerRadius = 30
        stack.spacing = 10
        
        [tfID, tfPassword, vButton].forEach {
            stack.addArrangedSubview($0)
        }
        return stack
    }()
    
    private lazy var managementIDStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.backgroundColor = .white
        [btnFindID, btnRePassword, btnJoinMembership].forEach {
            stack.addArrangedSubview($0)
        }
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //하단 인디케이터 1초뒤 삭제
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.setNeedsUpdateOfHomeIndicatorAutoHidden()
        }
        
        let tapGesture : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        //gesture의 이벤트가 끝나도 뒤에 이벤트를 View로 전달
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        tfID.initTextFieldText(placeHolder: "Email", delegate: self)
        tfPassword.initTextFieldText(placeHolder: "pass", delegate: self)

        setLayout()
    }
    
    private func setLayout() {

        view.addSubview(imgIcon)
        view.addSubview(stackView)
        view.addSubview(managementIDStackView)
        
        imgIcon.snp.makeConstraints {
            $0.height.equalTo(150)
            $0.centerX.equalTo(self.view)
            $0.bottom.equalTo(stackView.snp_topMargin)
        }
        
        stackView.snp.makeConstraints {
            $0.center.equalTo(self.view).offset(40)
            $0.leading.equalTo(self.view).offset(24)
            $0.trailing.equalTo(self.view).offset(-24)
        }
        
        managementIDStackView.snp.makeConstraints {
            $0.top.equalTo(stackView.snp_bottomMargin).offset(10)
            $0.leading.trailing.equalTo(stackView)
        }
        
        vButton.addSubview(btnLogin)
        setButtonLayout()
        
        
           
    }
    
    func setButtonLayout() {
        btnLogin.setTitle("Login", for: .normal)
        btnLogin.addTarget(self, action: #selector(loginButtonTouched), for: .touchUpInside)
        btnLogin.backgroundColor = UIColor.red
        btnLogin.layer.cornerRadius = 20
        btnLogin.snp.makeConstraints {
            $0.top.trailing.leading.equalTo(vButton)
            $0.height.equalTo(50)
        }
    }
    
    // 화면에 터치 했을 때 키보드 사라짐
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func loginButtonTouched() {
        UserdefaultManager.shared.requestUserInfoList()
//        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(TabBarController(), animated: false)
    }
    
    @objc func joinMembershipButtonTouched() {
        self.navigationController?.pushViewController(JoinMembershipViewController(), animated: true)
    }
}
extension LoginViewController: CustomTextfieldViewDelegate {
    func customTextFieldShouldReturn(_ textField: UITextField) -> Bool {
       if textField == tfID.tf {
            tfPassword.tf.becomeFirstResponder() // next 버튼 선택 시 -> tfPW 포커싱
        } else {
            tfPassword.tf.resignFirstResponder() // return 버튼 선택 시 -> 키보드 내려감
        }
        return true
    }
    
    func customTextFieldValueChanged(_ textfield: UITextField) {
        
    }
    
    func customTextFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func customTextFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func customTextField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func errorStatus(isError: Bool, view: CustomTextfieldView) {
        
    }
    
    
}
