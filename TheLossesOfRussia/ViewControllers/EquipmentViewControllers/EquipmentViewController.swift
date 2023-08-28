//
//  EquipmentViewController.swift
//  TheLossesOfRussia
//
//  Created by Oleksandr Balabon on 27.08.2023.
//

import UIKit
import SnapKit

class EquipmentViewController: UIViewController {
    
    // MARK: - Properties
    private let dataFetchService = DataFetchService()
    private var tableView: UITableView!
    private var equipmentArray: [Equipment] = []
    private var sections: [String: [Equipment]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Equipment"
        self.view.backgroundColor = .white

        configureTableView()
        fetchEquipment()
    }
    
    // MARK: - Configuration
    private func configureTableView() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        
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
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension EquipmentViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.keys.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Array(sections.keys).sorted()[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return equipmentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EquipmentTableViewCell.identifier, for: indexPath) as? EquipmentTableViewCell,
              let equipmentDate = equipmentArray[indexPath.row].date,
              let formattedDate: String = equipmentDate.formatDate(from: "yyyy-MM-dd", to: "dd MMMM")
        else { return UITableViewCell() }

        cell.configure(with: formattedDate)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let equipment = equipmentArray[indexPath.row]
        let detailController = DetailEquipmentViewController(equipment: equipment)
        navigationController?.pushViewController(detailController, animated: true)
    }
}

// MARK: - Data Fetching and Organization
extension EquipmentViewController {
    
    func fetchEquipment() {
        dataFetchService.getEquipmentData { result in
            switch result {
            case .success(let equipmentArray):
                self.equipmentArray = equipmentArray
                self.organizeDataIntoSections(equipmentArray)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching equipment:", error.localizedDescription)
            }
        }
    }
    
    private func organizeDataIntoSections(_ equipmentList: [Equipment]) {
        for equipment in equipmentList {
            if let year = self.getYear(from: equipment.date) {
                if self.sections[year] != nil {
                    self.sections[year]?.append(equipment)
                } else {
                    self.sections[year] = [equipment]
                }
            }
        }
    }
    
    private func getYear(from dateString: String?) -> String? {
        guard let dateString = dateString else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "yyyy"
            return dateFormatter.string(from: date)
        }
        return nil
    }
}
