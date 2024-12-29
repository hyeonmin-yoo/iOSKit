//
//  MainViewController.swift
//  iOSKit
//
//  Created by HYEONMIN YOO on 22/12/2024.
//

import UIKit

class MainViewController: UIViewController {
    
    override func loadView() {
        view = View()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        bind()
    }
    
    private func setupViews() {
        
    }
    
    private func bind() {
    }
}

// MARK: - View
extension MainViewController {
    class View: UIView {
        let tableView: UITableView = {
            let tableView = UITableView()
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.rowHeight = 44
            tableView.separatorStyle = .none
            return tableView
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = .white
            setupViews()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupViews() {
            [tableView].forEach(addSubview)
            setupViewLayouts()
        }
        private func setupViewLayouts() {
            NSLayoutConstraint.activate { }
            setupContentViewLayouts()
        }
        
        private func setupContentViewLayouts() {
            NSLayoutConstraint.activate { }
        }
    }
}
