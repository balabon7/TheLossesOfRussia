//
//  PersonnelViewController.swift
//  TheLossesOfRussia
//
//  Created by Oleksandr Balabon on 27.08.2023.
//

import UIKit
import SnapKit

class PersonnelViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    enum SortOrder {
        case ascending
        case descending
    }
    
    private var currentSortOrder: SortOrder = .ascending
    private let dataFetchService = DataFetchService()
    private var tableView: UITableView!
    private var personnelArray: [Personnel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Personnel"
        self.view.backgroundColor = .white
        
        let sortButton = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(toggleSortAndUpdateTable))
        self.navigationItem.rightBarButtonItem = sortButton
        
        configureTableView()
        fetchPersonnelData()
    }
    
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
        headerView.backgroundColor = UIColor.systemGray4  // or your desired color for the background

        let label = UILabel(frame: CGRect(x: 15, y: 5, width: tableView.bounds.size.width, height: 20))
        label.text = self.tableView(tableView, titleForHeaderInSection: section)
        label.textColor = UIColor.black
        headerView.addSubview(label)

        return headerView
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return personnelArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let day: Int = personnelArray[section].day,
              let date: String = personnelArray[section].date,
              let formattedDate = date.formatDate(from: "yyyy-MM-dd", to: "dd MMMM yyyy")
        else { return "N/A"}
        let title = "Day \(day): \(formattedDate)"
        return title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EquipmentTableViewCell.identifier, for: indexPath) as? EquipmentTableViewCell else { return UITableViewCell() }
        
        let personnel: Int = personnelArray[indexPath.section].personnel ?? 0
        cell.configure(with: "Personnel losses: \(personnel)")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let personnel = personnelArray[indexPath.section]
        let detailController = DetailsPersonnelViewController(personnel: personnel)
        navigationController?.pushViewController(detailController, animated: true)
    }
    
    func fetchPersonnelData() {
        dataFetchService.getPersonnelData(){ result in
            switch result {
            case .success(let array):
                self.personnelArray = array
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching equipment:", error.localizedDescription)
            }
        }
    }
    
    // MARK: - Sorted
    func sortAndUpdateTable() {
        switch currentSortOrder {
        case .ascending:
            personnelArray.sort { ($0.date ?? "").compare($1.date ?? "") == .orderedAscending }
        case .descending:
            personnelArray.sort { ($0.date ?? "").compare($1.date ?? "") == .orderedDescending }
        }
        
        // Reload table view data
        tableView.reloadData()
    }
    
    @objc func toggleSortAndUpdateTable() {
        // Toggle sort order
        currentSortOrder = currentSortOrder == .ascending ? .descending : .ascending
        // Sort and update table
        sortAndUpdateTable()
    }
}
