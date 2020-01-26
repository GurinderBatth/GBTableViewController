//
//  Controller2.swift
//  GBTableView
//
//  Created by IOS on 26/01/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import UIKit

class Controller2: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var model = [GBModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupData()
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.model.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model[section].details.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Controller2Cell") as! Controller2Cell
        cell.data = self.model[indexPath.section].details[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("GBHFView", owner: self, options: nil)?[0] as? GBHFView
        headerView?.headerFooterData = self.model[section]
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let controller = self.storyboard?.instantiateViewController(identifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

class Controller2Cell: UITableViewCell{
    @IBOutlet weak var labelName: UILabel!
    var data: GBModelInnder?{
        didSet{
            self.labelName.text = data?.name
        }
    }
}

class Controller2CellView: UIView{
    @IBOutlet weak var labelName: UILabel!
    var headerFooterData: GBModel?{
        didSet{
            labelName.text = headerFooterData?.name
        }
    }
}
