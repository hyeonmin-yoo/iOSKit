//
//  UIViewExtension.swift
//  iOSKit
//
//  Created by HYEONMIN YOO on 29/12/2024.
//

import UIKit

extension UIView {
    func pinToEdges(of superview: UIView, margins: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: margins.left),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: margins.right),
            topAnchor.constraint(equalTo: superview.topAnchor, constant: margins.top),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: margins.bottom)
        ])
    }
    
    func pinToSafeAreaLayoutGuideEdges(of superview: UIView, margins: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor, constant: margins.left),
            trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor, constant: margins.right),
            topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: margins.top),
            bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: margins.bottom)
        ])
    }
}
