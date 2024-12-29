//
//  AttributedAnchor.swift
//  iOSKit
//
//  Created by HYEONMIN YOO on 22/12/2024.
//  Copyright © 2023 STRANSA CO.,LTD. All rights reserved.
//

import UIKit

/*
 NSLayoutConstraint.activate([
    widthAnchor == 8,                    // widthAnchor.constraint(equalToConstant: 8)
    widthAnchor == heightAnchor,         // widthAnchor.constraint(equalTo: heightAnchor)
    widthAnchor == heightAnchor + 8,     // widthAnchor.constraint(equalTo: heightAnchor, constant: 8)
    widthAnchor == heightAnchor * 2 + 8, // widthAnchor.constraint(equalTo: heightAnchor, multiplier: 2, constant: 8)
    widthAnchor <= heightAnchor          // widthAnchor.constraint(lessThanOrEqualTo: heightAnchor)
 ])
 */

struct AttributedAnchor<Anchor: LayoutAnchor> {
    var anchor: Anchor
    var multiplier: CGFloat = 1
    var constant: CGFloat = .zero
}

extension AttributedAnchor {
    static func + (anchor: Self, constant: CGFloat) -> Self {
        var clone = anchor
        clone.constant = constant
        return clone
    }
    static func - (anchor: Self, constant: CGFloat) -> Self { anchor + (-constant) }
}

// MARK: - LayoutAnchor
protocol LayoutAnchor {
    func constraint(equalTo anchor: Self) -> NSLayoutConstraint
    func constraint(equalTo anchor: Self, constant: CGFloat) -> NSLayoutConstraint
    func constraint(lessThanOrEqualTo anchor: Self) -> NSLayoutConstraint
    func constraint(lessThanOrEqualTo anchor: Self, constant: CGFloat) -> NSLayoutConstraint
}

extension LayoutAnchor {
    static func == (lhs: Self, rhs: Self) -> NSLayoutConstraint { lhs.constraint(equalTo: rhs) }
    static func == (lhs: Self, rhs: AttributedAnchor<Self>) -> NSLayoutConstraint { lhs.constraint(equalTo: rhs.anchor, constant: rhs.constant) }
    static func <= (lhs: Self, rhs: Self) -> NSLayoutConstraint { lhs.constraint(lessThanOrEqualTo: rhs) }
    static func <= (lhs: Self, rhs: AttributedAnchor<Self>) -> NSLayoutConstraint { lhs.constraint(lessThanOrEqualTo: rhs.anchor, constant: rhs.constant) }
    static func + (anchor: Self, constant: CGFloat) -> AttributedAnchor<Self> { .init(anchor: anchor, constant: constant) }
    static func - (anchor: Self, constant: CGFloat) -> AttributedAnchor<Self> { .init(anchor: anchor, constant: -constant) }
}

extension NSLayoutAnchor: LayoutAnchor {}

// MARK: - NSLayoutDimension
extension NSLayoutDimension {
    static func == (anchor: NSLayoutDimension, constant: CGFloat) -> NSLayoutConstraint { anchor.constraint(equalToConstant: constant) }
    static func == (lhs: NSLayoutDimension, rhs: AttributedAnchor<NSLayoutDimension>) -> NSLayoutConstraint { lhs.constraint(equalTo: rhs.anchor, multiplier: rhs.multiplier, constant: rhs.constant) }
    static func <= (anchor: NSLayoutDimension, constant: CGFloat) -> NSLayoutConstraint { anchor.constraint(lessThanOrEqualToConstant: constant) }
    static func >= (anchor: NSLayoutDimension, constant: CGFloat) -> NSLayoutConstraint { anchor.constraint(greaterThanOrEqualToConstant: constant) }
    static func + (anchor: NSLayoutDimension, constant: CGFloat) -> AttributedAnchor<NSLayoutDimension> { .init(anchor: anchor, constant: constant) }
    static func * (anchor: NSLayoutDimension, multiplier: CGFloat) -> AttributedAnchor<NSLayoutDimension> { .init(anchor: anchor, multiplier: multiplier) }
}
