//
//  MenuViewController.swift
//  RxSwift Demo
//
//  Created by 楊朝富 on 2022/9/12.
//

import Foundation
import UIKit

class ManuViewController: UITableViewController {
    
    let menus = ["Login", "ImagePicker", "AdvenceTableView", "Calculator"]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        cell.labelTitle.text = menus[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.performSegue(withIdentifier: "gotoLogin", sender: nil)
        case 1:
            performSegue(withIdentifier: "gotoImagePicker", sender: nil)
        default:
            NSLog("Cannot found page with index = %d", indexPath.row)
        }
    }
}
