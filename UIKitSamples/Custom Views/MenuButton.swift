//
//  MenuButton.swift
//  UIKitSamples
//
//  Created by Masato Takamura on 2023/08/13.
//

import UIKit

struct MenuContent {
    let title: String
    let subtitles: [String]
}

final class MenuButton: UIControl {
    private let titleLabel = UILabel()
    private let iconImageView = UIImageView()
    private let hStack = UIStackView()

    var menuContents: [MenuContent] = []
    var currentMenuTitle: String? {
        didSet {
            titleLabel.text = currentMenuTitle
        }
    }
    var textColor: UIColor? {
        get {
            titleLabel.textColor
        }
        set {
            titleLabel.textColor = newValue
        }
    }
    var insets: NSDirectionalEdgeInsets {
        get {
            hStack.directionalLayoutMargins
        }
        set {
            hStack.directionalLayoutMargins = newValue
        }
    }
    var onMenu: ((MenuContent) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupComponents()
        setupLayoutConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        UIContextMenuConfiguration(identifier: nil,
                                   previewProvider: nil) { _ in
            UIMenu(title: "",
                   options: .displayInline,
                   children: self.menuContents.map { menuContent in
                if menuContent.subtitles.isEmpty {
                    return UIAction(title: menuContent.title) { _ in
                        self.currentMenuTitle = menuContent.title
                        self.onMenu?(menuContent)
                    }
                } else {
                    return UIMenu(title: menuContent.title,
                                  children: menuContent.subtitles.map { subtitle in
                        UIAction(title: subtitle) { _ in
                            self.currentMenuTitle = subtitle
                            self.onMenu?(menuContent)
                        }
                    })
                }
            })
        }
    }

    private func setupComponents() {
        titleLabel.font = .systemFont(ofSize: 12, weight: .bold)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left

        iconImageView.image = UIImage(systemName: "chevron.down")
        iconImageView.tintColor = titleLabel.textColor
        iconImageView.translatesAutoresizingMaskIntoConstraints = false

        hStack.axis = .horizontal
        hStack.alignment = .center
        hStack.spacing = 8
        hStack.isLayoutMarginsRelativeArrangement = true
        hStack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        hStack.isUserInteractionEnabled = false
        hStack.translatesAutoresizingMaskIntoConstraints = false
        hStack.addArrangedSubview(titleLabel)
        hStack.addArrangedSubview(iconImageView)

        addSubview(hStack)
        addInteraction(UIContextMenuInteraction(delegate: self))
        isContextMenuInteractionEnabled = true
        showsMenuAsPrimaryAction = true
    }

    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.heightAnchor.constraint(equalToConstant: 16),
            iconImageView.widthAnchor.constraint(equalToConstant: 16),

            hStack.topAnchor.constraint(equalTo: topAnchor),
            hStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            hStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            hStack.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
