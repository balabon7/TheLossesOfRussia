//
//  EquipmentTableViewCell.swift
//  TheLossesOfRussia
//
//  Created by Oleksandr Balabon on 27.08.2023.
//

import UIKit
import SnapKit

class EquipmentTableViewCell: UITableViewCell {
    
    static let identifier = "EquipmentTableViewCell"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue", size: 18)
        label.numberOfLines = 0
        label.textColor = UIColor.darkGray
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.numberOfLines = 0
        label.font = UIFont(name: "HelveticaNeue", size: 17)
        return label
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
        nameLabel.text = nil
        valueLabel.text = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Configuration
    func configure(with text: String?) {
        nameLabel.text = text
    }
    
    // MARK: - Setup
    func setupViews() {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.tintColor = UIColor.lightGray
        accessoryView = imageView
        
        backgroundColor = .clear
        contentView.addSubview(nameLabel)
        contentView.addSubview(valueLabel)
    }
    
    private func setupLayout() {
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(20)
            make.top.equalTo(contentView).offset(10)
            make.bottom.equalTo(contentView).offset(-10)
        }
        
        valueLabel.snp.makeConstraints { make in
            make.right.equalTo(contentView).offset(-20)
            make.centerY.equalTo(contentView)
            make.left.greaterThanOrEqualTo(nameLabel.snp.right).offset(10)
        }
    }
}
