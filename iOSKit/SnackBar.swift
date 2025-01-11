//
//  Toast.swift
//  iOSKit
//
//  Created by HYEONMIN YOO on 11/01/2025.
//

import UIKit

/**
 A singleton that creates, sets up and displays  a toast
 
 Usage
 ```
 SnackBar(message: String(localized: "Success"), style: .success).show(.bottom)
 ```
 */

import UIKit

@MainActor
final class SnackBar: UIView {
    private let hostView: UIView?
    private let message: String
    private let style: Style
    private let completion: (() -> Void)?
    
    init(hostView: UIView? = nil,
         message: String,
         style: Style,
         completion: (() -> Void)? = nil) {
        self.hostView = hostView
        self.message = message
        self.style = style
        self.completion = completion
        super.init(frame: .zero)
        setupView()
        setupViewLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        alpha = .zero
        backgroundColor = style.backgroundColor
        layer.cornerRadius = 4
        translatesAutoresizingMaskIntoConstraints = false
        messageLabel.text = message
        
        setupShadow()
    }

    private func setupShadow() {
        layer.shadowColor = UIColor(hex: "#303030").cgColor
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 24.0
        layer.shadowOffset.height = 1.0
    }

    private func setupViewLayout() {
        addSubview(messageLabel)
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            messageLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
    }

    func show(position: Position = .top) {
        guard let parentView = (hostView != nil) ? hostView : Utils.visibleViewController?.view else { return }
        parentView.addSubview(self)
        setupPosition(hostView: hostView, position: position)
        
        superview?.layoutIfNeeded()
        UIView.animate(withDuration: 1) { [weak self] in
            guard let self else { return }
            alpha = 1.0
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { [weak self] _ in
                guard let self else { return }
                Task { await self.dismiss() }
            }
        }
    }
    
    private func setupPosition(hostView: UIView?, position: Position) {
        guard let parentView = (hostView != nil) ? hostView : Utils.visibleViewController?.view else { return }
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
            widthAnchor.constraint(equalTo: parentView.widthAnchor, multiplier: 0.9),
            heightAnchor.constraint(equalToConstant: 60),
        ])
        switch position {
        case .top:
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.topAnchor)
            ])
        case .bottom:
            NSLayoutConstraint.activate([
                bottomAnchor.constraint(equalTo: parentView.keyboardLayoutGuide.topAnchor, constant: -5)
            ])
        }
    }
    
    private func dismiss() {
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.alpha = .zero
        }completion: { [weak self] _ in
            guard let self else { return }
            completion?()
            removeFromSuperview()
        }
    }
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .white
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}

extension SnackBar {
    enum Style {
        case success
        case warning
        case error
        
        var backgroundColor: UIColor {
            switch self {
            case .success: UIColor(hex: "#6BBF59")
            case .warning: UIColor(hex: "#E5A74D")
            case .error: UIColor(hex: "#D94A4A")
            }
        }
    }
    
    enum Position {
        case top
        case bottom
    }
}
