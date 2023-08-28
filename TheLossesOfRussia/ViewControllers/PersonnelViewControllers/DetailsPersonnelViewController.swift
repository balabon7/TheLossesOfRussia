//
//  DetailsPersonnelViewController.swift
//  TheLossesOfRussia
//
//  Created by Oleksandr Balabon on 27.08.2023.
//

import UIKit
import SnapKit

class DetailsPersonnelViewController: UIViewController {
    
    private var tableView: UITableView!
    
    var personnel: Personnel?
    
    init(personnel: Personnel) {
        self.personnel = personnel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.tableView = DetailTableViewConfigurator.configureTableView(for: self)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension DetailsPersonnelViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PropertyMapper.properties(for: personnel).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier, for: indexPath) as? DetailTableViewCell else { return UITableViewCell() }
        
        let property = PropertyMapper.properties(for: personnel)[indexPath.row]
        let name = "\(property.label):"
        let value = "\(property.value ?? "N/A")"
        cell.configure(withName: name, andValue: value)
        cell.selectionStyle = .none
        return cell
    }
}

