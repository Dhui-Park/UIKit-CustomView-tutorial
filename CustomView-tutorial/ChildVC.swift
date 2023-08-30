//
//  ChildVC.swift
//  CustomView-tutorial
//
//  Created by dhui on 2023/08/30.
//

import Foundation
import UIKit

class ChildVC: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    
    var bgColor: UIColor = .systemYellow {
        didSet {
            DispatchQueue.main.async {
                self.view.backgroundColor = self.bgColor
            }
        }
    }
    
    // 인터페이스 빌더에서 속성넣기
    @IBInspectable
    var titleText: String = "" {
        didSet {
            DispatchQueue.main.async {
                self.titleLabel.text = self.titleText
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
    var onUserInputChanged: ((String) -> Void)? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#fileID, #function, #line, "- ")
        
        inputTextField.addTarget(self, action: #selector(onUserInputChanged(_:)), for: .editingChanged)
    }
    
    @objc fileprivate func onUserInputChanged(_ sender: UITextField) {
        print(#fileID, #function, #line, "- sender.text: \(sender.text ?? "")")
        self.onUserInputChanged?(sender.text ?? "")
        
    }
    
    @IBAction func onBtnClicked(_ sender: UIButton) {
        print(#fileID, #function, #line, "- ")
        switch sender.tag {
        case 1:
            print("button A clicked!")
            onBtnAClicked?()
        case 2:
            print("button B clicked!")
            guard let input = inputTextField.text else { return }
            onBtnBClicked?(input)
        default:
            break
        }
    }
}
