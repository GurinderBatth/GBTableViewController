//
//  ViewController.swift
//  GBTableView
//
//  Created by IOS on 26/01/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import UIKit

class ViewController: GBTableViewController<GBCell, GBModelInnder, GBHFView, GBModel> {
    
    var model = [GBModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupData()
        
        self.sections = { [weak self] tableView in
            return (self?.model.count ?? 1)
        }
        
        self.rows = { [weak self] (tableView, section, row) in
            return (self?.model[section].details.count ?? 0, self?.model[section].details[row ?? 0], self?.model[section])
        }
        
        self.headerHeight = { (tableView, section) in
            return 50.0
        }
        
        self.selectedRow = { [weak self] (newTableView, indexPath) in
            self?.tableView.deselectRow(at: indexPath, animated: true)
            let controller = self?.storyboard?.instantiateViewController(identifier: "Controller2") as! Controller2
            self?.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func setupData(){
        for i in 1...100{
            var localModel = GBModel(name: "\(i)")
            var localArray = [GBModelInnder]()
            for j in 10...20{
                localArray.append(GBModelInnder(name: "\(j)"))
            }
            localModel.details = localArray
            model.append(localModel)
        }
    }
}

class GBCell: GBTableViewCell<GBModelInnder>{
    @IBOutlet weak var labelName: UILabel!
    override var data: GBModelInnder?{
        didSet{
            self.labelName.text = data?.name
        }
    }
}

class GBHFView: GBHeaderFooterView<GBModel>{
    @IBOutlet weak var labelName: UILabel!
    override var headerFooterData: GBModel?{
        didSet{
            labelName.text = headerFooterData?.name
        }
    }
}
