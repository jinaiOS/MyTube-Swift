//
//  CustomTextfieldView.swift
//  MyTube
//
//  Created by 김지은 on 2023/09/04.
//

import UIKit

class CustomTextfieldView: UIView {
    
    lazy var vContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var vBorder: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var tf: UITextField = {
        let textfield = UITextField()
        return textfield
    }()
    
    lazy var btnTitle: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.backgroundColor = .white
        stack.layer.cornerRadius = 30
        
        [tf, btnTitle].forEach {
            stack.addArrangedSubview($0)
        }
        return stack
    }()
        
    var placeholder : String = "hi"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setLayout()
        
        
    }
    
    private func setLayout() {
        setContainerView()
        setBorderView()
        setTitleButton()
    }
    
    func setContainerView() {
        self.addSubview(vContainer)
        
        vContainer.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.edges.equalTo(self)
        }
        
        vContainer.addSubview(vBorder)
        vContainer.addSubview(tf)
    }
    
    func setBorderView() {
        vBorder.snp.makeConstraints {
            $0.edges.equalTo(vContainer)
        }
        
        vBorder.layer.cornerRadius = 10
        vBorder.layer.borderColor = UIColor.black.cgColor
        vBorder.layer.borderWidth = 1
        
    }
    
    func setTitleButton() {
        btnTitle.addTarget(self, action: #selector(editButtonTouched), for: .touchUpInside)
        btnTitle.setTitle(placeholder, for: .normal)
        btnTitle.setTitleColor(.black, for: .normal)
        btnTitle.titleLabel?.font = UIFont.systemFont(ofSize: 12.0, weight: .bold)
        btnTitle.backgroundColor = .clear
        btnTitle.contentHorizontalAlignment = .left
        
        vBorder.addSubview(btnTitle)
        
        btnTitle.snp.makeConstraints {
            $0.leading.equalTo(self).offset(17)
            $0.centerY.equalTo(self)
            $0.bottom.equalTo(self)
            $0.height.equalTo(15)
        }
    }
    
    @objc func editButtonTouched(sender: UIButton) {
        sender.isSelected ? textFieldIsEditing(isEditing: true) : textFieldIsEditing(isEditing: false)
    }
    
    func textFieldIsEditing(isEditing: Bool) {
        if isEditing {
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) { [weak self] in
                guard let `self` = self else {return}
                btnTitle.snp.updateConstraints {
                    $0.bottom.equalTo(self.vBorder).offset(0)
                }
                btnTitle.layoutIfNeeded()
            } completion: {[weak self] (finished) in
                guard let `self` = self else {return}
                btnTitle.snp.updateConstraints {
                    $0.bottom.equalTo(self.vBorder).offset(20)
                }
                btnTitle.layoutIfNeeded()
            }
        } else {
            btnTitle.snp.updateConstraints {
                $0.bottom.equalTo(self).offset(20)
            }
            btnTitle.layoutIfNeeded()
        }
        
    }
}
