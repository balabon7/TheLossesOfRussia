//
//  EquipmentOryxViewController.swift
//  TheLossesOfRussia
//
//  Created by Oleksandr Balabon on 27.08.2023.
//

import UIKit
import SnapKit

class EquipmentOryxViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Variables & Initialization
    private let dataFetchService = DataFetchService()
    private var tableView: UITableView!
    private var equipmentOryxArray: [EquipmentOryx] = []
    private var sections: [String: [EquipmentOryx]] = [:]
    
    // MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Equipment Oryx"
        self.view.backgroundColor = .white
        configureTableView()
        fetchEquipmentOryx()
    }
    
    // MARK: - TableView Configuration
    private func configureTableView() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(EquipmentTableViewCell.self, forCellReuseIdentifier: EquipmentTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        headerView.backgroundColor = UIColor.systemGray4
        let label = UILabel(frame: CGRect(x: 15, y: 5, width: tableView.bounds.size.width, height: 20))
        label.text = self.tableView(tableView, titleForHeaderInSection: section)
        headerView.addSubview(label)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    // MARK: - UITableViewDataSource Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.keys.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Array(sections.keys).sorted()[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let category = Array(sections.keys).sorted()[section]
        return sections[category]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EquipmentTableViewCell.identifier, for: indexPath) as? EquipmentTableViewCell else { return UITableViewCell() }
        
        let category = Array(sections.keys).sorted()[indexPath.section]
        if let equipmentList = sections[category], indexPath.row < equipmentList.count {
            let model: String? = equipmentList[indexPath.row].model
            cell.configure(with: model)
        }
        
        return cell
    }
    
    // MARK: - UITableViewDelegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let category = Array(sections.keys).sorted()[indexPath.section]
        if let equipmentList = sections[category], indexPath.row < equipmentList.count {
            let equipmentOryx = equipmentList[indexPath.row]
            let detailController = DetailsEquipmentOryxViewController(equipmentOryx: equipmentOryx)
            navigationController?.pushViewController(detailController, animated: true)
        }
    }
    
    // MARK: - Data Fetching & Processing
    func fetchEquipmentOryx() {
        dataFetchService.getEquipmentOryxData(){ result in
            switch result {
            case .success(let array):
                self.equipmentOryxArray = array
                self.organizeDataIntoSections(array)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching equipment:", error.localizedDescription)
            }
        }
    }
    
    private func organizeDataIntoSections(_ equipmentList: [EquipmentOryx]) {
        for equipmentOryx in equipmentList {
            if let category = equipmentOryx.equipmentOryx {
                if sections[category] == nil {
                    sections[category] = []
                }
                sections[category]?.append(equipmentOryx)
            }
        }
    }
}
