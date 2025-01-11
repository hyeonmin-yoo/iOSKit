//
//  Utilities.swift
//  iOSKit
//
//  Created by HYEONMIN YOO on 11/01/2025.
//

import UIKit

/**
 Utility class
 - Note
 - Most of the implemented methods are static methods, so they can be used without creating an instance
 */
class Utils {
    static var visibleViewController: UIViewController? {
        guard let viewController = Navigator.shared.visibleViewController else {
            assertionFailure("No ViewController")
            return nil
        }
        return viewController
    }
    
    enum Formatters: String {
        case yyyyMMdd = "yyyy_MM_dd"
    }
    
    static func today(format: Formatters) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        let dateString = dateFormatter.string(from: Date())
        return dateString
    }
}
