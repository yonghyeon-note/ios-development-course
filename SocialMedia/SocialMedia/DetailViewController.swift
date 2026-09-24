//
//  DetailViewController.swift
//  StormViewer
//
//  Created by Yonghyeon Kim on 9/22/26.
//

import UIKit

final class DetailViewController: UIViewController {

    // MARK: - Properties

    var selectedImage: String?

    private let pictureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()


    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        setupNavigationBar()
        setupImageView()
        loadSelectedImage()
    }


    // MARK: - Helpers

    private func setupNavigationBar() {
        title = selectedImage

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(shareTapped)
        )

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()

        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.tintColor = .label
        navigationController?.navigationBar.standardAppearance = appearance
    }

    private func setupImageView() {
        view.addSubview(pictureImageView)

        pictureImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            pictureImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pictureImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pictureImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pictureImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func loadSelectedImage() {
        if let imageToLoad = selectedImage {
            pictureImageView.image = UIImage(named: imageToLoad)
        }
    }


    // MARK: - Actions

    @objc func shareTapped() {
        guard let image = pictureImageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }

        let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: [])
        activityVC.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem

        present(activityVC, animated: true)
    }

}
