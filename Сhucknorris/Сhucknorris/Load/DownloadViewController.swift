//
//  DownloadViewController.swift
//  Сhucknorris
//
//  Created by Kr Qqq on 05.11.2023.
//

import UIKit

class DownloadViewController: UIViewController {

    private let viewModel: DownloadViewModel
    
    private lazy var downloadButton = CustomButton(title: "Download", buttonAction: ( { self.downloadButtonPressed() } ))
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.hidesWhenStopped = true
        activity.color = .white
        return activity
    }()
    
    init(viewModel: DownloadViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
    }
    
    func addSubviews() {
        view.backgroundColor = .white
        view.addSubview(downloadButton)
        view.addSubview(activityIndicator)
        setupConstraints()
    }
    
    func setupConstraints() {
        
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            downloadButton.heightAnchor.constraint(equalToConstant: 40),
            downloadButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            downloadButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 100),
            downloadButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            downloadButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: downloadButton.centerXAnchor, constant: 60),
            activityIndicator.centerYAnchor.constraint(equalTo: downloadButton.centerYAnchor)
        ])
        
    }
    
    func downloadButtonPressed() {
        downloadButton.isEnabled = false
        activityIndicator.startAnimating()
        viewModel.loadRandom() { [weak self] in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.downloadButton.isEnabled.toggle()
            }
        }
    }

}
