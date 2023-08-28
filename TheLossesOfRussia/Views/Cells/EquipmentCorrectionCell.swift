//
//  EquipmentCorrectionCell.swift
//  TheLossesOfRussia
//
//  Created by Oleksandr Balabon on 28.08.2023.
//

import UIKit
import SnapKit

class EquipmentCorrectionCell: UITableViewCell {
    
    static let identifier = "EquipmentCorrectionCell"
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 5
        return stack
    }()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
    
    // MARK: - Configuration
    func configure(with equipmentCorrection: EquipmentCorrection) {
        let mirror = Mirror(reflecting: equipmentCorrection)
        
        for child in mirror.children {
            let originalName = child.label ?? "Unknown"
            let name = EquipmentCorrection.formattedLabelName(for: originalName)
            var value: String?
            
            if let unwrappedStringValue = child.value as? String {
                value = unwrappedStringValue
            } else if let unwrappedIntValue = child.value as? Int {
                value = "\(unwrappedIntValue)"
            }
            
            if let value = value {
                addRow(withName: name, value: value)
            }
        }
    }
    
    // MARK: - Helpers
    private func addRow(withName name: String, value: String) {
        let nameLabel = createLabel(withText: name, fontSize: 18, alignment: .left, textColor: .darkGray)
        let valueLabel = createLabel(withText: value, fontSize: 17, alignment: .right)
        
        let horizontalStack = UIStackView(arrangedSubviews: [nameLabel, valueLabel])
        horizontalStack.axis = .horizontal
        horizontalStack.distribution = .fill
        horizontalStack.spacing = 10
        
        stackView.addArrangedSubview(horizontalStack)
    }
    
    private func createLabel(withText text: String, fontSize: CGFloat, alignment: NSTextAlignment, textColor: UIColor = .black) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont(name: "HelveticaNeue", size: fontSize)
        label.textAlignment = alignment
        label.textColor = textColor
        label.numberOfLines = 0
        return label
    }
    
    // MARK: - Setup
    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(stackView)
    }
    
    private func setupLayout() {
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(20)
        }
    }
}
