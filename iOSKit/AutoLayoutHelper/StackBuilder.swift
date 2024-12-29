//
//  StackBuilder.swift
//  iOSKit
//
//  Created by HYEONMIN YOO on 22/12/2024.
//  Copyright © 2023 STRANSA CO.,LTD. All rights reserved.
//

import UIKit

// MARK: - StackBuilderProtocol
protocol StackBuilderProtocol: AnyObject {
    associatedtype Anchor: LayoutAnchor
    init(beginAnchor: Anchor, endAnchor: Anchor)
    func append(space: CGFloat, view: some Layoutable, priority: UILayoutPriority) -> Self
    func make(space: CGFloat, priority: UILayoutPriority) -> [NSLayoutConstraint]
}

extension StackBuilderProtocol {
    func append<Views: Sequence>(space: CGFloat = .zero, views: Views, priority: UILayoutPriority = .required) -> Self where Views.Element: Layoutable {
        views.forEach { _ = append(space: space, view: $0, priority: priority) }
        return self
    }

    func append(firstSpace: CGFloat, space: CGFloat = .zero, views: [some Layoutable], priority: UILayoutPriority = .required) -> Self {
        guard let firstView = views.first else { return self }
        _ = append(space: firstSpace, view: firstView, priority: priority)
        views.dropFirst().forEach { _ = append(space: space, view: $0, priority: priority) }
        return self
    }
}

// MARK: - HStackBuilder
final class HStackBuilder: StackBuilderProtocol {
    private var anchor: NSLayoutXAxisAnchor
    private var endAnchor: NSLayoutXAxisAnchor
    private(set) var constraints: [NSLayoutConstraint] = []

    init(beginAnchor: NSLayoutXAxisAnchor, endAnchor: NSLayoutXAxisAnchor) {
        anchor = beginAnchor
        self.endAnchor = endAnchor
    }

    func append(space: CGFloat = .zero, view: some Layoutable, priority: UILayoutPriority = .required) -> Self {
        let constraint = anchor.constraint(equalTo: view.leftAnchor, constant: -space)
        constraint.priority = priority
        constraints.append(constraint)
        anchor = view.rightAnchor
        return self
    }

    func make(space: CGFloat = .zero, priority: UILayoutPriority = .required) -> [NSLayoutConstraint] {
        let constraint = anchor.constraint(equalTo: endAnchor, constant: -space)
        constraint.priority = priority
        constraints.append(constraint)
        return constraints
    }
}

// MARK: - VStackBuilder
final class VStackBuilder: StackBuilderProtocol {
    private var anchor: NSLayoutYAxisAnchor
    private var endAnchor: NSLayoutYAxisAnchor
    private(set) var constraints: [NSLayoutConstraint] = []

    init(beginAnchor: NSLayoutYAxisAnchor, endAnchor: NSLayoutYAxisAnchor) {
        anchor = beginAnchor
        self.endAnchor = endAnchor
    }

    func append(space: CGFloat = .zero, view: some Layoutable, priority: UILayoutPriority = .required) -> Self {
        let constraint = anchor.constraint(equalTo: view.topAnchor, constant: -space)
        constraint.priority = priority
        constraints.append(constraint)
        anchor = view.bottomAnchor
        return self
    }

    func make(space: CGFloat = .zero, priority: UILayoutPriority = .required) -> [NSLayoutConstraint] {
        let constraint = anchor.constraint(equalTo: endAnchor, constant: -space)
        constraint.priority = priority
        constraints.append(constraint)
        return constraints
    }
}

// MARK: - Layoutable
extension Layoutable {
    func hStack(space: CGFloat = .zero, view: some Layoutable, priority: UILayoutPriority = .required) -> HStackBuilder {
        .init(beginAnchor: leftAnchor, endAnchor: rightAnchor)
            .append(space: space, view: view, priority: priority)
    }

    func vStack(space: CGFloat = .zero, view: some Layoutable, priority: UILayoutPriority = .required) -> VStackBuilder {
        .init(beginAnchor: topAnchor, endAnchor: bottomAnchor)
            .append(space: space, view: view, priority: priority)
    }

    func hStack(space: CGFloat = .zero, views: [some Layoutable], priority: UILayoutPriority = .required) -> HStackBuilder {
        .init(beginAnchor: leftAnchor, endAnchor: rightAnchor)
            .append(space: space, views: views, priority: priority)
    }

    func vStack(space: CGFloat = .zero, views: [some Layoutable], priority: UILayoutPriority = .required) -> VStackBuilder {
        .init(beginAnchor: topAnchor, endAnchor: bottomAnchor)
            .append(space: space, views: views, priority: priority)
    }
}
