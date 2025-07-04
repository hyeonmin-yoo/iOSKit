//
//  MainViewController.swift
//  iOSKit
//
//  Created by HYEONMIN YOO on 22/12/2024.
//

import UIKit

class MainViewController: UIViewController {
    private let mainView = MainViewController.View()

    override func loadView() { view = mainView }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        bind()
    }

    private func setupViews() {
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
    }

    private func bind() {
    }
}

// MARK: - View
fileprivate extension MainViewController {
    // MainView
    class View: UIView {
        let tableView: UITableView = {
            let tableView = UITableView()
            tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "cell")
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.rowHeight = 100
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
            tableView.pinToSafeAreaLayoutGuideEdges(of: self)
        }
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Titles.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MainTableViewCell else {
            return MainTableViewCell()
        }
        cell.configure(title: Titles.allCases[indexPath.row].rawValue, hexColor: ViewColors.allCases[indexPath.row].rawValue)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0: Navigator.push(.snackbar)
        case 1: Navigator.push(.networkMonitor)
        case 2: Navigator.push(.selectiveDrag)
        default: return
        }
    }
}
