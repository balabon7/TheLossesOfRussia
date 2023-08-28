//
//  DetailTableViewCell.swift
//  TheLossesOfRussia
//
//  Created by Oleksandr Balabon on 27.08.2023.
//

import UIKit
import SnapKit

class DetailTableViewCell: UITableViewCell {

    static let identifier = "DetailTableViewCell"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue", size: 17)
        label.textColor = UIColor.darkGray
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont(name: "HelveticaNeue", size: 17)
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
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
    func configure(withName name: String?, andValue value: String?) {
        nameLabel.text = name
        valueLabel.text = value
    }
    
    // MARK: - Setup
    private func setupViews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(valueLabel)
    }
    
    private func setupLayout() {
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(20)
            make.top.greaterThanOrEqualTo(contentView).offset(5)
            make.bottom.lessThanOrEqualTo(contentView).offset(-5)
            make.centerY.equalTo(contentView)
        }
        
        valueLabel.snp.makeConstraints { make in
            make.right.equalTo(contentView).offset(-20)
            make.top.greaterThanOrEqualTo(contentView).offset(5)
            make.bottom.lessThanOrEqualTo(contentView).offset(-5)
            make.centerY.equalTo(contentView)
            make.left.greaterThanOrEqualTo(nameLabel.snp.right).offset(10)
        }
    }
}
