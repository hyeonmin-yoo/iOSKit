//
//  SelectiveDragViewController.swift
//  iOSKit
//
//  Created by HYEONMIN YOO on 26/01/2025.
//

import UIKit

class SelectiveDragViewController: UIViewController {
    
    private let mainView = SelectiveDragViewController.View()
    private var items = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    
    override func loadView() { view = mainView }
    
    override func viewDidLoad() {
        setupView()
        setupViewLayout()
    }
    
    private func setupView() {
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        mainView.tableView.isEditing = true
    }
    
    private func setupViewLayout() {
        
    }
}

// MARK: - View
fileprivate extension SelectiveDragViewController {
    class View: UIView {
        let tableView: UITableView = {
            let tableView = UITableView()
            tableView.register(SelectiveDragTableViewCell.self, forCellReuseIdentifier: "cell")
            tableView.rowHeight = UITableView.automaticDimension
            tableView.separatorStyle = .none
            tableView.translatesAutoresizingMaskIntoConstraints = false
            return tableView
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
            [tableView].forEach(addSubview)
        }
        private func setupViewLayouts() {
            tableView.pinToSafeAreaLayoutGuideEdges(of: self)
            NSLayoutConstraint.activate([
            ])
        }
    }
}

// MARK: - UITableViewDataSource
extension SelectiveDragViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SelectiveDragTableViewCell else {
            return SelectiveDragTableViewCell()
        }
        cell.configure(title: String(items[indexPath.row] + 1))
        return cell
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = items[sourceIndexPath.row]
        items.remove(at: sourceIndexPath.row)
        items.insert(movedObject, at: destinationIndexPath.row)
    }
}

// MARK: - UITableViewDelegate
extension SelectiveDragViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}
