//
//  NetworkMonitorViewController.swift
//  iOSKit
//
//  Created by HYEONMIN YOO on 18/01/2025.
//

import UIKit

class NetworkMonitorViewController: UIViewController {
    private let mainView = NetworkMonitorViewController.View()
    
    override func loadView() { view = mainView }
    
    override func viewDidLoad() {
        setupView()
        setupViewLayout()
    }
    
    private func setupView() {
        NetworkMonitor.start()
    }
    
    private func setupViewLayout() {
        
    }
}

// MARK: - View
fileprivate extension NetworkMonitorViewController {
    
    class View: UIView {
        
        let label: UILabel = {
            let label = UILabel()
            label.text = String(localized: "Set smartphone to air plane mode to block all network connections.")
            label.font = .systemFont(ofSize: 30)
            label.textAlignment = .center
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = .white
            setupViews()
            setupViewLayouts()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupViews() {
            [label].forEach(addSubview)
        }
        
        private func setupViewLayouts() {
            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 200.0),
                label.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 12.0),
                label.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -12.0)
            ])
        }
    }
}
