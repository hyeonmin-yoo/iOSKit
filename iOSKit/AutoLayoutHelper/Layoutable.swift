//
//  Layoutable.swift
//  iOSKit
//
//  Created by HYEONMIN YOO on 22/12/2024.
//  Copyright © 2023 STRANSA CO.,LTD. All rights reserved.
//

import UIKit

protocol Layoutable {
    var leftAnchor: NSLayoutXAxisAnchor { get }
    var rightAnchor: NSLayoutXAxisAnchor { get }
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }
    var widthAnchor: NSLayoutDimension { get }
    var heightAnchor: NSLayoutDimension { get }
}

extension Layoutable {
    func constraint(equalToCenter view: some Layoutable) -> [NSLayoutConstraint] {[
        centerXAnchor.constraint(equalTo: view.centerXAnchor),
        centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ]}

    func constraint(equalToEdges view: some Layoutable, priority: UILayoutPriority = .required) -> [NSLayoutConstraint] {[
        topAnchor.constraint(equalTo: view.topAnchor).set(priority: priority),
        leftAnchor.constraint(equalTo: view.leftAnchor).set(priority: priority),
        rightAnchor.constraint(equalTo: view.rightAnchor).set(priority: priority),
        bottomAnchor.constraint(equalTo: view.bottomAnchor).set(priority: priority)
    ]}
    
    func constraint(equalToSizeEdges view: some Layoutable) -> [NSLayoutConstraint] {[
        widthAnchor.constraint(equalTo: view.widthAnchor),
        heightAnchor.constraint(equalTo: view.heightAnchor)
    ]}

    func constraint(equalToSize size: CGSize) -> [NSLayoutConstraint] {[
        widthAnchor.constraint(equalToConstant: size.width),
        heightAnchor.constraint(equalToConstant: size.height)
    ]}
}

extension UIView: Layoutable {}
extension UILayoutGuide: Layoutable {}
