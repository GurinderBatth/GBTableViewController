//
//  GBTableViewController.swift
//  GBTableView
//
//  Created by IOS on 26/01/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import UIKit

class GBTableViewController<T: GBTableViewCell<D>, D: Codable, HF: GBHeaderFooterView<HFD>, HFD: Codable>: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    ///selectedRow: This clouse is called when didSelect is called
    var selectedRow: ((UITableView, IndexPath) -> ())?
    
    ///deselectedRow: This clouse is called when didDeSelect is called
    var deselectedRow: ((UITableView, IndexPath) -> ())?
    
    ///sections: This clouse is used to return the number of sections. This is a optional clouser
    var sections: ((UITableView) -> Int)?
    
    ///rows: This clouse is used to return the number of rows per sections. This is a required clouser
    var rows: ((UITableView, Int, Int?) -> (Int,D?, HFD?))?
    
    ///headerHeight: This clouse is used to give height to the section header. This is a optional clouser
    var headerHeight: ((UITableView, Int) -> CGFloat)?
    
    ///rowHeight: This clouse is used to give height to the row. This is a optional clouser
    var rowHeight: ((UITableView, IndexPath) -> CGFloat)?
    
    ///rowHeight: This clouse is used to set the header view. This is a optional clouser
    var headerView: ((UITableView, Int) -> UIView)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    final internal func numberOfSections(in tableView: UITableView) -> Int {
        return sections?(tableView) ?? 1
    }
    
    final internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rows = rows else{
            assert(false, "Please implement the rows clouser to return number of rows")
            return 0
        }
        return rows(tableView, section, nil).0
    }
    
    final internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: T.self)) as! T
        cell.data = rows!(tableView, indexPath.section, indexPath.row).1
        return cell
    }
    
    final internal func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if headerView == nil{
            let headerView = Bundle.main.loadNibNamed(String(describing: HF.self), owner: self, options: nil)?[0] as? HF
            headerView?.headerFooterData = rows!(tableView, section, nil).2
            return headerView
        }else{
            return headerView!(tableView, section)
        }
    }
    
    
    final internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedRow == nil{
            print("Please implement selectedRow clouser")
        }else{
            selectedRow!(tableView, indexPath)
        }
    }
    
    final internal func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if deselectedRow == nil{
            print("Please implement selectedRow clouser")
        }else{
            deselectedRow!(tableView, indexPath)
        }
    }
    
    final internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight?(tableView, indexPath) ?? UITableView.automaticDimension
    }
    
    final internal func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight?(tableView, section) ?? 0
    }
}
