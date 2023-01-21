//
//  UITableView+Ext.swift
//  Movies-App
//
//  Created by Erdal Keser on 19.01.2023.
//

import UIKit

extension UITableView {
    
    func reloadOnMainThread(){
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}
