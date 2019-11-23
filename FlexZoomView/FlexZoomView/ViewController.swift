//
//  ViewController.swift
//  FlexZoomView
//
//  Created by apple on 2019/11/22.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

let kCellID = "TableViewCell"

class ViewController: UITableViewController {

    fileprivate let datas = ["FullScreenViewController","NavigationBarViewController","CustomViewController"]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: kCellID)
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellID, for: indexPath)
        cell.textLabel?.text = datas[(indexPath as NSIndexPath).row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0: // FullScreenViewController
            let vc = FullScreenViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 1: // NavigationBarViewController
            let vc = NavigationBarViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 2: // CustomViewController
            let vc = CustomViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
        
     }
}

