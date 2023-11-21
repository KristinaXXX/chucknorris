
//
//  Created by Kr Qqq on 11.10.2023.
//

import UIKit

class CategoryViewController: UIViewController {

    private let viewModel: CategoryViewModel
    private let category: CategoryRealm?
    private var isQuotes = false
    
    private lazy var listTableView: UITableView = {
        let tableView = UITableView(
            frame: .zero
        )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        return tableView
    }()
    
    init(viewModel: CategoryViewModel) {
        self.viewModel = viewModel
        self.category = nil
        super.init(nibName: nil, bundle: nil)
        title = "Categories"
    }
    
    init(viewModel: CategoryViewModel, category: CategoryRealm) {
        self.viewModel = viewModel
        self.category = category
        isQuotes = true
        viewModel.setCategory(category: category)
        super.init(nibName: nil, bundle: nil)
        title = category.title
    }
     
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isQuotes {
            viewModel.updateQuotes()
        } else {
            viewModel.updateCategories()
        }
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
    }
}

extension CategoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isQuotes {
            viewModel.quotesCount()
        } else {
            viewModel.categoriesCount()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
       
        if isQuotes {
            let contentQuote = viewModel.selectQuote(selectRow: indexPath.row)
            content.text = contentQuote.title
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            content.secondaryText = dateFormatter.string(from: contentQuote.createdAt)
            cell.accessoryType = .none
        } else {
            let contentCategory = viewModel.selectCategory(selectRow: indexPath.row)
            content.text = contentCategory.title
            cell.accessoryType = .disclosureIndicator
        }
        
        cell.contentConfiguration = content
        return cell
    }
}

extension CategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if !isQuotes {
            let selectCategory = viewModel.selectCategory(selectRow: indexPath.row)
            let nextViewController = CategoryViewController(viewModel: viewModel, category: selectCategory)
            navigationController?.pushViewController(nextViewController, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
