//
//  EquipmentCorrectionViewController.swift
//  TheLossesOfRussia
//
//  Created by Oleksandr Balabon on 27.08.2023.
//


import UIKit
import SnapKit

class EquipmentCorrectionViewController: UIViewController {

    private let dataFetchService = DataFetchService()
    private var tableView: UITableView!
    private var equipmentCorrectionArray: [EquipmentCorrection] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Equipment Correction"
        self.view.backgroundColor = .white
        configureTableView()
        fetchEquipmentCorrection()
    }
    
    // MARK: - TableView Configuration
    private func configureTableView() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(EquipmentCorrectionCell.self, forCellReuseIdentifier: EquipmentCorrectionCell.identifier)
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

// MARK: - UITableViewDataSource & UITableViewDelegate
extension EquipmentCorrectionViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return equipmentCorrectionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EquipmentCorrectionCell.identifier, for: indexPath) as? EquipmentCorrectionCell else { return UITableViewCell() }
        let equipmentCorrection: EquipmentCorrection = equipmentCorrectionArray[indexPath.row]
        cell.configure(with: equipmentCorrection)
        
        return cell
    }
}

// MARK: - Data Fetching
extension EquipmentCorrectionViewController {
    
    func fetchEquipmentCorrection() {
        dataFetchService.getEquipmentCorrectionData() { result in
            switch result {
            case .success(let array):
                self.equipmentCorrectionArray = array
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching equipment:", error.localizedDescription)
            }
        }
    }
}
