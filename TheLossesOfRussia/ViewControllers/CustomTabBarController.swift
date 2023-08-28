//
//  CustomTabBarController.swift
//  TheLossesOfRussia
//
//  Created by Oleksandr Balabon on 28.08.2023.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        let equipmentVC = createNavController(for: EquipmentViewController(), title: nil, image: "gear")
        let equipmentCorrectionVC = createNavController(for: EquipmentCorrectionViewController(), title: nil, image: "wrench.and.screwdriver")
        let equipmentOryxVC = createNavController(for: EquipmentOryxViewController(), title: nil, image: "bus.fill")
        let personnelVC = createNavController(for: PersonnelViewController(), title: nil, image: "person.fill")
        
        viewControllers = [equipmentVC, equipmentCorrectionVC, equipmentOryxVC, personnelVC]
    }
    
    private func createNavController(for rootViewController: UIViewController, title: String?, image: String) -> UINavigationController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: image), tag: 0)
        return navController
    }
}
