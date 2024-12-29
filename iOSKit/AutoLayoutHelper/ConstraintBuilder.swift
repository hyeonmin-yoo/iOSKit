//
//  ConstraintBuilder.swift
//  iOSKit
//
//  Created by HYEONMIN YOO on 22/12/2024.
//  Copyright © 2023 STRANSA CO.,LTD. All rights reserved.
//

import UIKit

@resultBuilder
struct ConstraintBuilder {
    static func buildExpression(_ expression: NSLayoutConstraint) -> [NSLayoutConstraint] { [expression] }
    static func buildExpression(_ expression: [NSLayoutConstraint]) -> [NSLayoutConstraint] { expression }
    static func buildBlock(_ components: [NSLayoutConstraint]...) -> [NSLayoutConstraint] {
        components.flatMap { $0 }
    }
    static func buildOptional(_ component: [NSLayoutConstraint]?) -> [NSLayoutConstraint] { component ?? [] }
    static func buildEither(first component: [NSLayoutConstraint]) -> [NSLayoutConstraint] { component }
    static func buildEither(second component: [NSLayoutConstraint]) -> [NSLayoutConstraint] { component }
    static func buildArray(_ components: [[NSLayoutConstraint]]) -> [NSLayoutConstraint] {
        components.flatMap { $0 }
    }
    static func buildLimitedAvailability(_ component: [NSLayoutConstraint]) -> [NSLayoutConstraint] { component }

    static func build(@ConstraintBuilder builder: () -> ([NSLayoutConstraint])) -> [NSLayoutConstraint] {
        builder()
    }
}

// MARK: - NSLayoutConstraint
extension NSLayoutConstraint {
    static func activate(@ConstraintBuilder builder: () -> ([NSLayoutConstraint])) {
        activate(builder())
    }
}
