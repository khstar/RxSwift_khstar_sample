//
//  DistinctUntilChangedViewController.swift
//  RxSwift_khstar_Samples
//
//  Created by khstar on 14/06/2019.
//  Copyright © 2019 khstar. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DistinctUntilChangedViewController: UIViewController {
    
    lazy var label:UILabel! = {
        let label = UILabel()
        label.text = "Picker에서 데이터를 선택하세요."
        label.tintColor = .clear
        label.textAlignment = .center
        return label
    }()
    
    lazy var pickerTextField:UITextField! = {
        let textField = UITextField()
        textField.text = "UIPicker 생성"
        textField.borderStyle = .roundedRect
        textField.tintColor = .clear

        return textField
    }()
    
    //PickerView의 ToolBar에 Done버튼 입니다.
    let doneToolBar = UIToolbar()
    let doneBarButton = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.done,
                                             target: nil,
                                             action: nil)
    
    let disposeBag = DisposeBag()
    
    let nameList:[String] = ["홍길동", "김철수", "안영희"]
    let pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.setupView()
        self.createPicker()
        self.setRx()
    }
    
    func setupView() {
        self.view.addSubview(label)
        self.view.addSubview(pickerTextField)
        
        label.autoPinEdge(toSuperviewEdge: .top, withInset: 74)
        label.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
        label.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
        label.autoSetDimension(.height, toSize: 30)
        
        pickerTextField.autoPinEdge(.top, to: .bottom, of: label, withOffset: 10)
        pickerTextField.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
        pickerTextField.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
        pickerTextField.autoSetDimension(.height, toSize: 30)
    }
    
    func setRx() {
        
        //DoneButton 눌려지는 경우 Action처리 입니다.
        doneBarButton.rx.tap.subscribe({
            _ in
            
            let i = self.pickerView.selectedRow(inComponent: 0)
            self.pickerTextField.text = self.nameList[i]
            self.pickerTextField.resignFirstResponder()
            
        }).disposed(by: disposeBag)
        
        _ = Observable.just(nameList).bind(to: pickerView.rx.itemTitles) {
            _, item in
            return "\(item)"
        }
        
        pickerTextField.rx.text
        .distinctUntilChanged()
        .subscribe{event in
            self.label.text = event.element!
        }
        .disposed(by: disposeBag)
        
    }
    
    func createPicker() {
        doneToolBar.sizeToFit()
        doneToolBar.items = [doneBarButton]
        
        pickerTextField.inputAccessoryView = doneToolBar
        pickerTextField.inputView = pickerView
    }

}
