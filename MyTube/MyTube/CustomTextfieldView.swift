//
//  CustomTextfieldView.swift
//  MyTube
//
//  Created by 김지은 on 2023/09/04.
//

import UIKit
import SnapKit

protocol CustomTextfieldViewDelegate : AnyObject {
    
    /// textfield should return
    func customTextFieldShouldReturn(_ textField: UITextField) -> Bool
    
    /// textfield의 값이 바뀔때
    func customTextFieldValueChanged(_ textfield: UITextField)
    
    /// textfield의 값입력 후
    func customTextFieldDidEndEditing(_ textField: UITextField)
    
    /// textfield의 입력 시작
    func customTextFieldDidBeginEditing(_ textField: UITextField)
    
    /// textfield의 입력 허용 validationCheck
    func customTextField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    
    /// 에러인 상황
    func errorStatus(isError: Bool, view: CustomTextfieldView)
}

extension CustomTextfieldViewDelegate {
    /// textfield should return
    func customTextFieldShouldReturn(_ textField: UITextField) -> Bool {return true}
    /// textfield의 입력 허용 validationCheck
    func customTextField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {return true}
}

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
    private var buttonWidthConstraint: Constraint?
    private var buttonTopConstraint: Constraint?
    weak var tfDelegate : CustomTextfieldViewDelegate?
    
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
        setTextField()
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
    
    func setTextField(){
        tf.snp.makeConstraints {
            $0.edges.equalTo(vContainer)
        }
    }
    
    func setTitleButton() {
        //버튼 패딩
        btnTitle.isHidden = true
        btnTitle.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        btnTitle.tintColor = .white
        btnTitle.isUserInteractionEnabled = false
        tf.addLeftPadding()
        tf.delegate = self
        self.tf.addTarget(self, action: #selector(textfieldValueChanged(_:)), for: .editingChanged)
        vBorder.layer.borderWidth = 1
        vBorder.layer.borderColor = UIColor.gray.cgColor
        btnTitle.setTitleColor(.gray, for: .normal)
        btnTitle.contentHorizontalAlignment = .left
        
        vBorder.addSubview(btnTitle)
        
        btnTitle.snp.makeConstraints {
            $0.leading.equalTo(self).offset(17)
            $0.centerY.equalTo(self)
            $0.bottom.equalTo(self)
            $0.top.equalTo(self)
            $0.trailing.equalTo(self)
            $0.height.equalTo(15)
            buttonTopConstraint = $0.top.equalTo(self).constraint
            buttonWidthConstraint = $0.bottom.equalTo(self).constraint
        }
    }
    
    @objc func textfieldValueChanged(_ textField: UITextField) {
        tfDelegate?.customTextFieldValueChanged(textField)
    }
    
    func initTextFieldText(placeHolder : String, delegate: CustomTextfieldViewDelegate) {
        btnTitle.setTitle(placeHolder, for: .normal)
        tf.placeholder = placeHolder
        tfDelegate = delegate
    }
    
    func textfieldEditing(isEditing : Bool)  {
        if isEditing {
            vBorder.layer.borderWidth = 2
            vBorder.layer.borderColor = UIColor.black.cgColor
            btnTitle.setTitleColor(.black, for: .normal)
        } else {
            vBorder.layer.borderWidth = 1
            vBorder.layer.borderColor = UIColor.gray.cgColor
            btnTitle.setTitleColor(.gray, for: .normal)
        }
    }
    
    func placeHolderAnimation(isEditing: Bool) {
        if isEditing {
            btnTitle.isHidden = false
            self.buttonTopConstraint?.update(offset: 0)
            self.buttonWidthConstraint?.update(offset: 0)
            tf.placeholder = ""
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) { [weak self] in
                guard let `self` = self else {return}
                self.buttonTopConstraint?.update(offset: -(self.frame.height / 2))
                self.buttonWidthConstraint?.update(offset: -(self.frame.height / 2))
                self.layoutIfNeeded()
            } completion: { (finished) in
                
            }
        } else {
            self.buttonWidthConstraint?.update(offset: -(self.frame.height / 2))
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) { [weak self] in
                guard let `self` = self else {return}
                self.buttonTopConstraint?.update(offset: 0)
                self.buttonWidthConstraint?.update(offset: 0)
                self.btnTitle.alpha = 0
                self.layoutIfNeeded()
            } completion: {[weak self] (finished) in
                guard let `self` = self else {return}
                self.tf.placeholder = self.placeholder
                self.btnTitle.isHidden = true
                self.btnTitle.alpha = 1
            }
        }
    }
}
extension CustomTextfieldView : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        tfDelegate?.customTextFieldDidBeginEditing(textField)
        //        isError = false
        textfieldEditing(isEditing: true)
        
        if textField.text?.isEmpty ?? true {
            placeHolderAnimation(isEditing: true)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textfieldEditing(isEditing: false)
        if textField.text?.isEmpty ?? true {
            placeHolderAnimation(isEditing: false)
        }
        tfDelegate?.customTextFieldDidEndEditing(textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return tfDelegate?.customTextFieldShouldReturn(self.tf) ?? true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return tfDelegate?.customTextField(self.tf, shouldChangeCharactersIn: range, replacementString: string) ?? true
        //        guard let text = textField.text else {return false}
        //        let maxLength = 20
        //               // 최대 글자수 이상을 입력한 이후에는 중간에 다른 글자를 추가할 수 없게끔 작동(25자리)
        //               if text.count >= maxLength && range.length == 0 && range.location >= maxLength {
        //                   return false
        //               }
        //
        //               return true
    }
}
extension UITextField {
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}
