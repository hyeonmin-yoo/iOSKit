//
//  MainTableViewCell.swift
//  iOSKit
//
//  Created by HYEONMIN YOO on 29/12/2024.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    private var title: String? {
        didSet { titleLabel.text = title }
    }
    let titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        // TODO: delete
        contentView.backgroundColor = .red
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        // TODO: delete
        titleLabel.backgroundColor = .yellow
        titleLabel.textColor = .black
        contentView.addSubview(titleLabel)
    }
    
    private func setupLayouts() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
    
    func configure(title: String) {
        self.title = title
    }
}
