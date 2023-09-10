//
//  ViewController.swift
//  UIKitSamples
//
//  Created by Masato Takamura on 2023/08/13.
//

import UIKit

final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupComponents()
    }
}

//MARK: - UIMenu

extension ViewController {
    private func setupComponents() {
        let menuButton = MenuButton()
        menuButton.textColor = .black
        menuButton.menuContents = [MenuContent(title: "meat", subtitles: []),
                                   MenuContent(title: "fish", subtitles: []),
                                   MenuContent(title: "vegetables", subtitles: []),
                                   MenuContent(title: "fruits", subtitles: ["apple", "banana", "grape"]),]
        menuButton.currentMenuTitle = "menus"
        menuButton.layer.borderWidth = 1.0
        menuButton.layer.borderColor = UIColor.black.cgColor
        menuButton.layer.cornerRadius = 9.0
        menuButton.backgroundColor = .systemBackground
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        menuButton.onMenu = { currentTitle in
            // action code
        }

        view.backgroundColor = .systemBackground
        view.addSubview(menuButton)

        NSLayoutConstraint.activate([
            menuButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            menuButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            menuButton.widthAnchor.constraint(equalToConstant: 120),
            menuButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
}
