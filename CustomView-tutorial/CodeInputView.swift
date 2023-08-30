//
//  CodeInputView.swift
//  CustomView-tutorial
//
//  Created by dhui on 2023/08/30.
//

import Foundation
import UIKit

class CodeInputView: UIView {
    
    var titleLabel: UILabel = UILabel().then{
        $0.text = "타이틀 라벨"
    }
    var inputTextField: UITextField = UITextField().then{
        $0.placeholder = "내용을 입력해주세요."
        $0.borderStyle = .roundedRect
    }
    var buttonA: UIButton = UIButton(type: .system).then{
        $0.configuration = .borderedProminent()
        $0.setTitle("button A", for: .normal)
    }
    var buttonB: UIButton = UIButton(type: .system).then{
        $0.configuration = .borderedProminent()
        $0.setTitle("button B", for: .normal)
    }
    
    lazy var horizontalBtnStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [buttonA, buttonB])
        stackView.axis = .horizontal
        stackView.spacing = 30
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    lazy var verticalContainerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, inputTextField, horizontalBtnStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        stackView.backgroundColor = .systemMint
        return stackView
    }()
    
    // code에서 속성넣기
    var title: String = "" {
        didSet {
            DispatchQueue.main.async {
                self.titleLabel.text = self.title
            }
        }
    }
    
    var placeholder: String = "" {
        didSet {
            DispatchQueue.main.async {
                self.inputTextField.placeholder = self.placeholder.isEmpty ? "글자를 입력해주세요" : self.placeholder
            }
        }
    }
    
    var onBtnAClicked: (() -> Void)? = nil
    var onBtnBClicked: ((String) -> Void)? = nil
    var onUserInputChanged: ((String) -> Void)? = nil
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print(#fileID, #function, #line, "- ")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print(#fileID, #function, #line, "- ")
        self.configureUI()
    }
    
    convenience init(title: String = "",
                     placeholder: String = "",
                     onBtnAClicked: (() -> Void)? = nil,
                     onBtnBClicked: ((String) -> Void)? = nil,
                     onUserInputChanged: ((String) -> Void)? = nil
    ) {
        self.init(frame: .zero)
        self.titleLabel.text = title
        self.inputTextField.placeholder = placeholder
        self.onBtnAClicked = onBtnAClicked
        self.onBtnBClicked = onBtnBClicked
        self.onUserInputChanged = onUserInputChanged
        self.applyAction()
    }
    
    
    fileprivate func configureUI() {
        print(#fileID, #function, #line, "- ")
        self.addSubview(verticalContainerStackView)
        verticalContainerStackView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
    
    fileprivate func applyAction() {
        print(#fileID, #function, #line, "- ")
        self.buttonA.addTarget(self, action: #selector(onBtnAClikced(_:)), for: .touchUpInside)
        self.buttonB.addTarget(self, action: #selector(onBtnBClikced(_:)), for: .touchUpInside)
        self.inputTextField.addTarget(self, action: #selector(onInputChanged(_:)), for: .editingChanged)
    }
    
    @objc func onInputChanged(_ sender: UITextField) {
        print(#fileID, #function, #line, "- input: \(sender.text) ")
        guard let userInput = self.inputTextField.text else { return }
        onUserInputChanged?(userInput)
    }
    
    @objc func onBtnAClikced(_ sender: UIButton) {
        print(#fileID, #function, #line, "- ")
        onBtnAClicked?()
    }
    
    @objc func onBtnBClikced(_ sender: UIButton) {
        print(#fileID, #function, #line, "- ")
        
        guard let userInput = self.inputTextField.text else { return }
        onBtnBClicked?(userInput)
    }
}


#if DEBUG
import SwiftUI

struct CodeInputViewRepresentable: UIViewRepresentable {
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    func makeUIView(context: Context) -> some UIView {
        CodeInputView()
    }
}

struct CodeInputVIewRepresentable_Previews: PreviewProvider {
    static var previews: some View {
        CodeInputViewRepresentable()
            .frame(maxWidth: .infinity)
            .frame(height: 200)
            .background(Color.yellow)
    }
}

#endif
