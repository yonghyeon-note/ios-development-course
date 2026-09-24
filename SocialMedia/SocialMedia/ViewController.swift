//
//  ViewController.swift
//  StormViewer
//
//  Created by Yonghyeon Kim on 9/22/26.
//

import UIKit

final class ViewController: UIViewController {

    // MARK: - Properties

    var pictures = [String]()

    private let pictureTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PictureCell")
        return tableView
    }()


    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        loadPictures()
        setupNavigationBar()
        setupTableView()
    }


    // MARK: - Helpers

    private func setupNavigationBar() {
        title = "Storm Viewer"

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
    }

    private func setupTableView() {
        view.addSubview(pictureTableView)

        pictureTableView.dataSource = self
        pictureTableView.delegate = self

        pictureTableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            pictureTableView.topAnchor.constraint(equalTo: view.topAnchor),
            pictureTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            pictureTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            pictureTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func loadPictures() {
        let fileManager = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fileManager.contentsOfDirectory(atPath: path)

        for item in items {
            if item.hasPrefix("nssl") {
                /* This is a picture to load! */
                pictures.append(item)
            }
        }

        print(pictures)
    }

}


// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PictureCell", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }

}


// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.selectedImage = pictures[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }

}
