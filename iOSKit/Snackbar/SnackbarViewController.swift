//
//  SnackBarViewController.swift
//  iOSKit
//
//  Created by HYEONMIN YOO on 11/01/2025.
//

import UIKit

class SnackbarViewController: UIViewController {
    private let mainView = SnackbarViewController.View()
    
    override func loadView() { view = mainView }
    
    override func viewDidLoad() {
        setupView()
        setupViewLayout()
    }
    
    private func setupView() {
        mainView.topButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        mainView.bottomButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    private func setupViewLayout() {
        
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        switch (sender.tag, mainView.segmentedControl.selectedSegmentIndex) {
        case (0, 0):
//            Snackbar(message: String(localized: "Top-Success"), style: .success).show(position: .top)
            Snackbar(message: String(localized: "Top-Success"), style: .success).show(position: .top)
        case (0, 1):
            Snackbar(message: String(localized: "Top-Warning"), style: .warning).show(position: .top)
        case (0, 2):
            Snackbar(message: String(localized: "Top-Error"), style: .error).show(position: .top)
        case (1, 0):
            Snackbar(message: String(localized: "Bottom-Success"), style: .success).show(position: .bottom)
        case (1, 1):
            Snackbar(message: String(localized: "Bottom-Warning"), style: .warning).show(position: .bottom)
        case (1, 2):
            Snackbar(message: String(localized: "Bottom-Error"), style: .error).show(position: .bottom)
        default: return
        }
    }
}

// MARK: - View
fileprivate extension SnackbarViewController {
    // MainView
    class View: UIView {
        
        let segmentedControl: UISegmentedControl = {
            var control = UISegmentedControl(items: [String(localized: "Success"), String(localized: "Warning"), String(localized: "Error")])
            control.selectedSegmentIndex = .zero
            control.translatesAutoresizingMaskIntoConstraints = false
            return control
        }()
        
        let topButton: UIButton = {
            let button = UIButton(type: .system)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle(String(localized: "TOP"), for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .orange
            button.layer.cornerRadius = 10
            button.tag = 0
            return button
        }()
        
        let bottomButton: UIButton = {
            let button = UIButton(type: .system)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle(String(localized: "BOTTOM"), for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .orange
            button.layer.cornerRadius = 10
            button.tag = 1
            return button
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
            [segmentedControl, topButton, bottomButton].forEach(addSubview)
        }
        private func setupViewLayouts() {
            NSLayoutConstraint.activate([
                segmentedControl.centerXAnchor.constraint(equalTo: centerXAnchor),
                segmentedControl.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
                topButton.widthAnchor.constraint(equalToConstant: 200),
                topButton.centerXAnchor.constraint(equalTo: centerXAnchor),
                topButton.centerYAnchor.constraint(equalTo: centerYAnchor),
                bottomButton.topAnchor.constraint(equalTo: topButton.bottomAnchor, constant: 12),
                bottomButton.widthAnchor.constraint(equalToConstant: 200),
                bottomButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            ])
        }
    }
}
