//
//  AppView.swift
//  Smartsupp SDK UIKit
//
//  Created by Adam Konečný on 17.01.2024.
//

import UIKit

protocol AppViewDelegate: AnyObject {
    func identifyUser()
    func openChatBox()
}

class AppView: UIView {
    private let unreadMessagesLabel: UILabel = {
        let label = UILabel()
        
        label.font = .preferredFont(forTextStyle: .body)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        return label
    }()
    
    private let accountStatusLabel: UILabel = {
        let label = UILabel()
        
        label.font = .preferredFont(forTextStyle: .body)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        return label
    }()
    
    private var unreadMessagesCount: Int
    private var isOnline: Bool
    
    weak var delegate: AppViewDelegate?
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(unreadMessagesCount: Int, isOnline: Bool) {
        self.unreadMessagesCount = unreadMessagesCount
        self.isOnline = isOnline
        
        super.init(frame: .zero)
        
        backgroundColor = .systemGroupedBackground
        
        let stackView = UIStackView.vertical(32.0)
        
        stackView.addArrangedSubview(
            UIStackView.vertical(8.0).addArrangedSubviews([
                statusLabel(withText: "STATUS"),
                section(with: [
                    titleValue(withTitle: "Unread messages", valueLabel: unreadMessagesLabel),
                    titleValue(withTitle: "Account status", valueLabel: accountStatusLabel)
                ])
            ])
        )
        
        stackView.addArrangedSubview(
            UIStackView.vertical(8.0).addArrangedSubviews([
                statusLabel(withText: "ACTIONS"),
                section(with: [
                    button(withTitle: "Identify user", action: #selector(identifyUser)),
                    button(withTitle: "Open chat box", action: #selector(openChatBox))
                ])
            ])
        )
        
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16.0),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0)
        ])
        
        updateStatusValues()
    }
    
    private func statusLabel(withText text: String) -> UILabel {
        let statusLabel = BaseLabel()
        
        statusLabel.padding.left = 16.0
        statusLabel.text = text
        statusLabel.textColor = .systemGray
        statusLabel.font = .preferredFont(forTextStyle: .footnote)
        
        return statusLabel
    }
    
    private func section(with subviews: [UIView]) -> UIView {
        let contentView = UIView()
        
        contentView.backgroundColor = .secondarySystemGroupedBackground
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 8.0
        
        let stackView = UIStackView.vertical(4.0)
        
        for (index, subview) in subviews.enumerated() {
            stackView.addArrangedSubview(subview)
            
            if index < (subviews.count - 1) {
                stackView.addArrangedSubview(separatorView)
            }
        }
        
        contentView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0),
        ])
        
        return contentView
    }
    
    private func titleValue(withTitle title: String, valueLabel: UILabel) -> UIView {
        let stackView = UIStackView.horizontal(8.0)
        
        let titleLabel = BaseLabel()
        
        titleLabel.padding.top = 8.0
        titleLabel.padding.bottom = 8.0
        titleLabel.text = title
        titleLabel.font = .preferredFont(forTextStyle: .body)
        
        stackView.addArrangedSubviews([titleLabel, valueLabel])
        
        return stackView
    }
    
    private func button(withTitle title: String, action: Selector) -> UIView {
        let button = UIButton()
        
        button.setTitle(title, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: action, for: .touchUpInside)
        
        return button
    }
    
    private var separatorView: UIView {
        let view = UIView()
        
        view.backgroundColor = .systemFill
        
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: 1.0)
        ])
        
        return view
    }
    
    func updateUnreadMessages(_ count: Int) {
        unreadMessagesCount = count
        
        updateStatusValues()
    }
    
    func updateAccountStatus(_ isOnline: Bool) {
        self.isOnline = isOnline
        
        updateStatusValues()
    }
    
    private func updateStatusValues() {
        unreadMessagesLabel.text = String(unreadMessagesCount)
        unreadMessagesLabel.textColor = unreadMessagesCount > 0 ? .systemGreen : .systemGray
        
        accountStatusLabel.text = isOnline ? "Online" : "Offline"
        accountStatusLabel.textColor = isOnline ? .systemGreen : .systemRed
    }
    
    @objc
    private func identifyUser() {
        delegate?.identifyUser()
    }
    
    @objc
    private func openChatBox() {
        delegate?.openChatBox()
    }
}

private extension UIStackView {
    @discardableResult
    func addArrangedSubviews(_ subviews: [UIView]) -> UIStackView {
        for subview in subviews {
            addArrangedSubview(subview)
        }
        
        return self
    }
    
    static func vertical(_ spacing: CGFloat) -> UIStackView {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.spacing = spacing
        
        return stackView
    }
    
    static func horizontal(_ spacing: CGFloat) -> UIStackView {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.spacing = spacing
        
        return stackView
    }
}

private class BaseLabel: UILabel {
    var padding: UIEdgeInsets = .zero {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        
        size.width += padding.left + padding.right
        size.height += padding.top + padding.bottom
        
        return size
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        super.textRect(forBounds: bounds.inset(by: padding), limitedToNumberOfLines: numberOfLines)
    }
}
