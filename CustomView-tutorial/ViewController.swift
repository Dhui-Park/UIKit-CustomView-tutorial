//
//  ViewController.swift
//  CustomView-tutorial
//
//  Created by dhui on 2023/08/29.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var secondInputView: InputView!
    
    override func loadView() {
        super.loadView()
        print(#fileID, #function, #line, "- ")
        
        let thirdInputView = InputView(title: "$400,000",
                                       placeholder: "annually",
                                       onBtnAClicked: self.handleBtnAClicked,
                                       onBtnBClicked: self.handleBtnBClicked(userInput:)
        )
        
        self.view.addSubview(thirdInputView)
        thirdInputView.snp.makeConstraints{
            $0.top.equalTo(secondInputView.snp.bottom).offset(10)
            $0.leading.equalTo(secondInputView)
            $0.trailing.equalTo(secondInputView)
            $0.height.equalTo(secondInputView)
        }
        
        let fourthInputView = CodeInputView(title: "$800,000",
                                            placeholder: "biennially",
                                            onBtnAClicked: self.handleBtnAClicked,
                                            onBtnBClicked: self.handleBtnBClicked(userInput:),
                                            onUserInputChanged: self.handleInputFromCodeInputView(userInput:)
        )
        
        self.view.addSubview(fourthInputView)
        fourthInputView.snp.makeConstraints{
            $0.top.equalTo(thirdInputView.snp.bottom).offset(10)
            $0.leading.equalTo(thirdInputView)
            $0.trailing.equalTo(thirdInputView)
            $0.height.greaterThanOrEqualTo(thirdInputView)
        }
        
    } // loadView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#fileID, #function, #line, "- ")
        
        secondInputView.onBtnAClicked = {
            print("ViewController - 버튼 A가 선택되었다.")
        }
        secondInputView.onBtnBClicked = {
            print("ViewController - 버튼 B가 선택되었다. / userInput: \($0)")
        }
        
        secondInputView.resetAction(target: self,
                                    aBtnAction: #selector(onBtnAClikced(_:)),
                                    bBtnAction: #selector(onBtnBClikced(_:)),
                                    inputChangeAction: #selector(onInputChanged(_:)))
    }
    
    @objc func onInputChanged(_ sender: UITextField) {
        print(#fileID, #function, #line, "- input: \(sender.text) ")
    }
    
    @objc func onBtnAClikced(_ sender: UIButton) {
        print(#fileID, #function, #line, "- ")
    }
    
    @objc func onBtnBClikced(_ sender: UIButton) {
        print(#fileID, #function, #line, "- ")
    }
    
    fileprivate func handleBtnAClicked() {
        print(#fileID, #function, #line, "- ")
    }
    
    fileprivate func handleBtnBClicked(userInput: String) {
        print(#fileID, #function, #line, "- userInput: \(userInput)")
    }
    
    fileprivate func handleInputFromCodeInputView(userInput: String) {
        print(#fileID, #function, #line, "- userInput: \(userInput)")
    }

}

