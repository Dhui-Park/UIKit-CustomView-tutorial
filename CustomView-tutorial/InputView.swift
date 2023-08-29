//
//  InputView.swift
//  CustomView-tutorial
//
//  Created by dhui on 2023/08/29.
//

import Foundation
import UIKit
import SnapKit
import Then

@IBDesignable
class InputView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var inputTextField: UITextField!
    
    @IBOutlet weak var buttonA: UIButton!
    
    @IBOutlet weak var buttonB: UIButton!
    
    // 인터페이스 빌더에서 속성넣기
    @IBInspectable
    var title: String = "" {
        didSet {
            DispatchQueue.main.async {
                self.titleLabel.text = self.title
            }
        }
    }
    
    @IBInspectable
    var placeholder: String = "" {
        didSet {
            DispatchQueue.main.async {
                self.inputTextField.placeholder = self.placeholder.isEmpty ? "글자를 입력해주세요" : self.placeholder
            }
        }
    }
    
    var onBtnAClicked: (() -> Void)? = nil
    var onBtnBClicked: ((String) -> Void)? = nil
    
    // nib파일을 UIView로 가져오기에 viewDidLoad()가 아니라 awakeFromNib()
    override func awakeFromNib() {
        super.awakeFromNib()
        print(#fileID, #function, #line, "- ")
        applyNib()
        applyAction()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print(#fileID, #function, #line, "- ")
        applyNib()
        applyAction()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print(#fileID, #function, #line, "- ")
    }
    
    convenience init(title: String = "",
                     placeholder: String = "",
                     onBtnAClicked: (() -> Void)? = nil,
                     onBtnBClicked: ((String) -> Void)? = nil
    ) {
        self.init(frame: .zero)
        self.titleLabel.text = title
        self.inputTextField.placeholder = placeholder
        self.onBtnAClicked = onBtnAClicked
        self.onBtnBClicked = onBtnBClicked
    }
    
    fileprivate func applyNib() {
        print(#fileID, #function, #line, "- ")
        
        let nibName = String(describing: Self.self) // 나의 타입을 가져와라!
        let nib = Bundle.main.loadNibNamed(nibName, owner: self)
        guard let view = nib?.first as? UIView else { return }
        
        addSubview(view)
        view.snp.makeConstraints{
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
    
    func resetAction(target: Any?,
                     aBtnAction: Selector,
                     bBtnAction: Selector,
                     inputChangeAction: Selector
    ) {
        print(#fileID, #function, #line, "- ")
        // 이전 actions 지우기
        self.buttonA.removeTarget(self, action: #selector(onBtnAClikced(_:)), for: .touchUpInside)
        self.buttonB.removeTarget(self, action: #selector(onBtnBClikced(_:)), for: .touchUpInside)
        self.inputTextField.removeTarget(self, action: #selector(onInputChanged(_:)), for: .editingChanged)
        
        self.buttonA.addTarget(target, action: aBtnAction, for: .touchUpInside)
        self.buttonB.addTarget(target, action: bBtnAction, for: .touchUpInside)
        self.inputTextField.addTarget(target, action: inputChangeAction, for: .editingChanged)
    }
    
    @objc func onInputChanged(_ sender: UITextField) {
        print(#fileID, #function, #line, "- input: \(sender.text) ")
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
