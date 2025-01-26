//
//  SelectiveDragTableViewCell.swift
//  iOSKit
//
//  Created by HYEONMIN YOO on 26/01/2025.
//

import UIKit

class SelectiveDragTableViewCell: UITableViewCell {
    
    private var viewColour: UIColor? {
        didSet { cellView.backgroundColor = viewColour }
    }
    
    let cellView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 64)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
        contentView.addSubview(cellView)
        [titleLabel].forEach(cellView.addSubview)
    }
    
    private func setupLayouts() {
        cellView.pinToEdges(of: contentView, margins: UIEdgeInsets(top: 16, left: 16, bottom: -16, right: -16))
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 4),
            titleLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -4),
            titleLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -8)
        ])
    }
    
    func configure(title: String) {
        self.titleLabel.text = title
    }
}
