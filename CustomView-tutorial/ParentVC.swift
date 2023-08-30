//
//  ParentVC.swift
//  CustomView-tutorial
//
//  Created by dhui on 2023/08/30.
//

import Foundation
import UIKit

class ParentVC: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#fileID, #function, #line, "- ")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        print(#fileID, #function, #line, "- segue")
        if let childVC = segue.destination as? ChildVC {
            childVC.titleText = "맨유 우승"
            childVC.bgColor = .systemRed
            childVC.onUserInputChanged = { [weak self] input in
                print(#fileID, #function, #line, "- input: \(input)")
            }
            childVC.onBtnAClicked = { [weak self] in
                print(#fileID, #function, #line, "- 버튼 A가 클릭됨!")
            }
            childVC.onBtnBClicked = { [weak self] input in
                print(#fileID, #function, #line, "- 버튼 B가 클릭됨! input: \(input)")
            }
        }
    }
}
