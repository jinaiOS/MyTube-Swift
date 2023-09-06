//
//  JoinMembershipViewController.swift
//  MyTube
//
//  Created by 김지은 on 2023/09/04.
//

import UIKit

class JoinMembershipViewController: UIViewController {

    lazy var tfID: CustomTextfieldView = {
        let textfield = CustomTextfieldView()
        return textfield
    }()
    
    lazy var tfNickName: CustomTextfieldView = {
        let textfield = CustomTextfieldView()
        return textfield
    }()
    
    lazy var tfPassword: CustomTextfieldView = {
        let textfield = CustomTextfieldView()
        return textfield
    }()
    
    lazy var tfRePassword: CustomTextfieldView = {
        let textfield = CustomTextfieldView()
        return textfield
    }()
    
    lazy var tfName: CustomTextfieldView = {
        let textfield = CustomTextfieldView()
        return textfield
    }()
    
    lazy var tfBirth: CustomTextfieldView = {
        let textfield = CustomTextfieldView()
        return textfield
    }()
    
    lazy var btnComplete: UIButton = {
       let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 20
        return button
    }()
    
    lazy var scrollView: UIScrollView = {
      let scrollView = UIScrollView()
      return scrollView
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.backgroundColor = .white
        stack.layer.cornerRadius = 30
        stack.spacing = 10
        
        [tfID, tfNickName, tfPassword, tfRePassword, tfName, tfBirth].forEach {
            stack.addArrangedSubview($0)
        }
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // keyboard scroll
        scrollView.keyboardDismissMode = .interactive
        
        setLayout()
        registerDelegate()
        
        navigationItem.title = "회원가입"
        navigationItem.leftBarButtonItem?.image = UIImage(systemName: "back")
        
        let tapGesture : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        //gesture의 이벤트가 끝나도 뒤에 이벤트를 View로 전달
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        // Register Keyboard notifications
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    // 화면에 터치 했을 때 키보드 사라짐
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
                return
        }
        
        let contentInset = UIEdgeInsets(
            top: 0.0,
            left: 0.0,
            bottom: keyboardFrame.size.height,
            right: 0.0)
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
    }
    
    @objc private func keyboardWillHide() {
        let contentInset = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
    }
    
    func setLayout() {
        self.view.addSubview(scrollView)
        
        scrollView.addSubview(stackView)
        view.addSubview(btnComplete)
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view).offset(140)
            $0.leading.equalTo(view).offset(24)
            $0.trailing.equalTo(view).offset(-24)
            $0.bottom.equalTo(btnComplete.snp_bottomMargin).offset(-10)
        }
        
        stackView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.centerX.equalTo(scrollView)
        }
        
        btnComplete.addTarget(self, action: #selector(joinButtonTouched), for: .touchUpInside)
        
        btnComplete.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(stackView.snp_bottomMargin).offset(20)
            $0.leading.trailing.equalTo(stackView)
            $0.height.equalTo(50)
            $0.bottom.equalTo(view).offset(-40)
        }
        
        tfID.snp.makeConstraints({ $0.height.equalTo(50) })
        tfNickName.snp.makeConstraints({ $0.height.equalTo(50) })
        tfPassword.snp.makeConstraints({ $0.height.equalTo(50) })
        tfRePassword.snp.makeConstraints({ $0.height.equalTo(50) })
        tfName.snp.makeConstraints({ $0.height.equalTo(50) })
        tfBirth.snp.makeConstraints({ $0.height.equalTo(50) })
    }
    
    func registerDelegate() {
        tfID.initTextFieldText(placeHolder: "ID", delegate: self)
        tfNickName.initTextFieldText(placeHolder: "Nickname", delegate: self)
        tfPassword.initTextFieldText(placeHolder: "Password", delegate: self)
        tfRePassword.initTextFieldText(placeHolder: "RePassword", delegate: self)
        tfName.initTextFieldText(placeHolder: "Name", delegate: self)
        tfBirth.initTextFieldText(placeHolder: "Birth", delegate: self)
    }
    
    @objc func joinButtonTouched() {
        UserDefaultManager.shared.saveToFile(with: UserInfoModel(id: tfID.tf.text ?? "", nickName: tfNickName.tf.text ?? "", password: tfPassword.tf.text ?? "", name: tfName.tf.text ?? "", birth: tfBirth.tf.text ?? ""))
        self.navigationController?.popViewController(animated: true)
    }
}

extension JoinMembershipViewController: CustomTextfieldViewDelegate {
    func customTextFieldValueChanged(_ textfield: UITextField) {
        
    }
    
    func customTextFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func customTextFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func errorStatus(isError: Bool, view: CustomTextfieldView) {
        
    }
    
    
}
