//
//  NSLayoutConstraintExtension.swift
//  iOSKit
//
//  Created by HYEONMIN YOO on 2023/09/13.
//  Copyright © 2023 STRANSA CO.,LTD. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    func set(priority: UILayoutPriority) -> Self {
        self.priority = priority
        return self
    }
}
