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

        let showSemiModalButton = UIButton()
        showSemiModalButton.backgroundColor = .systemOrange
        showSemiModalButton.tintColor = .white
        showSemiModalButton.setTitle("Show Semi-Modal", for: .normal)
        showSemiModalButton.translatesAutoresizingMaskIntoConstraints = false
        showSemiModalButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self else { return }
            // Show Semi-Modal
            let vc = SemiModalViewController()
            if let sheet = vc.sheetPresentationController {
                sheet.detents = [.custom { 0.3 * $0.maximumDetentValue },
                                 .medium(),
                                 .large(),]
                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
                sheet.prefersGrabberVisible = true
                sheet.preferredCornerRadius = 10
                sheet.largestUndimmedDetentIdentifier = .medium
            }
            self.present(vc, animated: true)
        }),
                                      for: .touchUpInside)


        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.alignment = .center
        vStack.spacing = 8.0
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.addArrangedSubview(menuButton)
        vStack.addArrangedSubview(showSemiModalButton)

        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(vStack)

        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            menuButton.widthAnchor.constraint(equalToConstant: 240),
            menuButton.heightAnchor.constraint(equalToConstant: 44),

            showSemiModalButton.widthAnchor.constraint(equalToConstant: 240),
            showSemiModalButton.heightAnchor.constraint(equalToConstant: 44),

            vStack.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            vStack.topAnchor.constraint(equalTo: scrollView.topAnchor),
            vStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
