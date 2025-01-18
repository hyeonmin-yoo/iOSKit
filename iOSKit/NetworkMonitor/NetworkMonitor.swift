//
//  NetworkMonitor.swift
//  iPadOSKit
//
//  Created by HYEONMIN YOO on 18/01/2025.
//

import Network
import UIKit

final class NetworkMonitor {
    private static let shared = NetworkMonitor()
    static var isOn: Bool { shared.pathMonitor.currentPath.status == .satisfied ? true : false }
    
    private let pathMonitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "network_monitor")

    private init() { }
    
    deinit { pathMonitor.cancel() }
    
    static func start() {
        shared.pathMonitor.pathUpdateHandler = { path in
            if path.status != .satisfied {
                print("Network disconnected: \(path.status)")
                Task { await showOfflineAlert() }
            }
        }
        shared.pathMonitor.start(queue: shared.queue)
    }
    
    static func stop() {
        shared.pathMonitor.cancel()
    }

    @MainActor
    private static func showOfflineAlert() {
        let alert = UIAlertController(title: nil,
                                      message: String(localized: "Please check the cellular or Wi-Fi connection status."),
                                      preferredStyle: .alert)
        let action: UIAlertAction = .init(title: String(localized: "OK"), style: .default) { _ in
            if isOn == false {
                showOfflineAlert()
            }
        }
        alert.addAction(action)
        alert.preferredAction = action
        
        Navigator.shared.visibleViewController?.present(alert, animated: true)
    }
}
