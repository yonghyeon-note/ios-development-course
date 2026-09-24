//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by Yonghyeon Kim on 9/24/26.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties

    var countries = [String]()

    var score = 0
    var correctAnswer = 0

    private lazy var button1: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "us"), for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.tag = 0
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var button2: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "us"), for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.tag = 1
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var button3: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "us"), for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.tag = 2
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()


    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        countries += [
            "estonia", "france", "germany", "ireland", "italy", "monaco",
            "nigeria", "poland", "russia", "spain", "uk", "us"
        ]

        setupNavigationBar()
        setupButton()
        askQuestion()
    }


    // MARK: - Helpers

    private func setupNavigationBar() {
        self.title = "Guess the Flag"

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    private func setupButton() {
        view.addSubview(button1)
        view.addSubview(button2)
        view.addSubview(button3)

        button1.translatesAutoresizingMaskIntoConstraints = false
        button2.translatesAutoresizingMaskIntoConstraints = false
        button3.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            button1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            button1.widthAnchor.constraint(equalToConstant: 200),
            button1.heightAnchor.constraint(equalToConstant: 100),
            button1.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            button2.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 230),
            button2.widthAnchor.constraint(equalToConstant: 200),
            button2.heightAnchor.constraint(equalToConstant: 100),
            button2.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            button3.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 360),
            button3.widthAnchor.constraint(equalToConstant: 200),
            button3.heightAnchor.constraint(equalToConstant: 100),
            button3.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }

    private func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)

        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)

        title = countries[correctAnswer].uppercased()
    }


    // MARK: - Actions

    @objc func buttonTapped(_ sender: UIButton) {        
        var title: String

        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong"
            score -= 1
        }

        let alertController = UIAlertController(
            title: title,
            message: "Your score is \(score)",
            preferredStyle: .alert
        )

        alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))

        present(alertController, animated: true)
    }

}
