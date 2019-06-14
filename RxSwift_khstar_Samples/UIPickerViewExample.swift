//
//  UIPickerViewExample.swift
//  RxSwift_khstar_Samples
//
//  Created by khstar on 14/06/2019.
//  Copyright © 2019 khstar. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import PureLayout

class UIPickerViewExample:UIViewController {
    
    lazy var pickerTextField:UITextField! = {
        let txtField = UITextField()
        txtField.text = "선택하기"
        txtField.borderStyle = .roundedRect
        txtField.tintColor = .clear
        
        return txtField
    }()
    
    lazy var numberBtn:UIButton! = {
        let btn = UIButton()
        btn.setTitle("1,2,3,4,5 사용", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        return btn
    }()
    
    lazy var stringBtn:UIButton! = {
        let btn = UIButton()
        btn.setTitle("가,나,다,라,마 사용", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        return btn
    }()
    
    let pickerView = UIPickerView()
    //Picker의 데이터 입니다.
    var pickerData:[String] = ["1", "2", "3", "4", "5"]
    
    //PickerView의 ToolBar에 Done버튼 입니다.
    let doneToolBar = UIToolbar()
    let doneBarButton = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.done,
                                             target: nil,
                                             action: nil)
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        setRx()
    }
    
    func setupView() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(pickerTextField)
        self.view.addSubview(numberBtn)
        self.view.addSubview(stringBtn)
        
        pickerTextField.autoPinEdge(toSuperviewEdge: .top, withInset: 74)
        pickerTextField.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
        pickerTextField.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
        pickerTextField.autoSetDimension(.height, toSize: 30)
        
        numberBtn.autoPinEdge(.top, to: .bottom, of: pickerTextField, withOffset: 10)
        numberBtn.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
        numberBtn.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
        numberBtn.autoSetDimension(.height, toSize: 30)
        
        stringBtn.autoPinEdge(.top, to: .bottom, of: numberBtn, withOffset: 10)
        stringBtn.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
        stringBtn.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
        stringBtn.autoSetDimension(.height, toSize: 30)
    }
    
    func setRx() {
        
        //DoneButton 눌려지는 경우 Action처리 입니다.
        doneBarButton.rx.tap.subscribe({
            _ in
            
            let i = self.pickerView.selectedRow(inComponent: 0)
            self.pickerTextField.text = self.pickerData[i]
            self.pickerTextField.resignFirstResponder()
            
        }).disposed(by: disposeBag)

        numberBtn.rx.tap.bind {
            [weak self] _ in
            self?.changeNumberBtn()
        }.disposed(by: disposeBag)
        
        stringBtn.rx.tap.bind{
            [weak self] _ in
            self?.changeStringBtn()
        }.disposed(by: disposeBag)
        
        //여기서 pickerData를 Observable해서 PickerView에 Binding합니다.
        setPickerBind()
        createPicker()
        
    }
    
    func changeNumberBtn() {
        pickerData = ["1", "2", "3", "4", "5",]
        setPickerBind()
    }
    
    func changeStringBtn() {
        pickerData = ["가", "나", "다", "라", "마",]
        setPickerBind()
    }
    
    func setPickerBind() {
        
        //pickerView의 delegate와 datasource를 nil 해주지 않으면 아래의 에러가 발생되면서 Crash됨
        //Assertion failed:
        //This is a feature to warn you that there is already a delegate (or data source)
        //set somewhere previously.
        
        pickerView.delegate = nil
        pickerView.dataSource = nil
        
        _ = Observable.just(pickerData).bind(to: pickerView.rx.itemTitles) {
            _, item in
            return "\(item)"
        }
    }
    
    func createPicker() {
        doneToolBar.sizeToFit()
        doneToolBar.items = [doneBarButton]
        
        pickerTextField.inputAccessoryView = doneToolBar
        pickerTextField.inputView = pickerView
    }
    
}

