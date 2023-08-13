//
//  ViewController.swift
//  UIKitSamples
//
//  Created by Masato Takamura on 2023/08/13.
//

import UIKit

final class ViewController: UIViewController {

    private let menuButton = MenuButton()

    private let menus = ["meat", "fish", "vegetables", "fruits"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupComponents()
        setupLayoutConstraints()
    }

    private func setupComponents() {
        menuButton.textColor = .black
        menuButton.titles = menus
        menuButton.currentTitle = "Select menu"
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
    }

    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            menuButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            menuButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            menuButton.widthAnchor.constraint(equalToConstant: 120),
            menuButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
}

