//
//  RFPickerView.swift
//  RFPickView
//
//  Created by 冯剑 on 2019/5/21.
//  Copyright © 2019 aomiao. All rights reserved.
//

import UIKit
public let kScreenH = UIScreen.main.bounds.size.height
public let kScreenW = UIScreen.main.bounds.size.width
func FitValue(_ value:CGFloat)->CGFloat{
    return (value/375)*kScreenW
}

typealias SelectedBlock = (_ firstRow:NSInteger,_ secondRow:NSInteger )->Void

class RFPickerView: UIView{
    var selectedBlock:SelectedBlock?
    var whiteBg:UIView!
    var columNum:NSInteger = 1
    var pickerView:UIPickerView!
    var firstArray:[String]!
    var secondArray:[[String]]?
    var firstRow = 0
    var secondRow = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    convenience init(firstArray:[String], secondArray:[[String]]=[[String]]()) {
        self.init(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH))
        backgroundColor = UIColor(white: 0.0, alpha: 0.3)
        
        
        self.firstArray = firstArray
        if secondArray.count > 0 {
            self.secondArray = secondArray
            columNum = 2
        }
        
        
        whiteBg = UIView(frame: CGRect(x: 0, y: kScreenH, width: kScreenW, height: 260))
        whiteBg.backgroundColor = .white
        addSubview(whiteBg)
        
        let toolBar = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 40))
        whiteBg.addSubview(toolBar)
        
        let cancelBtn = UIButton(frame: CGRect(x: FitValue(10), y: 0, width: FitValue(100), height: 40))
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.setTitleColor(.gray, for: .normal)
        toolBar.addSubview(cancelBtn)
        cancelBtn.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        
        let okBtn = UIButton(frame: CGRect(x: kScreenW-FitValue(110), y: 0, width: FitValue(100), height: 40))
        okBtn.setTitle("确定", for: .normal)
        okBtn.setTitleColor(.black, for: .normal)
        toolBar.addSubview(okBtn)
        okBtn.addTarget(self, action: #selector(okAction), for: .touchUpInside)
        
        
        pickerView = UIPickerView(frame: CGRect(x: 0, y: toolBar.maxY, width: kScreenW, height: whiteBg.height-toolBar.height))
        pickerView.delegate = self
        pickerView.dataSource = self
        whiteBg.addSubview(pickerView)
    }
    
    
    
    @objc func cancelAction(){
        hidenView()
    }
    
    @objc func okAction(){
        selectedBlock?(firstRow, secondRow)
        hidenView()
    }
    
    func showView(){
        UIApplication.shared.keyWindow?.addSubview(self)
        UIView.animate(withDuration: 0.3) {
            self.whiteBg.maxY = kScreenH
        }
    }
    
    func hidenView(){
        UIView.animate(withDuration: 0.3, animations: {
            self.whiteBg.y = kScreenH
        }) { (finifshed) in
            self.removeFromSuperview()
        }
    }
    
    
    
}
extension RFPickerView:UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return columNum
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        switch component {
        case 0:
            return firstArray.count
        case 1:
            return secondArray?[firstRow].count ?? 0
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: kScreenW/CGFloat(columNum), height: 30))
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .center

        switch component {
        case 0:
            label.text = firstArray[row]
        case 1:
            label.text = secondArray?[firstRow][row]
        default:
            break
        }
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            firstRow = row
            if columNum > 1 {
                pickerView.reloadComponent(1)
            }
        case 1:
            secondRow = row
        default:
            break
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
}
