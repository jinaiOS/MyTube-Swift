//
//  JoinMembershipViewController.swift
//  MyTube
//
//  Created by 김지은 on 2023/09/04.
//

import UIKit

enum ViewControllerType {
    case Join
    case Edit
}

class JoinMembershipViewController: UIViewController {
    
    lazy var backButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonPressed(_:)))
        button.tintColor = .black
        return button
    }()
    
    lazy var vID: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var tfID: CustomTextfieldView = {
        let textfield = CustomTextfieldView()
        return textfield
    }()
    
    lazy var vNickNam: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var tfNickName: CustomTextfieldView = {
        let textfield = CustomTextfieldView()
        return textfield
    }()
    
    lazy var vPassword: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var tfPassword: CustomTextfieldView = {
        let textfield = CustomTextfieldView()
        return textfield
    }()
    
    lazy var vRePassword: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var tfRePassword: CustomTextfieldView = {
        let textfield = CustomTextfieldView()
        return textfield
    }()
    
    lazy var vName: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var tfName: CustomTextfieldView = {
        let textfield = CustomTextfieldView()
        return textfield
    }()
    
    lazy var vBirth: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var tfBirth: CustomTextfieldView = {
        let textfield = CustomTextfieldView()
        return textfield
    }()
    
    lazy var btnComplete: UIButton = {
        let button = UIButton()
        button.setTitle("완료", for: .normal)
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

        vID.snp.makeConstraints { $0.height.equalTo(60) }
        
        [vID, vNickNam, vPassword, vRePassword, vName, vBirth].forEach {
            stack.addArrangedSubview($0)
        }
        return stack
    }()
    
    var type : ViewControllerType = .Join
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaultManager.sharedInstance.loadUsers()
        // keyboard scroll
        scrollView.keyboardDismissMode = .interactive

        setLayout()
        registerDelegate()
        if type == .Join {
            navigationItem.title = "회원가입"
        } else {
            navigationItem.title = "회원정보 수정"
        }
        navigationItem.leftBarButtonItem = backButton
        
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
    
    @objc private func backButtonPressed(_ sender: Any) {
           self.navigationController?.popViewController(animated: true)
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
        setScrollViewLayout()
        setStackViewLayout()
        setCompleteButtonLayout()
        setIDTextfield()
        setNickNameTextfield()
        setPasswordTextfield()
        setRePasswordTextfield()
        setNameTextfield()
        setBirthTextfield()
    }
    
    func setScrollViewLayout() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        view.addSubview(btnComplete)
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view).offset(100)
            $0.leading.equalTo(view).offset(24)
            $0.trailing.equalTo(view).offset(-24)
            $0.bottom.equalTo(btnComplete.snp_bottomMargin).offset(-10)
        }
    }
    
    func setStackViewLayout() {
        stackView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.centerX.equalTo(scrollView)
        }
    }
    
    func setCompleteButtonLayout() {
        btnComplete.addTarget(self, action: #selector(joinButtonTouched), for: .touchUpInside)
        
        btnComplete.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(stackView.snp_bottomMargin).offset(20)
            $0.leading.trailing.equalTo(stackView)
            $0.height.equalTo(50)
            $0.bottom.equalTo(view).offset(-40)
        }
    }
    
    func setIDTextfield() {
        vID.addSubview(tfID)
        
        tfID.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.leading.trailing.equalTo(0)
            $0.top.bottom.equalTo(10)
        }
    }
    
    func setNickNameTextfield() {
        vNickNam.addSubview(tfNickName)
        
        tfNickName.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.leading.trailing.equalTo(0)
            $0.top.bottom.equalTo(10)
        }
    }
    
    func setPasswordTextfield() {
        vPassword.addSubview(tfPassword)
        
        tfPassword.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.leading.trailing.equalTo(0)
            $0.top.bottom.equalTo(10)
        }
    }
    
    func setRePasswordTextfield() {
        vRePassword.addSubview(tfRePassword)
        
        tfRePassword.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.leading.trailing.equalTo(0)
            $0.top.bottom.equalTo(10)
        }
    }
    
    func setNameTextfield() {
        vName.addSubview(tfName)
        
        tfName.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.leading.trailing.equalTo(0)
            $0.top.bottom.equalTo(10)
        }
    }
    
    func setBirthTextfield() {
        vBirth.addSubview(tfBirth)
        setupDatePicker()
        tfBirth.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.leading.trailing.equalTo(0)
            $0.top.bottom.equalTo(10)
        }
    }
    
    private func setupDatePicker() {
        // UIDatePicker 객체 생성을 해줍니다.
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.addTarget(self, action: #selector(dateChange), for: .valueChanged)
        tfBirth.tf.inputView = datePicker
    }
        
    // 값이 변할 때 마다 동작
    @objc func dateChange(_ sender: UIDatePicker) {
        // 값이 변하면 UIDatePicker에서 날자를 받아와 형식을 변형해서 textField에 넣어줍니다.
        tfBirth.tf.text = dateFormat(date: sender.date)
    }
    
    // 텍스트 필드에 들어갈 텍스트를 DateFormatter 변환
    private func dateFormat(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy / MM / dd"
        
        return formatter.string(from: date)
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
        if tfID.tf.text == "" {
            tfID.isError = true
        } else if tfNickName.tf.text == "" {
            tfNickName.isError = true
        } else if tfPassword.tf.text == "" {
            tfPassword.isError = true
        } else if tfRePassword.tf.text == "" || tfPassword.tf.text != tfRePassword.tf.text {
            tfRePassword.isError = true
        } else if tfName.tf.text == "" {
            tfName.isError = true
        } else if tfBirth.tf.text == "" {
            tfBirth.isError = true
        } else {
            UserDefaultManager.sharedInstance.userList.append(UserInfoModel(id: tfID.tf.text ?? "", nickName: tfNickName.tf.text ?? "", password: tfPassword.tf.text ?? "", name: tfName.tf.text ?? "", birth: tfBirth.tf.text ?? ""))
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension JoinMembershipViewController: CustomTextfieldViewDelegate {
    func customTextFieldValueChanged(_ textfield: UITextField) {
        
    }
    
    func customTextFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case tfID.tf:
            tfNickName.tf.becomeFirstResponder()
        case tfNickName.tf:
            tfPassword.tf.becomeFirstResponder()
        case tfPassword.tf:
            tfRePassword.tf.becomeFirstResponder()
        case tfRePassword.tf:
            tfName.tf.becomeFirstResponder()
        case tfName.tf:
            tfBirth.tf.becomeFirstResponder()
        case tfBirth.tf:
            tfBirth.tf.resignFirstResponder()
        default:
            break
        }
        return true
    }
    
    func customTextFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func customTextFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func errorStatus(isError: Bool, view: CustomTextfieldView) {
        
    }
    
    
}
