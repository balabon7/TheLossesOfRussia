//
//  TableViewConfigurator.swift
//  TheLossesOfRussia
//
//  Created by Oleksandr Balabon on 28.08.2023.
//

import UIKit

class DetailTableViewConfigurator: NSObject {
    
    static func configureTableView(for viewController: UIViewController) -> UITableView {
        let tableView = UITableView(frame: .zero, style: .plain)
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        
        viewController.view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        return tableView
    }
}

