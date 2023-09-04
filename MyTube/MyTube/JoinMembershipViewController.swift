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
        textfield.placeholder = "아이디를 입력해 주세요"
        return textfield
    }()
    
    lazy var tfNickName: CustomTextfieldView = {
        let textfield = CustomTextfieldView()
        textfield.placeholder = "아이디를 입력해 주세요"
        return textfield
    }()
    
    lazy var tfPassword: CustomTextfieldView = {
        let textfield = CustomTextfieldView()
        textfield.placeholder = "아이디를 입력해 주세요"
        return textfield
    }()
    
    lazy var tfRePassword: CustomTextfieldView = {
        let textfield = CustomTextfieldView()
        textfield.placeholder = "아이디를 입력해 주세요"
        return textfield
    }()
    
    lazy var tfName: CustomTextfieldView = {
        let textfield = CustomTextfieldView()
        textfield.placeholder = "아이디를 입력해 주세요"
        return textfield
    }()
    
    lazy var tfBirth: CustomTextfieldView = {
        let textfield = CustomTextfieldView()
        textfield.placeholder = "아이디를 입력해 주세요"
        return textfield
    }()
    
    lazy var btnComplete: UIButton = {
       let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.backgroundColor = .red
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
        
        [tfID, tfNickName, tfPassword, tfRePassword, tfName, tfBirth].forEach {
            stack.addArrangedSubview($0)
        }
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLayout()
        
        navigationItem.title = "회원가입"
        navigationItem.leftBarButtonItem?.image = UIImage(systemName: "back")
    }

    func setLayout() {
        view.addSubview(stackView)
        view.addSubview(btnComplete)
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(view).offset(140)
            $0.leading.equalTo(view).offset(24)
            $0.trailing.equalTo(view).offset(-24)
        }
        
        btnComplete.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(stackView.snp_bottomMargin).offset(20)
            $0.leading.trailing.equalTo(stackView)
            $0.height.equalTo(50)
            $0.bottom.equalTo(view).offset(-40)
        }
    }
}
