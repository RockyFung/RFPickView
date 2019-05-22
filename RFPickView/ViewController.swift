//
//  ViewController.swift
//  RFPickView
//
//  Created by 冯剑 on 2019/5/21.
//  Copyright © 2019 aomiao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let btn = UIButton(frame: CGRect(x: 50, y: 100, width: 100, height: 40))
        btn.backgroundColor = .gray
        btn.setTitle("click", for: .normal)
        view.addSubview(btn)
        btn.addTarget(self, action: #selector(clickAction), for: .touchUpInside)
        
        
    }

    @objc func clickAction(){
        let v = RFPickerView(firstArray: ["a","b","c"], secondArray: [["a1","a2"],["b1","b2"],["c1","c2","c3"]])
        v.selectedBlock = {(firstRow, secondRow) in
            print("\(firstRow) - \(secondRow)")
        }
        v.showView()
        
    }

}

