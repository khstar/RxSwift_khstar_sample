//
//  ViewController.swift
//  RxSwift_khstar_Samples
//
//  Created by khstar on 14/06/2019.
//  Copyright © 2019 khstar. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import PureLayout

class ViewController: UIViewController {

    var listData:[String] = ["UIPickerView", "distinctUntilChanged"]
    
    lazy var sampleListViewCtrl: UITableView! = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let tableView = UITableView(frame: CGRect.zero, style: UITableView.Style.plain)
        tableView.register(SampleViewCell.self, forCellReuseIdentifier: "sampleviewcell")
        tableView.separatorStyle = .none //.none // separatorStyle
        tableView.backgroundColor = .white
        tableView.bounces = false
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
    }
    
    func setupView(){
        self.view.addSubview(sampleListViewCtrl)
        
        sampleListViewCtrl.autoPinEdge(toSuperviewEdge: .top, withInset: 20)
        sampleListViewCtrl.autoPinEdge(toSuperviewEdge: .left)
        sampleListViewCtrl.autoPinEdge(toSuperviewEdge: .right)
        sampleListViewCtrl.autoPinEdge(toSuperviewEdge: .bottom)
        
    }
    
    func showRxSwiftSample(idx:Int) {
        if idx == 0 {
            let pickerView = UIPickerViewExample()
            self.navigationController?.pushViewController(pickerView, animated: true)
        } else if idx == 1 {
            let distinct = DistinctUntilChangedViewController()
            self.navigationController?.pushViewController(distinct, animated: true)
        }
    }
}

extension ViewController:UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "sampleviewcell", for: indexPath) as? SampleViewCell else {
            return UITableViewCell()
        }
        
        let row = indexPath.row
        
        cell.name.text = listData[row]
        cell.selectedBackgroundView?.backgroundColor = .red
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showRxSwiftSample(idx: indexPath.row)
    }
}


class SampleViewCell:UITableViewCell {
    
    lazy var name : UILabel! = {
        let label = UILabel()
        return label
    }()
    
    lazy var backColor:UIView! = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    lazy var underLine:UIView! = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.selectedBackgroundView = backColor
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        addSubview(name)
        addSubview(underLine)
        
        name.autoAlignAxis(toSuperviewAxis: .horizontal)
        name.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
        name.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
        
        underLine.autoPinEdge(toSuperviewEdge: .left)
        underLine.autoPinEdge(toSuperviewEdge: .right)
        underLine.autoPinEdge(toSuperviewEdge: .bottom)
        underLine.autoSetDimension(.height, toSize: 0.5)
        
    }
}
