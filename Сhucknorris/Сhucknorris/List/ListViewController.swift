
//
//  Created by Kr Qqq on 11.10.2023.
//

import UIKit

class ListViewController: UIViewController {

    private let viewModel: ListViewModel
    
    private lazy var listTableView: UITableView = {
        let tableView = UITableView(
            frame: .zero
        )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        return tableView
    }()
    
    init(viewModel: ListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.updateQuotes()
        listTableView.reloadData()
        
        listTableView.indexPathsForSelectedRows?.forEach{ indexPath in
            listTableView.deselectRow(
                at: indexPath,
                animated: animated
            )
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        setupConstraints()
        tuneTableView()
    }
    
    private func addSubviews() {
        view.addSubview(listTableView)
        view.backgroundColor = .white
    }
    
    func setupConstraints() {

        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            listTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            listTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            listTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            listTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func tuneTableView() {
        listTableView.dataSource = self
        listTableView.delegate = self
        listTableView.rowHeight = UITableView.automaticDimension
        title = "List"
    }
}

extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.quotesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        let contentQuote = viewModel.selectQuote(selectRow: indexPath.row)
        content.text = contentQuote.title
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        content.secondaryText = dateFormatter.string(from: contentQuote.createdAt)
        cell.contentConfiguration = content
        return cell
    }

}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


